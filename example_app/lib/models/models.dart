import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class AuthResponse {
  const AuthResponse({
    required this.apiStatus,
    this.userId,
    this.errors,
  });

  final int apiStatus;
  final String? userId;
  final AuthResponseError? errors;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      apiStatus: (json['api_status'] != null && json['api_status'] is int
              ? json['api_status']
              : int.tryParse(json['api_status'] ?? '') ?? 400) ??
          400,
      userId: json['user_id'],
      errors: AuthResponseError.fromJson(
        json['errors'] ?? {"error_text": null},
      ),
    );
  }
}

@JsonSerializable()
class AuthResponseError {
  const AuthResponseError({
    this.errorText,
  });

  final String? errorText;

  factory AuthResponseError.fromJson(Map<String, dynamic> json) {
    return AuthResponseError(errorText: json['error_text']);
  }

  @override
  String toString() {
    return 'AuthResponseError{errorText: $errorText}';
  }
}
