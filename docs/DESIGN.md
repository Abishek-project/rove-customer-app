> Copied from the Rove coordination workspace. Third-party reference shots used during design are not included in this repo.

# Rove — Visual Design System v3

> **v3 (2026-10-10):** the customer app keeps the dark blue style (§1–2). The **partner dashboard now has its own reference and its own design (§3)**: a light, bento-grid, black-and-white UI with a neon-green accent. Shared across both: Plus Jakarta Sans, pill shapes, large car photos, and the minimal, quiet chrome.

**User direction (2026-10-10, supersedes v1):** "the ui is not good — i want a modern app and webapp", with the reference
`shared/design/reference-carvon-dark.webp` (open it with your Read tool and study it before restyling).

v2 = a **dark, premium, modern** car-rental look: near-black canvas, soft dark cards, one **sky-blue** accent, big car imagery,
fully rounded pill controls, a floating pill bottom nav, lots of breathing room. Still **minimal**: no gradients on UI chrome,
no glow, no clutter. The car images are the hero; the UI stays quiet around them.

> This replaces the forest-green palette from the original prompts. The brand name stays **Rove**.

## 1. Customer app tokens (Flutter)

### Dark (default)
| Token | Value | Use |
|---|---|---|
| `bg` | `#0B0B0D` | app / page canvas |
| `surface` | `#16161A` | cards, list groups, inputs |
| `surface-2` | `#1E1E23` | raised/hover surfaces, chips, icon circles |
| `surface-3` | `#26262C` | pressed, selected rows |
| `border` | `#2A2A31` | hairlines (use sparingly) |
| `text` | `#F5F5F7` | primary text |
| `text-2` | `#A1A1AA` | secondary text |
| `text-3` | `#6E6E78` | tertiary, placeholders, disabled |
| `accent` | `#4BA3F2` | primary buttons, active nav, selected chip, links, hearts |
| `accent-hover` | `#3A91E0` | hover / pressed |
| `accent-fill` | `#1E78CC` | **fill behind white text/icons** (filled buttons, active nav circle, selected category tile): white on it ≈ 4.6:1 (AA). Coordinator decision 2026-10-10: white on `#4BA3F2` is only ≈ 2.7:1 |
| `accent-tint` | `rgba(75,163,242,0.14)` | selected backgrounds, focus rings |
| `on-accent` | `#FFFFFF` | text/icons on accent |
| `success` / tint | `#34C77B` / `rgba(52,199,123,0.14)` | |
| `warning` / tint | `#F5A524` / `rgba(245,165,36,0.14)` | |
| `danger` / tint | `#F2555A` / `rgba(242,85,90,0.14)` | |
| `info` / tint | `#4BA3F2` / accent-tint | |

### Light (optional theme toggle, same accent)
`bg #F5F6F8 · surface #FFFFFF · surface-2 #F0F1F4 · surface-3 #E7E9ED · border #E3E5EA · text #0B0B0D · text-2 #5B5B66 · text-3 #9A9AA5`.
Dark is the default in both clients. A theme toggle (System / Dark / Light) lives in Settings. Persist the choice locally.

### Shape, spacing, type
* **Radius**: 12 inputs/small tiles · **20 cards** · 24 sheets/hero cards · **full (999) for buttons, search fields, chips, nav pills, icon buttons**.
* **Spacing**: 4 · 8 · 12 · 16 · 20 · 24 · 32 · 48. Screen side padding: 20 (mobile), 32 (web content).
* **Font**: **Plus Jakarta Sans** (bundle it as an asset; don't fetch at runtime). Weights 400 / 500 / 600 / 700.
  Scale: 12 caption · 14 body-sm · 16 body · 18 title-sm · 22 title · 28 headline · 34 display (onboarding hero). Tight letter-spacing (-0.2) on 22+.
* **Elevation**: none on cards (contrast between `bg` and `surface` does the work). Only overlays (sheets, dialogs, menus, the floating nav) get a soft shadow `0 8 30 rgba(0,0,0,0.45)`.
* **Icons**: one outline family. Lucide on web; `lucide_icons_flutter` (or Material Symbols Rounded outlined) on Flutter. 20–22 px, `text-2` colour. Icon buttons sit in 40–44 px **circles** filled `surface-2`.
* **Motion**: 180–240 ms ease-out; hero image transitions between list → details (Flutter `Hero`); subtle scale 0.98 on press. Nothing bouncy.

## 2. Customer app patterns (match the reference)
* **Welcome / onboarding**: full-bleed dark hero image (night road / car), brand wordmark "Rove" + one-line tagline centred low,
  then a filled accent pill **"Get started"** and an outlined pill **"Log in"**. Onboarding carousel pages: big car image on top,
  28–34 px headline ("Premium car rental in Dubai & Mumbai"), one muted line, page dots (active dot = accent), full-width accent pill.
* **Home header**: avatar (40 circle) + "Hi {firstName}" and a location row (pin icon + city + chevron → city picker); bell icon circle on the right.
* **Search**: full-width pill field (`surface`, 52 px tall, search icon right); tapping opens the search screen with dates/filters.
* **Categories**: horizontal row of **square tiles** (88×88, radius 20, `surface`); icon in a white/`surface-2` circle + label below.
  Selected tile = filled `accent` with white label. Categories = Economy, SUV, Sedan, Luxury, Electric (+ "See all").
* **Vehicle card**: `surface` card radius 20, car image on top (transparent-background car, ~16:9 area, not cropped tight),
  heart icon circle top-right (filled accent heart when saved); below a single **spec row** with small icons:
  `⚙ Automatic · 👤 5 seats · ⛽ Petrol` style (use icons, not emoji) and price right-aligned bold `AED 250/day`.
  Title (make model year) above the spec row in 600 weight.
* **Floating bottom nav**: a pill (height 64, radius full, `surface-2` with shadow), floating 16 px above the safe area, centred,
  4 circular icon buttons (Explore, Bookings, Saved, Profile); active = filled accent circle with white icon; others transparent with `text-2` icon. No labels (add semantics labels for accessibility).
* **Vehicle details**: top bar with back (chevron + "Back"), centred title, heart circle. Large hero car image on the dark canvas with a
  soft elliptical floor shadow and an image pager (dots). Then a `surface` sheet with radius 24 top corners: title, partner row
  (logo, name, "Verified" pill), description with "Read more", **spec tiles grid** (3 per row, `surface-2`, radius 16: icon, label in `text-3`, value bold
  e.g. "Seats 5", "Transmission Auto", "Fuel Petrol", "Mileage 250 km/day", "Deposit AED 1,000", "Luggage 3"), policies as a clean list with chevrons,
  pickup location card (address + small static-map-style placeholder or icon; "Open in Maps"), then a **sticky bottom bar**: total for selected dates
  (or "from AED 250/day") on the left, accent pill **"Book now"** on the right.
* **Checkout**: stepper as thin segmented progress at top; each step a dark card; price breakdown as plain rows, hairline above the total;
  "Refundable deposit" separate in `text-2`. Mock payment = bottom sheet styled like a modern wallet sheet.
* **Bookings**: segmented pill tabs (Upcoming, Pending, Active, Completed, Cancelled) scrolling horizontally; booking cards with car thumbnail,
  reference, dates, status pill (tinted background + coloured text).
* **Saved (Wishlist)**: large title "Saved", search icon circle, list of vehicle cards (same card).
* **Profile**: large title "Profile"; user card (avatar 56, name, "Show profile" in `text-2`); grouped settings card(s) with
  rows = icon in a circle + label + chevron (Personal information, Payment methods, Notifications, Language, Country & city, Appearance);
  a second group "Partners" with **"List your fleet on Rove"** (opens the partner portal URL from config); then Help, Privacy, Terms, Log out (danger text).

## 3. Partner dashboard: "bento" design (own reference, supersedes the earlier dark spec for the web)
User sent `shared/design/reference-dashboard-bento-light.webp` as "for dashboard ui reference". Open it with Read and match it closely.

### 3.1 Tokens (Tailwind)
| Token | Light (default) | Dark (toggle) | Use |
|---|---|---|---|
| `canvas` | `#ECECEE` | `#0B0B0C` | page background behind the bento cards |
| `card` | `#FFFFFF` | `#161618` | bento cards |
| `card-muted` | `#F5F5F6` | `#1F1F22` | inner list items, inputs, segmented track, icon circles |
| `ink` | `#0E0E10` | `#F5F5F7` | **primary**: black pill buttons, active segment, dark tiles, toggles ON |
| `on-ink` | `#FFFFFF` | `#0E0E10` | text/icons on `ink` |
| `text` | `#0E0E10` | `#F5F5F7` | |
| `text-2` | `#8B8B92` | `#9A9AA3` | subtitles ("How can i help you?" style) |
| `text-3` | `#B4B4BB` | `#5E5E66` | placeholders, axis labels |
| `line` | `#E7E7EA` | `#2A2A2E` | hairlines (rare) |
| `accent` | `#2EE05A` (neon green) | `#2EE05A` | **indicators only**: map pin, gauge arc, chart bars, live dots, progress. Never as body text on white |
| `accent-soft` | `rgba(46,224,90,0.16)` | same | tinted pills ("Published", "Approved") with `#14873A` text (light) / accent text (dark) |
| `warning` / `danger` | `#F5A524` / `#E5484D` + soft tints | same | e.g. the shield-alert icon in a `danger` soft circle |

Radius: **24 cards**, 16 inner items/tiles, 999 pills (search, buttons, segmented control, toggles, avatar). Gap between bento cards: 16 (desktop), 12 (tablet).
Font: Plus Jakarta Sans (self-hosted). Card titles 18–20/600; big numbers 40–56/600 with tight tracking (like "24° C", "65%"); hero vehicle title 36–40/600 centred with a `text-2` subtitle.
Shadows: none. Flat white cards on a grey canvas. Icons: Lucide, 20–22 px, stroke 1.75.

### 3.2 Shell
* **Top bar** (no heavy sidebar, like the reference): Rove logo mark left → wide **search pill** (`card`, "Type to search…", ⌘K opens a command palette over vehicles, bookings and pages) → "+ Add vehicle" ghost action → right side: **theme toggle as a pill holding two icon circles (moon / sun, active one filled)**, bell in a circle with a green live dot, avatar + business name + chevron menu.
* **Navigation**: a slim floating **left icon rail** (white pill, 64 px wide, rounded-full, icons only with tooltips; active = `ink` filled circle with white icon). It covers the 10 sections. On mobile it becomes a bottom pill bar (same style as the app nav) plus a "More" sheet.
* Page content is a **bento grid** (CSS grid, 12 cols desktop / 6 tablet / 1 mobile) of white cards.

### 3.3 Overview page = the reference layout, mapped to Rove data
| Reference card | Rove card |
|---|---|
| Car Details (big car photo, title, subtitle, R P N D S segmented) | **Fleet spotlight**: large Unsplash photo of a selected vehicle on white, centred "Make Model" + "{year} · {category} · {city}" subtitle, below a **segmented pill** to switch vehicle status filter or vehicle (`Available · Rented · Blocked · Draft` with black active segment), prev/next arrows to cycle vehicles; a "⋮" menu (edit, availability, view bookings) |
| Location (map + black info card with progress) | **Pickups today / next pickup**: a light map-style card (static stylised SVG map of the pickup city, or react-leaflet with OSM tiles + attribution if you prefer; must degrade to the SVG offline), green pin, and a black floating info card: "RV-7K2Q9M · Tesla Model 3 · Dubai Marina, 10:30" with a time progress bar to pickup |
| AI Assistant list (icon, title, subtitle, ×) + input + black "Send" | **Needs attention**: list items in `card-muted` radius 16 (icon, title, subtitle, action) for booking requests awaiting response, expiring documents and vehicles rejected; each with an inline black "Review" pill. Below it, a **quick-find input** (searches bookings/vehicles by reference/plate) with a black "Go" pill. Don't call it AI. AI features come later. |
| Lock/Voice/Bluetooth/Maps/Radar/Music tiles (black & white squares) | **Quick actions** 2×3 tiles alternating `ink` and white: Add vehicle, Availability, Bookings, Pickups & returns, Earnings, Documents (icon + label) |
| Emergency card with toggle | **Instant booking** card: shield/bolt icon in a soft circle, "Instant booking", subtitle "Accept bookings without manual approval", black toggle bound to `PATCH /partner/profile { bookingMode }`, with a confirm dialog |
| Music player card | **Earnings this month**: per-currency card(s), big number, green bar sparkline of daily gross, "Net after commission" line, link to Earnings (if both currencies exist, a currency segmented pill toggles between them; never sum) |
| Climate card (big number + slider) | **Today**: big number of pickups today, with returns due / active rentals as secondary stats and a small timeline scale |
| Fuel Level gauge (green arc %) + ECO toggle | **Fleet utilisation** gauge: green arc %, "{rented}/{published} vehicles on rent", and a small toggle-like pill to switch period (Today/7 days) |

Empty states for new partners: same bento, cards show one line + one black pill action (e.g. "Add your first vehicle").

### 3.4 Other pages (same language)
* **Tables** live inside a white card: no borders between columns, 60 px rows, car photo thumbnail (rounded 12), status as soft pills, row hover `card-muted`, filters as pill chips above, black primary pill on the right.
* **Vehicle form**: left vertical stepper (numbered circles, active = `ink`), right white cards per section; inputs `card-muted` radius 14, 48 px; image uploader with a large dashed drop card plus a thumbnail grid (drag to reorder, "Cover" ink pill).
* **Vehicle detail**: reuse the Fleet-spotlight hero (big photo on white, centred title) and put specs in small bento tiles below.
* **Calendar**: white card, day/week segmented pill (black active), bookings as `ink` bars with white text, maintenance as warning-soft bars, buffers hatched grey, "today" column with a green top marker.
* **Bookings detail**: bento with status timeline, price card, customer card, condition-report cards; actions as black/white pills.
* **Earnings**: big-number cards per currency, green bar chart (rounded bars), transactions table, payouts table.
* **Login**: grey canvas, a centred white card with a large car photo at the top (Unsplash), "Rove for Partners" title, a black "Continue with Google" pill (white Google mark), and the dev email form below a divider when enabled.

## 4. Imagery — real photos from Unsplash (user request: "for car image need good quality image, please take from unsplash")
* **Source**: Unsplash photos under the free **Unsplash License** only (`unsplash.com/photos/...`, served from `images.unsplash.com`).
  **Never** use Unsplash+ / `plus.unsplash.com` (paid licence) or any other site. Record each photo in `CREDITS.md`
  (photo URL, photographer name + profile URL) and in the seed asset manifest. Credit text "Photo by X on Unsplash" in the README credits section.
* **Vehicles**: pick photos that match each seeded vehicle's make/model when one exists, otherwise a clearly matching body type
  (SUV, sedan, sports, hatchback, EV). Prefer **dark / moody / studio or night shots, 3/4 front view, whole car visible**, which suit the dark UI.
  At least 2 images per seeded vehicle (cover + 1–2 more). Download ~1600 px wide JPEG (`?w=1600&q=80&fm=jpg`), store in the backend repo
  (`seed-assets/vehicles/`), and have the seed upload them into the `car-images` bucket with proper `vehicle_images` rows.
* **Hero images** (customer onboarding/welcome, dashboard login): dark night-road / light-trail and a premium dark car shot from Unsplash,
  stored under `shared/design/assets/` with credits; each frontend copies what it needs into its own repo assets.
* **Rendering**: photos are `cover`-cropped inside radius-20 cards with a subtle dark bottom gradient only where text overlays the image;
  on details, the hero is full-width 4:3 with an image pager. Use cached loading with a `surface-2` skeleton and a fallback icon.

### Second reference (described; not saved as a file)
Three phones, same style: (1) onboarding page with "Skip" top-right, a big car photo filling the upper half on the dark canvas, a two-line 28–30 px headline
("Luxury car rental in new york" → ours: "Premium car rental in Dubai & Mumbai"), one muted body line, page dots (active = accent), and a full-width accent pill
"Get Started" at the bottom; (2) the welcome screen with a full-bleed black-and-white night-road light-trail photo, wordmark + tagline, accent "Sign up" pill and outlined "Log in" pill;
(3) the home screen exactly as in §2.

## 5. Non-negotiables kept from v1
One accent colour · whitespace over borders · flat surfaces · quiet status pills · one primary action per screen · accessible contrast (all text ≥ 4.5:1 on its surface; check `text-3` only for non-essential text) · visible focus rings (`accent` 2 px) on web · semantics labels on icon-only buttons.
