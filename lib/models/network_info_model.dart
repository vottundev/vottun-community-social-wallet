import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_info_model.freezed.dart';
part 'network_info_model.g.dart';

@freezed
class NetworkInfoModel with _$NetworkInfoModel {
  const factory NetworkInfoModel({
    required int id,
    required String name,
    required String symbol,
    required bool isMainnet,
    String? explorer,
    String? testnetFaucet,
    int? typeId,
    String? typeName
}) = _NetworkInfoModel;

  factory NetworkInfoModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkInfoModelFromJson(json);
}
