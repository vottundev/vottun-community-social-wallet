import 'package:bloc/bloc.dart';

part 'toggle_state_state.dart';

class ToggleStateCubit extends Cubit<ToggleStateState> {

  ToggleStateCubit() : super(ToggleStateState());

  void toggleState() {
    emit(
      state.copyWith(
          isLoadingScreenLoader: !state.isEnabled
      )
    );
  }


}
