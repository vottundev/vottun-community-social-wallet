import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_info_model.dart';

part 'bc_networks_model.freezed.dart';
part 'bc_networks_model.g.dart';

@freezed
class BCNetworksModel with _$BCNetworksModel {
  const factory BCNetworksModel({
    required List<NetworkInfoModel> mainnetNetworks,
    required List<NetworkInfoModel> testnetNetworks,
}) = _BCNetworksModel;

  factory BCNetworksModel.fromJson(Map<String, dynamic> json) =>
      _$BCNetworksModelFromJson(json);
}
