part of 'network_selector_cubit.dart';


class NetworkSelectorState {

  NetworkInfoModel? selectedNetwork;

  NetworkSelectorState({
    this.selectedNetwork
  });

  NetworkSelectorState copyWith({
    NetworkInfoModel? selectedNetwork
  }) {
    return NetworkSelectorState(
        selectedNetwork: selectedNetwork ?? this.selectedNetwork
    );
  }
}
