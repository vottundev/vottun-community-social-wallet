import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_otp_req_body.freezed.dart';
part 'send_otp_req_body.g.dart';

@freezed
class SendOtpReqBody with _$SendOtpReqBody {
  const factory SendOtpReqBody({
    required String code,
    required bool remember
}) = _SendOtpReqBody;

  factory SendOtpReqBody.fromJson(Map<String, dynamic> json) =>
      _$SendOtpReqBodyFromJson(json);
}
