import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_otp_response.freezed.dart';
part 'send_otp_response.g.dart';

@freezed
class SendOtpResponse with _$SendOtpResponse {
  const factory SendOtpResponse({
    required String accessToken
}) = _SendOtpResponse;

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseFromJson(json);
}
