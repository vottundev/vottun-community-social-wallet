  part of 'toggle_state_cubit.dart';


enum ToggleStateStatus {
  expanded, notExpanded, loadingList, success
}

class ToggleStateState  {

  final bool isEnabled;

  ToggleStateState({
    this.isEnabled = false
  });

  ToggleStateState copyWith({
    bool? isLoadingScreenLoader,
  }) {
    return ToggleStateState(
        isEnabled: isLoadingScreenLoader ?? this.isEnabled,
    );
  }
}
