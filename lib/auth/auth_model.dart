import 'dart:convert';

class AuthResponse {
  AuthResponse({
    required this.email,
    required this.rol,
    required this.token,
  });
  String email;
  String rol;
  String token;

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        email: json["email"],
        rol: json["rol"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "avatar": email,
        "rol": rol,
        "token": token,
      };
}