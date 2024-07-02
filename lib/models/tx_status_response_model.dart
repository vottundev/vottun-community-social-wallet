import 'package:freezed_annotation/freezed_annotation.dart';

part 'tx_status_response_model.freezed.dart';
part 'tx_status_response_model.g.dart';

@freezed
class TxStatusResponseModel with _$TxStatusResponseModel {
  const factory TxStatusResponseModel({
    required String id,
    required String txHash,
    required String status,
    bool? error,
    required int blockchainNetwork,
    required int creationTimestamp,
    required int confirmationTimestamp
}) = _TxStatusResponseModel;

  factory TxStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TxStatusResponseModelFromJson(json);
}
