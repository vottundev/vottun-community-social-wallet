import 'package:bloc/bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/db/user.dart';
import 'package:social_wallet/models/db/user_contact.dart';

import '../../../../../utils/app_constants.dart';

part 'user_contact_state.dart';

class UserContactCubit extends Cubit<UserContactState> {

  UserContactCubit() : super(UserContactState());

  Future<List<UserContact>?> getUserContactsBase(User currUser) async {
    return await getDbHelper().retrieveUserContact(currUser.id ?? 0);
  }

  Future<void> getUserContacts({int? excludedId}) async {
    emit(state.copyWith(status: UserContactStatus.loading));
    try {
      User? currUser = AppConstants.getCurrentUser();
      if (currUser != null) {
        List<UserContact>? response = await getUserContactsBase(currUser);

        if (response != null) {
          if (excludedId != null) {
            response = response.where((e) => e.id != excludedId && e.address != null).toList();
          } else {
            response = response.where((e) => e.address != null).toList();
          }
          emit(
              state.copyWith(
                userContactList: response,
                status: UserContactStatus.success,
              )
          );
        } else {
          emit(
              state.copyWith(
                userContactList: [],
                status: UserContactStatus.success,
              )
          );
        }
      } else {
        emit(
            state.copyWith(
              userContactList: [],
              status: UserContactStatus.success,
            )
        );
      }

    } catch (error) {
      print(error);
      emit(state.copyWith(status: UserContactStatus.error));
    }
  }

  void deleteContact({required int contactId}) async {
    User? currUser = AppConstants.getCurrentUser();
    if (currUser != null) {
      if (currUser.id != null) {
        int? deletedResponse = await getDbHelper().deleteUserContact(contactId, currUser.id!);
        getUserContactCubit().getUserContacts();
      }
    }
  }
}
