import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_balance_model.freezed.dart';
part 'token_balance_model.g.dart';

@freezed
class TokenBalanceModel with _$TokenBalanceModel {
  const factory TokenBalanceModel({
    required String contractAddress,
    required String tokenBalance
}) = _TokenBalanceModel;

  factory TokenBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceModelFromJson(json);
}
