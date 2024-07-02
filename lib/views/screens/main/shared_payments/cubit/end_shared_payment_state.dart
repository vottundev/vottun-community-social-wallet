part of 'end_shared_payment_cubit.dart';


enum EndSharedPaymentStatus {
  initial, loading, success, error
}

class EndSharedPaymentState {

  final EndSharedPaymentStatus status;
  int? txCurrentNumConfirmations;

  EndSharedPaymentState({
    this.status = EndSharedPaymentStatus.initial,
    this.txCurrentNumConfirmations = 0
  });


  EndSharedPaymentState copyWith({
    EndSharedPaymentStatus? status,
    int? txCurrentNumConfirmations
  }) {
    return EndSharedPaymentState(
      status: status ?? this.status,
      txCurrentNumConfirmations: txCurrentNumConfirmations ?? this.txCurrentNumConfirmations
    );
  }
}
