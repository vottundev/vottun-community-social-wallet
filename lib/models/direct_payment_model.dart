import 'package:freezed_annotation/freezed_annotation.dart';

part 'direct_payment_model.freezed.dart';
part 'direct_payment_model.g.dart';

@freezed
class DirectPaymentModel with _$DirectPaymentModel {
  const factory DirectPaymentModel({
    int? id,
    required int ownerId,
    required int networkId,
    required int creationTimestamp,
    String? payTokenAddress,
    required String ownerUsername,
    required num payedAmount,
    required String currencyName,
    required String currencySymbol,
}) = _DirectPaymentModel;

  factory DirectPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$DirectPaymentModelFromJson(json);
}
