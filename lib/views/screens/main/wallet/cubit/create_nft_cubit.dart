import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/deployed_sc_response_model.dart';
import 'package:social_wallet/models/send_tx_request_model.dart';
import 'package:social_wallet/models/user_nfts_model.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/config/config_props.dart';

import '../../../../../models/db/user.dart';

part 'create_nft_state.dart';

class CreateNftCubit extends Cubit<CreateNftState> {
  Web3CoreRepository web3CoreRepository;

  CreateNftCubit({
    required this.web3CoreRepository,
  }) : super(CreateNftState());

  Future<int?> createERC721({
    required String name,
    required String symbol,
    required String baseUri,
    required double costPerNft,
    required int costPerNftTokenDecimals,
    required int maxSupply,
    required int network,
  }) async {
    try {
      User? currUser = AppConstants.getCurrentUser();
      await Future.delayed(const Duration(seconds: 2));
      DeployedSCResponseModel? response = await web3CoreRepository.createERC721(
          SendTxRequestModel(
              contractSpecsId: ConfigProps.nftContractSpecsId,
              sender: ConfigProps.adminAddress,
              gasLimit: 4000000,
              blockchainNetwork: network,
              params: [
                name,
                symbol,
                baseUri,
                AppConstants.toWei(costPerNft, costPerNftTokenDecimals),
                maxSupply
              ]
          ));

      if (response != null && currUser != null) {
        int? result = await getDbHelper().upsertUserNFT(
            userNfTsModel: UserNfTsModel(
                contractAddress: response.contractAddress,
                creationTxHash: response.txHash,
                ownerAddress: getKeyValueStorage().getUserAddress() ?? "",
                ownerId: currUser.id ?? 0,
                nftName: name,
                nftSymbol: symbol,
                networkId: network,
                creationTimestamp: DateTime.now().millisecondsSinceEpoch)
        );

        return result;
      }
      return null;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  void setSelectedUserNftModel(UserNfTsModel userNfTsModel) {
    emit(state.copyWith(
      selectedUserNftModel: userNfTsModel
    ));
  }

  void setSelectedFile(List<PlatformFile> selectedFiles) {
    emit(state.copyWith(
        selectedFile: selectedFiles
    ));
  }

  Future<List<UserNfTsModel>> getCreatedUserNfts() async {
    try {
      User? currUser = AppConstants.getCurrentUser();
      if (currUser != null) {
        if (currUser.id != null) {
          if (currUser.id != 0) {
            List<UserNfTsModel> response = await getDbHelper().getErc721CreatedByUser(currUser.id ?? 0);
            return response;
          }
        }
      }
      return [];
    } catch (exception) {
      print(exception);
      return [];
    }
  }
}
