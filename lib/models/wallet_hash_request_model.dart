import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_hash_request_model.freezed.dart';
part 'wallet_hash_request_model.g.dart';

@freezed
class WalletHashRequestModel with _$WalletHashRequestModel {
  const factory WalletHashRequestModel({
    required String username,
    required List<int> strategies,
    required String callbackUrl,
    required String fallbackUrl,
    required String cancelUrl,
}) = _WalletHashRequestModel;

  factory WalletHashRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WalletHashRequestModelFromJson(json);
}
