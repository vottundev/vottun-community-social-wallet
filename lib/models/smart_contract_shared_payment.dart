import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_contract_shared_payment.freezed.dart';
part 'smart_contract_shared_payment.g.dart';

@freezed
class SmartContractSharedPayment with _$SmartContractSharedPayment {
  const factory SmartContractSharedPayment({
    required bool executed,
    required int numConfirmations,
    required int totalNumConfirmations,
}) = _SmartContractSharedPayment;

  factory SmartContractSharedPayment.fromJson(Map<String, dynamic> json) =>
      _$SmartContractSharedPaymentFromJson(json);
}
