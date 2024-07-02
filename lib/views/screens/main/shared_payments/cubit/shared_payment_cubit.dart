import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/models/smart_contract_shared_payment.dart';
import 'package:social_wallet/services/local_db/database_helper.dart';
import 'package:social_wallet/utils/app_constants.dart';

import '../../../../../di/injector.dart';
import '../../../../../models/allowance_request_model.dart';
import '../../../../../models/allowance_response_model.dart';
import '../../../../../models/db/shared_payment_response_model.dart';
import '../../../../../models/db/user.dart';
import '../../../../../models/send_tx_request_model.dart';
import '../../../../../utils/config/config_props.dart';

part 'shared_payment_state.dart';

class SharedPaymentCubit extends Cubit<SharedPaymentState> {

  DatabaseHelper dbHelper;
  Web3CoreRepository web3CoreRepository;

  SharedPaymentCubit({required this.dbHelper, required this.web3CoreRepository }) : super(SharedPaymentState());

  Future<void> getUserSharedPayments() async {
    emit(state.copyWith(status: SharedPaymentStatus.loading));
    User? currUser = AppConstants.getCurrentUser();
    if (currUser != null) {
      List<SharedPaymentResponseModel>? result = await dbHelper.retrieveUserSharedPayments(userId: currUser.id ?? 0, isFinished: false);
      List<SharedPaymentResponseModel> resultAux = List.empty(growable: true);

      if (result != null) {
        await Future.forEach(result, (element) async {
          SmartContractSharedPayment? smartContractSharedPayment = await getSharedPaymentInfoFromSC((element.sharedPayment.id ?? 0) - 1, element.sharedPayment.networkId);
          await Future.delayed(const Duration(milliseconds: 800));
          AllowanceResponseModel? allowanceResponse;

          if (element.sharedPayment.currencyAddress != null) {
            allowanceResponse = await getAllowance(
                contractAddress: element.sharedPayment.currencyAddress ?? "",
                networkId: element.sharedPayment.networkId,
                owner: getKeyValueStorage().getUserAddress() ?? "",
                spender: ConfigProps.sharedPaymentCreatorAddress
            );
          }
          //TODO update hasBeenExecuted if true
          if (smartContractSharedPayment != null) {
            if (smartContractSharedPayment.executed == true) {
              await Future.delayed(const Duration(milliseconds: 800));
              await getDbHelper().updateSharedPayment(element.sharedPayment.copyWith(
                  hasBeenExecuted: 1
              ));
            }
          }

          String sharedPayStatus = AppConstants.getSharedPaymentStatus(
              sharedPayment: element,
              allowanceResponseModel: allowanceResponse,
              isExecuted: smartContractSharedPayment?.executed ?? false,
              txCurrNumConfirmation: smartContractSharedPayment?.numConfirmations ?? 0,
              txCurrTotalNumConfirmation: smartContractSharedPayment?.totalNumConfirmations ?? element.sharedPayment.numConfirmations
          );
          resultAux.add(element.copyWith(
              sharedPayment: element.sharedPayment.copyWith(
                  status: sharedPayStatus,
                  hasBeenExecuted: smartContractSharedPayment?.executed == true ? 1 : 0
              )
          ));

        });
      }
      emit(state.copyWith(sharedPaymentResponseModel: resultAux, status: SharedPaymentStatus.success));
    } else {
      emit(state.copyWith(status: SharedPaymentStatus.error, sharedPaymentResponseModel: null));
    }
  }

  Future<AllowanceResponseModel?> getAllowance({
    required String contractAddress,
    required int networkId,
    required String owner,
    required String spender
  }) async {
    try {
      AllowanceResponseModel? response = await getWalletRepository().getWalletAllowance(
          AllowanceRequestModel(
              contractAddress: contractAddress,
              network: networkId,
              owner: owner,
              spender: spender
          )
      );
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<SmartContractSharedPayment?> getSharedPaymentInfoFromSC(int txIndex, int blockchainNetwork) async {
    try {
      List<dynamic>? response = await web3CoreRepository.querySmartContract(SendTxRequestModel(
          blockchainNetwork: blockchainNetwork,
          contractAddress: ConfigProps.sharedPaymentCreatorAddress,
          method: "getSharedPayment",
          params: [txIndex]));

      if (response != null) {
        if (response[3] is bool && response[5] is int && response[4] is int) {
          return SmartContractSharedPayment(
              executed: response[3], numConfirmations: response[5], totalNumConfirmations: response[4]
          );
        }
      }
      return null;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

}
