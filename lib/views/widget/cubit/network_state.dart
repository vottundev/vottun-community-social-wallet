part of 'network_cubit.dart';


enum BCNetworksStatus {
  initial, loadingNetworks, success, wrongCredentials, error
}

class BCNetworkState extends Equatable {

  final BCNetworksStatus status;
  BCNetworksModel? availableNetworksList;
  final String errorMessage;

  BCNetworkState({
    this.status = BCNetworksStatus.initial,
    this.availableNetworksList,
    this.errorMessage = ""
  });

  @override
  List<Object> get props => [status, errorMessage];

  BCNetworkState copyWith({
    String? errorMessage,
    BCNetworksModel? availableNetworksList,
    BCNetworksStatus? status
  }) {
    return BCNetworkState(
        errorMessage: errorMessage ?? this.errorMessage,
        availableNetworksList: availableNetworksList ?? this.availableNetworksList,
        status: status ?? this.status
    );
  }
}
