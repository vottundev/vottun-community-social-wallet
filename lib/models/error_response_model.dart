import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_model.freezed.dart';
part 'error_response_model.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    String? code,
    String? message,
}) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
