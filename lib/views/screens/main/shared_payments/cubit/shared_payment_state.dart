part of 'shared_payment_cubit.dart';


enum SharedPaymentStatus {
  initial, loading, success, error
}

class SharedPaymentState {

  final SharedPaymentStatus status;
  List<SharedPaymentResponseModel>? sharedPaymentResponseModel;

  SharedPaymentState({
    this.status = SharedPaymentStatus.initial,
    this.sharedPaymentResponseModel
  });

  SharedPaymentState copyWith({
    SharedPaymentStatus? status,
    List<SharedPaymentResponseModel>? sharedPaymentResponseModel
  }) {
    return SharedPaymentState(
      status: status ?? this.status,
      sharedPaymentResponseModel: sharedPaymentResponseModel ?? this.sharedPaymentResponseModel
    );
  }
}
