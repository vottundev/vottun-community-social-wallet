import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_wallet/models/token_balance_model.dart';

part 'owned_token_account_info_model.freezed.dart';
part 'owned_token_account_info_model.g.dart';

@freezed
class OwnedTokenAccountInfoModel with _$OwnedTokenAccountInfoModel {
  const factory OwnedTokenAccountInfoModel({
    required String address,
    required List<TokenBalanceModel> tokenBalances,
}) = _OwnedTokenAccountInfoModel;

  factory OwnedTokenAccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$OwnedTokenAccountInfoModelFromJson(json);
}

