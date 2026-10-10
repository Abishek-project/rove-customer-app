/// What the HTTP layer needs from authentication: the current access token,
/// a single refresh attempt, and a way to report an unrecoverable session.
abstract interface class SessionTokenSource {
  String? get accessToken;

  /// Refreshes the session once. Returns the new access token, or null when
  /// the session cannot be refreshed.
  Future<String?> refreshAccessToken();

  /// Called when a 401 survives a refresh: the user must sign in again.
  Future<void> handleSessionExpired();
}
