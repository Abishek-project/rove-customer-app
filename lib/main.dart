import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'app/theme/rove_theme.dart';
import 'core/config/app_env.dart';
import 'core/time/zoned_time.dart';
import 'shared/data/api/supabase_auth_repository.dart';

const _installedKey = 'app.installed';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ZonedTime.ensureInitialized();
  final env = AppEnv.fromEnvironment();
  final prefs = await SharedPreferences.getInstance();

  final AppDependencies deps;
  if (env.isMock) {
    deps = AppDependencies.mock(env: env, prefs: prefs);
  } else {
    if (!env.hasSupabaseConfig) {
      throw StateError(
        'API_MODE=live needs SUPABASE_URL and SUPABASE_ANON_KEY '
        '(see dart_defines/local.example.json).',
      );
    }
    // The iOS keychain outlives the app: drop a session left over from a
    // previous installation so a fresh install starts signed out.
    final sessionStorage = SecureSessionStorage();
    if (!(prefs.getBool(_installedKey) ?? false)) {
      await sessionStorage.removePersistedSession();
      await prefs.setBool(_installedKey, true);
    }
    await Supabase.initialize(
      url: env.supabaseUrl,
      publishableKey: env.supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        localStorage: sessionStorage,
      ),
    );
    deps = AppDependencies.live(env: env, prefs: prefs);
  }

  // Plus Jakarta Sans is bundled (assets/fonts, OFL); nothing is fetched.
  runApp(RoveApp(deps: deps, fontFamily: RoveTheme.fontFamily));
}
