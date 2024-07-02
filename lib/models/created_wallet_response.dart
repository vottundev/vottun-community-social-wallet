import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_wallet_response.freezed.dart';
part 'created_wallet_response.g.dart';

@freezed
class CreatedWalletResponse with _$CreatedWalletResponse {
  const factory CreatedWalletResponse({
    required String accountAddress,
    int? strategy,
}) = _CreatedWalletResponse;

  factory CreatedWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatedWalletResponseFromJson(json);
}
