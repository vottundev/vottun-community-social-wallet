import 'package:freezed_annotation/freezed_annotation.dart';

part 'alchemy_request_body.freezed.dart';
part 'alchemy_request_body.g.dart';

@freezed
class AlchemyRequestBody with _$AlchemyRequestBody {
  const factory AlchemyRequestBody({
    required int id,
    required String jsonrpc,
    required String method,
    required List<dynamic> params,
}) = _AlchemyRequestBody;

  factory AlchemyRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AlchemyRequestBodyFromJson(json);
}
