import 'package:social_wallet/models/available_contract_specs_model.dart';
import 'package:social_wallet/models/deployed_sc_response_model.dart';
import 'package:social_wallet/models/mint_erc721_request_model.dart';
import 'package:social_wallet/models/send_tx_request_model.dart';
import 'package:social_wallet/models/send_tx_response_model.dart';
import 'package:social_wallet/models/smart_contracts_deployed_model.dart';

import '../../models/bc_networks_model.dart';
import '../../models/deploy_smart_contract_model.dart';
import '../../models/tx_status_response_model.dart';
import '../../services/network/api_endpoint.dart';
import '../../services/network/api_service.dart';

class Web3CoreRepository {


  final ApiService _apiService;


  Web3CoreRepository({
    required ApiService apiService
  }) : _apiService = apiService;


  Future<BCNetworksModel?> getAvailableNetworksInfo() async {
    try {
      final response = await _apiService.get(
          endpoint: ApiEndpoint.network(NetworkEndpoint.getAvailableNetworks),
          converter: (response) => BCNetworksModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<TxStatusResponseModel?> getTxStatus({
    required String txHash,
    required int networkId
  }) async {
    try {
      final response = await _apiService.get(
          endpoint: ApiEndpoint.network(NetworkEndpoint.getTxStatus, txHash: txHash, networkId: networkId.toString()),
          converter: (response) => TxStatusResponseModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<DeployedSCResponseModel?> createSmartContractSharedPayment(DeploySmartContractModel deploySmartContractModel) async {
    try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.smartContract(SmartContractEndpoint.deploySmartContract),
          data: deploySmartContractModel.toJson(),
          converter: (response) => DeployedSCResponseModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<DeployedSCResponseModel?> createERC721(SendTxRequestModel sendTxRequestModel) async {
    try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.smartContract(SmartContractEndpoint.deploySmartContract),
          data: sendTxRequestModel.toJson(),
          converter: (response) => DeployedSCResponseModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<SendTxResponseModel?> mintERC721(MintErc721RequestModel mintErc721RequestModel) async {
    try {
      final response = await _apiService.post(
          endpoint: ApiEndpoint.erc721(ERC721Endpoint.mintNft),
          data: mintErc721RequestModel.toJson(),
          converter: (response) => SendTxResponseModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<List<SmartContractsDeployedModel>?> getSmartContractDeployedByContractSpecId(int contractSpecId) async {
    try {
      List<SmartContractsDeployedModel>? response = await _apiService.getList(
          endpoint: ApiEndpoint.vottunProd(VottunProdEndpoint.getContractDeployedSmartContract, contractSpecId: contractSpecId),
          converter: (response) => SmartContractsDeployedModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<List<AvailableContractSpecsModel>?> getAvailableContractSpecs() async {
    try {
      List<AvailableContractSpecsModel>? response = await _apiService.getList(
          endpoint: ApiEndpoint.smartContract(SmartContractEndpoint.getContractSpecs),
          converter: (response) => AvailableContractSpecsModel.fromJson(response)
      );
      return response;
    } catch(ex) {
      return null;
    }
  }

  Future<dynamic> querySmartContract(SendTxRequestModel sendTxRequestModel) async {
    try {
      final response = await _apiService.getFromSmartContract(
          endpoint: ApiEndpoint.smartContract(SmartContractEndpoint.querySmartContract),
          body: sendTxRequestModel.toJson(),
          converter: (response) => response
      );
      return response;
    } catch(ex) {
      return null;
    }
  }
}