part of 'shared_payment_history_cubit.dart';


enum SharedPaymentHistoryStatus {
  initial, loading, success, error
}

class SharedPaymentHistoryState {

  final SharedPaymentHistoryStatus status;
  List<SharedPaymentResponseModel>? sharedPaymentResponseModel;


  SharedPaymentHistoryState({
    this.status = SharedPaymentHistoryStatus.initial,
    this.sharedPaymentResponseModel
  });


  SharedPaymentHistoryState copyWith({
    SharedPaymentHistoryStatus? status,
    NetworkInfoModel? selectedNetwork,
    List<SharedPaymentResponseModel>? sharedPaymentResponseModel
  }) {
    return SharedPaymentHistoryState(
      status: status ?? this.status,
      sharedPaymentResponseModel: sharedPaymentResponseModel ?? this.sharedPaymentResponseModel
    );
  }
}
