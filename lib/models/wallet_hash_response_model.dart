import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_hash_response_model.freezed.dart';
part 'wallet_hash_response_model.g.dart';

@freezed
class WalletHashResponseModel with _$WalletHashResponseModel {
  const factory WalletHashResponseModel({
    required String hash,
    required int expirationTime,
}) = _WalletHashResponseModel;

  factory WalletHashResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WalletHashResponseModelFromJson(json);
}
