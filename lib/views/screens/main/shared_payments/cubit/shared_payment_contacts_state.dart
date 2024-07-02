part of 'shared_payment_contacts_cubit.dart';


enum SharedPaymentContactsStatus {
  initial, loading, success, error
}

class SharedPaymentContactsState {

  final SharedPaymentContactsStatus status;
  double? totalAmount;
  double? allSumAmount;
  List<SharedContactModel>? selectedContactsList;

  SharedPaymentContactsState({
    this.status = SharedPaymentContactsStatus.initial,
    this.totalAmount,
    this.allSumAmount,
    this.selectedContactsList
  });

  SharedPaymentContactsState copyWith({
    SharedPaymentContactsStatus? status,
    double? totalAmount,
    double? allSumAmount,
    List<SharedContactModel>? selectedContactsList
  }) {
    return SharedPaymentContactsState(
        status: status ?? this.status,
        allSumAmount: allSumAmount ?? this.allSumAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        selectedContactsList: selectedContactsList ?? this.selectedContactsList
    );
  }
}
