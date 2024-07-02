part of 'wallet_nfts_cubit.dart';


enum WalletNFTsStatus {
  initial, loading, walletCreated, success, error
}

class WalletNFTsState {

  final WalletNFTsStatus status;
  List<OwnedNFTsData>? ownedNFTsList;
  NetworkInfoModel? selectedInfoNetwork;

  WalletNFTsState({
    this.status = WalletNFTsStatus.initial,
    this.ownedNFTsList,
    this.selectedInfoNetwork,
  });

  WalletNFTsState copyWith({
    List<OwnedNFTsData>? ownedNFTsList,
    NetworkInfoModel? selectedInfoNetwork,
    WalletNFTsStatus? status
  }) {
    return WalletNFTsState(
        ownedNFTsList: ownedNFTsList ?? this.ownedNFTsList,
        selectedInfoNetwork: selectedInfoNetwork ?? this.selectedInfoNetwork,
        status: status ?? this.status,
    );
  }
}
