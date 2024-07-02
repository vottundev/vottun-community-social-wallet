import 'package:freezed_annotation/freezed_annotation.dart';

part 'erc_response.freezed.dart';
part 'erc_response.g.dart';

@freezed
class ErcResponse with _$ErcResponse {
  const factory ErcResponse({
    required String contract,
    required int network,
    required String address,
}) = _ErcResponse;

  factory ErcResponse.fromJson(Map<String, dynamic> json) =>
      _$ErcResponseFromJson(json);
}
