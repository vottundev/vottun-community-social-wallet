import 'package:bloc/bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/db/user.dart';
import 'package:social_wallet/models/direct_payment_model.dart';

part 'dirpay_history_state.dart';

class DirPayHistoryCubit extends Cubit<DirPayHistoryState> {

  DirPayHistoryCubit() : super(DirPayHistoryState());

  Future<void> getDirPayHistory() async {
    emit(
      state.copyWith(
        status: DirPayHistoryStatus.loading
      )
    );
    try {
      User? currUser = getKeyValueStorage().getCurrentUser();
      if (currUser != null) {
        List<DirectPaymentModel> dirPaymentHistory = await getDbHelper().retrieveDirectPayments(currUser.id ?? 0) ?? [];

        emit(
            state.copyWith(
                dirPaymentHistoryList: dirPaymentHistory,
                status: DirPayHistoryStatus.success
            )
        );
      } else {
        emit(
            state.copyWith(
                dirPaymentHistoryList: [],
                status: DirPayHistoryStatus.success
            )
        );
      }

    } catch (exception) {
      print(exception);
      emit(state.copyWith(status: DirPayHistoryStatus.error));
    }
  }

}
