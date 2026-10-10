import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'core/config/app_env.dart';
import 'core/time/zoned_time.dart';
import 'shared/data/api/supabase_auth_repository.dart';

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
    await Supabase.initialize(
      url: env.supabaseUrl,
      publishableKey: env.supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        localStorage: SecureSessionStorage(),
      ),
    );
    deps = AppDependencies.live(env: env, prefs: prefs);
  }

  runApp(RoveApp(deps: deps, textTheme: GoogleFonts.interTextTheme));
}
