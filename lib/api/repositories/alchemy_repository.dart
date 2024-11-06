import 'package:social_wallet/models/alchemy_request_body.dart';
import 'package:social_wallet/models/owned_nfts_response.dart';
import 'package:social_wallet/models/owned_token_account_info_model.dart';
import 'package:social_wallet/models/token_metadata_model.dart';

import '../../services/network/api_endpoint.dart';
import '../../services/network/api_service.dart';

class AlchemyRepository {

  final ApiService _apiService;


  AlchemyRepository({
    required ApiService apiService
  }) : _apiService = apiService;


  Future<OwnedTokenAccountInfoModel?> getTokenInfoOwnedByAddress({
    required String userAddress,
    required int networkId,
  }) async {
    try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.alchemyBaseUrl(networkId: networkId),
          data: AlchemyRequestBody(
              id: 1,
              jsonrpc: "2.0",
              method: "alchemy_getTokenBalances",
              params: [
                userAddress,
                "erc20"
              ]
          ).toJson(),
          converter: (response) => OwnedTokenAccountInfoModel.fromJson(response["result"])
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<TokenMetadataModel?> getTokenMetadata({
    required String tokenAddress,
    required int networkId
  }) async {
    try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.alchemyBaseUrl(networkId: networkId),
          data: AlchemyRequestBody(
              id: 1,
              jsonrpc: "2.0",
              method: "alchemy_getTokenMetadata",
              params: [
                tokenAddress
              ]
          ).toJson(),
          converter: (response) => TokenMetadataModel.fromJson(response["result"])
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<OwnedNFTsResponse?> getAccountNFTs({
    required String ownerAddress,
    required int networkId
  }) async {
    try {
      final response = await _apiService.get(
          endpoint: ApiEndpoint.alchemy(AlchemyEdpoints.getNFTs, networkId: networkId, address: ownerAddress),
          converter: (response) => OwnedNFTsResponse.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Stream<void> numberStream() async*{
    /*try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.alchemy(networkId: networkId),
          data: AlchemyRequestBody(
              id: 1,
              jsonrpc: "2.0",
              method: "alchemy_getTokenMetadata",
              params: [
                tokenAddress
              ]
          ).toJson(),
          converter: (response) => TokenMetadataModel.fromJson(response["result"])
      );
      yield response;
    } catch(ex) {
      yield null;
    }*/
  }
}