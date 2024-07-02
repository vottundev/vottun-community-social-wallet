import 'package:dio/dio.dart';
import 'package:social_wallet/models/allowance_request_model.dart';
import 'package:social_wallet/models/allowance_response_model.dart';
import 'package:social_wallet/models/send_tx_request_model.dart';
import 'package:social_wallet/models/send_tx_response_model.dart';
import 'package:social_wallet/models/wallet_hash_request_model.dart';
import 'package:social_wallet/models/wallet_hash_response_model.dart';

import '../../models/custodied_wallets_info_response.dart';
import '../../services/network/api_endpoint.dart';
import '../../services/network/api_service.dart';

class WalletRepository {

  final ApiService _apiService;

  WalletRepository({
    required ApiService apiService
  }) : _apiService = apiService;


  Future<WalletHashResponseModel?> getNewHash({
    required WalletHashRequestModel walletHashRequestModel,
  }) async {
    try {
      final response = await _apiService.post(
          data: walletHashRequestModel.toJson(),
          endpoint: ApiEndpoint.custWallet(CustodiedWalletEndpoint.getNewHash),
          converter: (response) => WalletHashResponseModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<SendTxResponseModel?> sendTx({
    required SendTxRequestModel reqBody,
    required int strategy
  }) async {
    try {
      return await _apiService.post(
          endpoint: ApiEndpoint.custWallet(CustodiedWalletEndpoint.sendTransaction, strategy: strategy),
          data: reqBody.toJson(),
          converter: (response) => SendTxResponseModel.fromJson(response)
      );
    } on DioException catch(exception) {
      return null;
    }
  }

  Future<SendTxResponseModel?> sendNativeTx({
    required SendTxRequestModel reqBody,
    required int strategy
  }) async {
    try {
      return await _apiService.post(
          endpoint: ApiEndpoint.custWallet(CustodiedWalletEndpoint.sendTxFromCustodiedWallet, strategy: strategy),
          data: reqBody.toJson(),
          converter: (response) => SendTxResponseModel.fromJson(response)
      );
    } catch(ex) {
      return null;
    }
  }

  //todo make call paginated and adapt search to paginated list
  Future<List<CustodiedWalletsInfoResponse>?> getCustomerCustodiedWallets({
    String? userEmail
  }) async {
    try {
      final response = await _apiService.getList(
          endpoint: ApiEndpoint.custWallet(CustodiedWalletEndpoint.getCustodiedWallets),
          requiresAuthToken: true,
          converter: CustodiedWalletsInfoResponse.fromJson
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<AllowanceResponseModel?> getWalletAllowance(AllowanceRequestModel allowanceRequestModel) async {
    try {
      final response = await _apiService.get(
          endpoint: ApiEndpoint.erc20(ERC20Endpoint.getAllowance),
          body: allowanceRequestModel.toJson(),
          converter: (response) => AllowanceResponseModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<String?> sendOTPCode({
    required String userEmail
  }) async {
    try {
      final response = await _apiService.postVoid(
          endpoint: ApiEndpoint.custWallet(CustodiedWalletEndpoint.sendOTP, userEmail: userEmail),
          converter: (response) => response,
          data: {}
      );
      return response;
    } catch(ex) {
      return null;
    }
  }
}