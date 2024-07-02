import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_response_model.dart';

part 'send_tx_response_model.freezed.dart';
part 'send_tx_response_model.g.dart';

@freezed
class SendTxResponseModel with _$SendTxResponseModel {
  const factory SendTxResponseModel({
    required String txHash,
    required int nonce,
    ErrorResponse? error
}) = _SendTxResponseModel;

  factory SendTxResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendTxResponseModelFromJson(json);
}
