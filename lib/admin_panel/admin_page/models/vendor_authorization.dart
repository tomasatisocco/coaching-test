class VendorAuthorization {
  VendorAuthorization({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.scope,
    this.userId,
    this.refreshToken,
    this.publicKey,
    this.liveMode,
  });

  factory VendorAuthorization.fromJson(Map<String, dynamic> json) {
    return VendorAuthorization(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresAt: json['expires_in'] as int?,
      scope: json['scope'] as String?,
      userId: json['user_id'] as int?,
      refreshToken: json['refresh_token'] as String?,
      publicKey: json['public_key'] as String?,
      liveMode: json['live_mode'] as bool?,
    );
  }

  final String? accessToken;
  final String? tokenType;
  final int? expiresAt;
  final String? scope;
  final int? userId;
  final String? refreshToken;
  final String? publicKey;
  final bool? liveMode;

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresAt,
      'scope': scope,
      'user_id': userId,
      'refresh_token': refreshToken,
      'public_key': publicKey,
      'live_mode': liveMode,
    };
  }
}
