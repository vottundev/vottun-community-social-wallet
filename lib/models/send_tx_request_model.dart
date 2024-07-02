import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_tx_request_model.freezed.dart';
part 'send_tx_request_model.g.dart';

@freezed
class SendTxRequestModel with _$SendTxRequestModel {
  const factory SendTxRequestModel({
    String? contractAddress,
    String? myReference,
    int? contractSpecsId,
    String? recipient,
    String? sender,
    required int blockchainNetwork,
    dynamic value,
    int? gasLimit,
    int? gasPrice,
    int? nonce,
    String? method,
    List<dynamic>? params,
    String? pin
}) = _SendTxRequestModel;

  factory SendTxRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SendTxRequestModelFromJson(json);
}
