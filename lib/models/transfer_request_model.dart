import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_request_model.freezed.dart';
part 'transfer_request_model.g.dart';

@freezed
class TransferRequestModel with _$TransferRequestModel {
  const factory TransferRequestModel({
    required String contractAddress,
    String? sender,
    required String recipient,
    required int network,
    required int amount,
    required int gasLimit,
}) = _TransferRequestModel;

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestModelFromJson(json);
}
