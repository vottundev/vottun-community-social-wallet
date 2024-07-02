import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_wallet_info.freezed.dart';
part 'update_user_wallet_info.g.dart';

@freezed
class UpdateUserWalletInfo with _$UpdateUserWalletInfo {
  const factory UpdateUserWalletInfo({
    required int strategy,
    required String accountHash,
  }) = _UpdateUserWalletInfo;

  factory UpdateUserWalletInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserWalletInfoFromJson(json);
}
