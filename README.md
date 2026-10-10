# Rove — customer app (Flutter)

> Part of **Rove**: [backend (NestJS)](https://github.com/Abishek-project/rove-backend) · [partner dashboard (React)](https://github.com/Abishek-project/rove-partner-dashboard) · [customer app (Flutter)](https://github.com/Abishek-project/rove-customer-app)

Customer mobile app for **Rove**, a car rental marketplace for India (INR) and the UAE (AED).
Customers browse cars from verified rental companies, see the backend-calculated price, book,
pay (mock provider for now) and manage their trips.

* Flutter 3.44 / Dart 3.12 · Material 3 with the Rove design system v2 ([`docs/DESIGN.md`](docs/DESIGN.md)):
  dark by default, sky-blue accent, Plus Jakarta Sans (bundled, OFL), System/Dark/Light toggle.
* State: **flutter_bloc** only (Blocs for event-driven flows, Cubits for simple state).
* Navigation: **GoRouter** with auth redirects and a 4-tab shell (Explore, Bookings, Saved, Profile).
* Networking: **Dio** + typed repositories; models with **freezed** / **json_serializable**.
* Auth: **Supabase Auth** (Google OAuth; email/password only in local dev). Business data only via the
  NestJS API ([`CONTRACTS.md`](https://github.com/Abishek-project/rove-backend/blob/main/docs/CONTRACTS.md)).

## Quick start

```bash
flutter pub get
flutter run --dart-define-from-file=dart_defines/mock.json      # mock mode, no backend needed
```

Mock mode runs against an in-memory backend that returns the exact JSON shapes from
[`CONTRACTS.md`](https://github.com/Abishek-project/rove-backend/blob/main/docs/CONTRACTS.md) (pricing, availability, state machine and cancellation rules included), with
the same premium fleet as the backend seed and bundled photos, so it works fully offline.
Sign in with **Continue with Google** (simulated new user → profile completion) or the dev email form
with `customer@rove.test` / `customer.in@rove.test` (any password).

### Live mode (local backend)

1. Start the backend (`rove-backend`: `npx supabase start`, `npm run start:dev` → `http://localhost:4000`).
2. `cp dart_defines/local.example.json dart_defines/local.json` and paste the **anon** key from
   `npx supabase status` (or `rove-backend/.env.example`). `local.json` is git-ignored.
3. Run:

```bash
flutter run --dart-define-from-file=dart_defines/local.json
```

Seeded accounts: `customer@rove.test` (UAE) and `customer.in@rove.test` (India); the password is
`SEED_USER_PASSWORD` in `rove-backend/.env.example`. Use `http://10.0.2.2:4000` / `:54321` on the
Android emulator.

### Configuration (`--dart-define`)

| Key | Default | Notes |
|---|---|---|
| `API_MODE` | `mock` | `mock` or `live` |
| `API_BASE_URL` | `http://127.0.0.1:4000` | backend origin; `/api/v1` is appended |
| `SUPABASE_URL` | – | required in live mode |
| `SUPABASE_ANON_KEY` | – | public anon key only — never a service-role key |
| `ENABLE_DEV_EMAIL_LOGIN` | `false` | shows the email/password form (local dev only) |
| `OAUTH_REDIRECT_URL` | `com.rove.customer://login-callback` | Supabase redirect |
| `PARTNER_PORTAL_URL` | `http://localhost:5173` | "List your fleet on Rove" |

No secrets are committed; `.env` and `dart_defines/local.json` are git-ignored.

## Google sign-in setup

1. Google Cloud console → create OAuth client IDs (Web for Supabase; iOS/Android optional).
2. Supabase dashboard → Authentication → Providers → Google: paste client id/secret. Locally, set
   `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID/SECRET` in `rove-backend/.env` and enable Google in
   `supabase/config.toml`.
3. Supabase → Authentication → URL configuration → add the redirect URL
   `com.rove.customer://login-callback`.
4. iOS: `ios/Runner/Info.plist` already registers the URL scheme `com.rove.customer`
   (`CFBundleURLTypes`) and sets `FlutterDeepLinkingEnabled=false` so `supabase_flutter` handles the
   callback (PKCE code exchange).
5. Android: `android/app/src/main/AndroidManifest.xml` has the matching intent filter
   (`scheme=com.rove.customer`, `host=login-callback`).

The app opens Google in the browser and shows a "Completing sign-in" screen. Returning without a
session is treated as a cancelled sign-in; an OAuth error in the callback shows a failure notice.
A Google login never counts as identity or licence verification — documents are uploaded separately.

## Architecture

```
lib/
  main.dart                 env → Supabase (live) → DI → RoveApp
  app/                      app.dart (providers, MaterialApp.router), router.dart, router_redirect.dart,
                            routes.dart, di.dart, theme/ (tokens as ThemeExtension, ThemeData)
  core/                     config/ (AppEnv), network/ (ApiClient, interceptors), errors/ (ApiFailure),
                            money/ (Money, INR/AED formatting), time/ (ZonedTime), localization/,
                            preferences/, location/, utils/ (validators, rental period), widgets/
  shared/
    models/                 freezed models mirroring CONTRACTS.md
    repositories/           interfaces (auth, reference, vehicles, favorites, bookings, payments,
                            profile, support)
    data/mock/              MockRoveServer + mock_fixtures.dart (all mock data lives here) + Mock* repos
    data/api/               Api* repos (Dio) + SupabaseAuthRepository
  features/                 onboarding, authentication, home, search, vehicles, booking, payments,
                            trips, favorites, profile, support — each with bloc/ and view/
  l10n/                     app_en.arb (generated from tool/arb_en.py) → gen/
```

Key rules implemented:

* **Prices come from the backend.** The review step shows the `POST /bookings/quote` line items; the
  client never computes a total. Rental charges, the refundable deposit and conditional charges are
  shown separately. Money is integer minor units; INR uses en_IN grouping (`₹1,25,000.00`).
* **Availability** is decided by the backend (`GET /vehicles` with dates); no client-side filtering.
* **No false success.** The result screen is derived only from the booking the backend returns
  (`confirmed`, `pending_partner` + authorised, declined, expired, unavailable, unknown → "check status").
* **Idempotency & double submit.** One `Idempotency-Key` per user action, reused when a network error
  leaves the outcome unknown; book/pay/cancel handlers are `droppable` and buttons show a spinner.
* **Auth & errors.** Bearer token on every call; one refresh-and-retry on 401, then sign-out with a
  "session expired" notice. Error envelopes map to `ApiFailure`; 4xx show the server's message,
  5xx/network show generic localized text. GETs retry twice on transport errors; POSTs never.
* **Only `allowedActions`** are offered on a booking (pay / cancel / contact support). Cancellation
  shows the backend's fee/refund preview in a confirmation dialog first.
* **Times** are shown in the vehicle/city time zone (`timezone` package); requests use UTC ISO strings.
* **Location** is requested only when the customer taps "Use my location".
* **Documents** (licence/ID) are uploaded to `/me/documents` and the temporary copy is deleted.
* **Localization**: all strings in ARB (`tool/arb_en.py` → `lib/l10n/app_en.arb`); layouts use
  directional insets so Arabic (RTL) and Indian languages can be added by adding ARB files.

## Testing

```bash
dart format --set-exit-if-changed lib test
flutter analyze
flutter test                      # unit, bloc and widget tests, all on mocks
```

* `test/core` — money formatting, rental-period rules, form validators, API client (envelope mapping,
  refresh-and-retry, session expiry, retry policy, idempotency header, rate limits), error messages.
* `test/app` — auth redirects; an end-to-end journey through the real router on mocks
  (onboarding → sign-in → search → details → checkout → pay → result → booking detail).
* `test/features` — bloc tests: auth, search/filters/sort/pagination, favorites, checkout
  (verification gate, double submit, quote expiry, unavailable car), payment, cancellation,
  country/currency switching and time zones.
* `test/widgets` — price breakdown, status badges, empty/loading/error states, forms, search results,
  booking result screen.
* `test/live` — opt-in contract test against a running backend (skipped by default):

```bash
LIVE_API_TOKEN=$(tool/live_token.sh customer@rove.test) flutter test test/live --run-skipped
```

Codegen after model changes: `dart run build_runner build`. Strings: edit `tool/arb_en.py`, then
`python3 tool/arb_en.py && flutter gen-l10n`.

## Screenshots

`docs/screenshots/` holds iOS-simulator screenshots: `v2-*` is the current design (DESIGN v2, against
the live backend unless the name says mock), and `live-*` are from the first live integration run
(earlier, lighter design) covering declines, cancellation preview, validation, licence upload and
session expiry.

## Credits

* **Photos** — from [Unsplash](https://unsplash.com) under the free Unsplash License. Welcome and
  onboarding: Jahanzeb Ahsan (night road), Jakob Rosen, Sunder Muthukumaran and Leiada Krozjhen
  (cars). Mock-mode car photos are the same files as the backend seed. Every file, photo URL and
  photographer is listed in [`assets/CREDITS.md`](assets/CREDITS.md).
* **Plus Jakarta Sans** — © The Plus Jakarta Sans Project Authors, SIL Open Font License 1.1
  (`assets/fonts/OFL.txt`).

Refresh the bundled images after the shared assets or the backend seed change:
`python3 tool/sync_design_assets.py`.
