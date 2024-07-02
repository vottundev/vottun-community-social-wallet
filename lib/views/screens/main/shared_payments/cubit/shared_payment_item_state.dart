part of 'shared_payment_item_cubit.dart';


enum SharedPaymentItemStatus {
  INIT, PENDING, SUCCESS, ERROR
}

class SharedPaymentItemState {

  final SharedPaymentItemStatus status;

  SharedPaymentItemState({
    this.status = SharedPaymentItemStatus.INIT,
  });


  SharedPaymentItemState copyWith({
    SharedPaymentItemStatus? status
  }) {
    return SharedPaymentItemState(
      status: status ?? this.status
    );
  }
}
