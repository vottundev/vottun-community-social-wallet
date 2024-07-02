import 'package:dio/dio.dart';
import 'package:social_wallet/models/send_otp_req_body.dart';
import 'package:social_wallet/models/send_otp_response.dart';

import '../../services/network/api_endpoint.dart';
import '../../services/network/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<String?> loginUser(
      {required String userAndPassHashed}) async {
    try {
      final response = await _apiService.postVoid(
          endpoint: ApiEndpoint.auth(AuthEndpoint.authorization),
          options: Options(headers: <String, dynamic>{
            'Authorization': 'Basic $userAndPassHashed',
            'requiresAuthToken': false,
          }),
          converter: (response) => response);
      return response;
    } catch (ex) {
      return null;
    }
  }

  Future<SendOtpResponse?> verifyUserReceivedOtp(
      {required String otpCode}) async {
    try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.auth(AuthEndpoint.sendOtp, otpCode: otpCode),
          data: SendOtpReqBody(code: otpCode, remember: false).toJson(),
          requiresAuthToken: false,
          converter: (response) => SendOtpResponse.fromJson(response));
      return response;
    } catch (ex) {
      return null;
    }
  }
}
