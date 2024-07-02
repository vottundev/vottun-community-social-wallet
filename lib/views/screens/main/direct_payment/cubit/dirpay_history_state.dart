part of 'dirpay_history_cubit.dart';


enum DirPayHistoryStatus {
  initial, loading, success, error
}

class DirPayHistoryState {

  final DirPayHistoryStatus status;

  List<DirectPaymentModel>? dirPaymentHistoryList;


  DirPayHistoryState({
    this.status = DirPayHistoryStatus.initial,
    this.dirPaymentHistoryList
  });

  DirPayHistoryState copyWith({
    DirPayHistoryStatus? status,
    List<DirectPaymentModel>? dirPaymentHistoryList
  }) {
    return DirPayHistoryState(
      status: status ?? this.status,
      dirPaymentHistoryList: dirPaymentHistoryList ?? this.dirPaymentHistoryList
    );
  }
}
