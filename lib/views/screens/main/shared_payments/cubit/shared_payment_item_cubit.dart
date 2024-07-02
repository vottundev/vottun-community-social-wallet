import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/models/tx_status_response_model.dart';

part 'shared_payment_item_state.dart';

class SharedPaymentItemCubit extends Cubit<SharedPaymentItemState> {

  Web3CoreRepository web3coreRepository;

  SharedPaymentItemCubit({required this.web3coreRepository}) : super(SharedPaymentItemState());

  Future<void> getSharedPaymentTxStatus(int networkId, String txHash) async {
    emit(
        state.copyWith(
          status: SharedPaymentItemStatus.INIT
        )
    );
    try {
      TxStatusResponseModel? txStatusResponseModel = await web3coreRepository.getTxStatus(txHash: txHash, networkId: networkId);


    } catch (exception) {
      print(exception);
      emit(state.copyWith(status: SharedPaymentItemStatus.ERROR));
    }
  }
}
