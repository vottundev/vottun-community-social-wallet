import 'package:freezed_annotation/freezed_annotation.dart';

part 'custodied_wallets_info_response.freezed.dart';
part 'custodied_wallets_info_response.g.dart';

@freezed
class CustodiedWalletsInfoResponse with _$CustodiedWalletsInfoResponse {
  const factory CustodiedWalletsInfoResponse({
    required String id,
    required int strategy,
    required String userEmail,
    required String accountHash,
    required int creationTimestamp
}) = _CustodiedWalletsInfoResponse;

  factory CustodiedWalletsInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CustodiedWalletsInfoResponseFromJson(json);
}
