import 'package:freezed_annotation/freezed_annotation.dart';

part 'networks_model.freezed.dart';
part 'networks_model.g.dart';

@freezed
class NetworksModel with _$NetworksModel {
  const factory NetworksModel({
    required int networkId,
    required String networkName,
    String? netwrokExplorer
}) = _NetworksModel;

  factory NetworksModel.fromJson(Map<String, dynamic> json) =>
      _$NetworksModelFromJson(json);
}
