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
import '../../../../../models/network_info_model.dart';
import '../../../../../models/send_tx_request_model.dart';
import '../../../../../utils/config/config_props.dart';

part 'shared_payment_history_state.dart';

class SharedPaymentHistoryCubit extends Cubit<SharedPaymentHistoryState> {

  DatabaseHelper dbHelper;
  Web3CoreRepository web3CoreRepository;

  SharedPaymentHistoryCubit({required this.dbHelper, required this.web3CoreRepository }) : super(SharedPaymentHistoryState());

  Future<void> getUserSharedPayments() async {
    emit(state.copyWith(status: SharedPaymentHistoryStatus.loading));
    User? currUser = AppConstants.getCurrentUser();
    if (currUser != null) {
      List<SharedPaymentResponseModel>? result = await dbHelper.retrieveUserSharedPayments(userId: currUser.id ?? 0, isFinished: true);
      List<SharedPaymentResponseModel> resultAux = List.empty(growable: true);

      if (result != null) {
        await Future.forEach(result, (element) async {
          SmartContractSharedPayment? smartContractSharedPayment = await getSharedPaymentInfoFromSC((element.sharedPayment.id ?? 0) - 1, element.sharedPayment.networkId);
          await Future.delayed(const Duration(milliseconds: 800));
          AllowanceResponseModel? allowanceResponse = await getAllowance(
              contractAddress: element.sharedPayment.currencyAddress ?? "",
              networkId: element.sharedPayment.networkId,
              owner: getKeyValueStorage().getUserAddress() ?? "",
              spender: ConfigProps.sharedPaymentCreatorAddress
          );

          String sharedPayStatus = AppConstants.getSharedPaymentStatus(
              sharedPayment: element,
              allowanceResponseModel: allowanceResponse,
              isExecuted: smartContractSharedPayment?.executed ?? false,
              txCurrNumConfirmation: smartContractSharedPayment?.numConfirmations ?? 0,
              txCurrTotalNumConfirmation: smartContractSharedPayment?.totalNumConfirmations ?? element.sharedPayment.numConfirmations
          );
          resultAux.add(element.copyWith(
              sharedPayment: element.sharedPayment.copyWith(
                  status: sharedPayStatus
              )
          ));

        });
      }

      emit(state.copyWith(sharedPaymentResponseModel: resultAux, status: SharedPaymentHistoryStatus.success));
    } else {
      emit(state.copyWith(status: SharedPaymentHistoryStatus.error, sharedPaymentResponseModel: null));
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
