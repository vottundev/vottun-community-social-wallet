import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_wallet/models/contract_metadata_model.dart';
import 'package:social_wallet/models/nft_media_model.dart';
import 'package:social_wallet/models/token_uri_model.dart';

part 'owned_nfts_data.freezed.dart';
part 'owned_nfts_data.g.dart';

@freezed
class OwnedNFTsData with _$OwnedNFTsData {
  const factory OwnedNFTsData({
    required Map<String, String> contract,
    required String balance,
    required String title,
    required String description,
    required TokenUriModel tokenUri,
    required List<NFTMediaModel> media,
    required ContractMetadataModel contractMetadata
}) = _OwnedNFTsData;

  factory OwnedNFTsData.fromJson(Map<String, dynamic> json) =>
      _$OwnedNFTsDataFromJson(json);
}
