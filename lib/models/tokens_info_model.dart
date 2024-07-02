import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_info_model.freezed.dart';
part 'tokens_info_model.g.dart';

@freezed
class TokensInfoModel with _$TokensInfoModel {
  const factory TokensInfoModel({
    required int    networkId,
    required int    decimals,
    required String tokenName,
    required String tokenSymbol,
    String? tokenAddress,
    required String balance,
    required bool isNative,
    required double fiatPrice
}) = _TokensInfoModel;

  factory TokensInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TokensInfoModelFromJson(json);
}
