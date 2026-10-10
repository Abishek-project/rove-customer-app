/// Build-time configuration, supplied with `--dart-define` or
/// `--dart-define-from-file=dart_defines/local.json`.
///
/// Only public values belong here (the Supabase anon key is public by
/// design). Never pass a service-role key or any other secret.
enum ApiMode { mock, live }

class AppEnv {
  const AppEnv({
    required this.apiMode,
    required this.apiBaseUrl,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.enableDevEmailLogin,
    required this.oauthRedirectUrl,
  });

  factory AppEnv.fromEnvironment() {
    const mode = String.fromEnvironment('API_MODE', defaultValue: 'mock');
    return const AppEnv(
      apiMode: mode == 'live' ? ApiMode.live : ApiMode.mock,
      apiBaseUrl: String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://127.0.0.1:4000',
      ),
      supabaseUrl: String.fromEnvironment('SUPABASE_URL'),
      supabaseAnonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
      enableDevEmailLogin: bool.fromEnvironment('ENABLE_DEV_EMAIL_LOGIN'),
      oauthRedirectUrl: String.fromEnvironment(
        'OAUTH_REDIRECT_URL',
        defaultValue: 'com.rove.customer://login-callback',
      ),
    );
  }

  final ApiMode apiMode;
  final String apiBaseUrl;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool enableDevEmailLogin;
  final String oauthRedirectUrl;

  bool get isMock => apiMode == ApiMode.mock;

  /// Base URL for the versioned REST API.
  String get apiV1Url {
    final base = apiBaseUrl.endsWith('/')
        ? apiBaseUrl.substring(0, apiBaseUrl.length - 1)
        : apiBaseUrl;
    return '$base/api/v1';
  }

  /// Live mode needs Supabase for authentication.
  bool get hasSupabaseConfig =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
