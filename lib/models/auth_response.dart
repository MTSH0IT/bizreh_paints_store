import 'package:bizreh_paints_store/models/user_model.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';

/// Authentication response model
class AuthResponse {
  final String token;
  final String tokenType;
  final UserModel user;

  AuthResponse({
    required this.token,
    this.tokenType = 'Bearer',
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json[JsonKey.token] ?? '',
      tokenType: json[JsonKey.tokenType] ?? 'Bearer',
      user: UserModel.fromJson(json[JsonKey.user] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      JsonKey.token: token,
      JsonKey.tokenType: tokenType,
      JsonKey.user: user.toJson(),
    };
  }
}
