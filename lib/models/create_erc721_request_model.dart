// To parse this JSON data, do
//
//     final createErc721RequestModel = createErc721RequestModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_erc721_request_model.freezed.dart';
part 'create_erc721_request_model.g.dart';

@freezed
class CreateErc721RequestModel with _$CreateErc721RequestModel {
  const factory CreateErc721RequestModel({
    required String name,
    required String symbol,
    required int network,
    required int gasLimit,
    String? alias,
  }) = _CreateErc721RequestModel;

  factory CreateErc721RequestModel.fromJson(Map<String, dynamic> json) => _$CreateErc721RequestModelFromJson(json);
}
