part of 'wallet_cubit.dart';


enum WalletStatus {
  initial, loading, walletCreated, success, error
}

class WalletState {

  final WalletStatus status;

  WalletHashResponseModel? walletHashResponseModel;
  NetworkInfoModel? selectedNetwork;
  OwnedTokenAccountInfoModel? ownedTokenAccountInfoModel;
  final String errorMessage;

  WalletState({
    this.status = WalletStatus.initial,
    this.walletHashResponseModel,
    this.ownedTokenAccountInfoModel,
    this.selectedNetwork,
    this.errorMessage = ""
  });

  WalletState copyWith({
    String? errorMessage,
    WalletHashResponseModel? walletHashResponseModel,
    OwnedTokenAccountInfoModel? ownedTokenAccountInfoModel,
    NetworkInfoModel? selectedNetwork,
    WalletStatus? status
  }) {
    return WalletState(
        ownedTokenAccountInfoModel: ownedTokenAccountInfoModel,
        walletHashResponseModel: walletHashResponseModel,
        selectedNetwork: selectedNetwork ?? this.selectedNetwork,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
