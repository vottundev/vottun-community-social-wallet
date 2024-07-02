import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/custodied_wallets_info_response.dart';
import 'package:social_wallet/models/db/user.dart';

import '../../../../../models/db/user_contact.dart';
import '../../../../../utils/app_constants.dart';

part 'search_contact_state.dart';

class SearchContactCubit extends Cubit<SearchContactState> {

  WalletRepository walletRepository;

  SearchContactCubit({
    required this.walletRepository
  }) : super(SearchContactState());

  Future<void> getAppUser({
    String? searchText
  }) async {
    emit(state.copyWith(status: SearchContactStatus.loading));
    if (searchText == null || searchText.isEmpty) {
      emit(
          state.copyWith(
            userList: [],
            status: SearchContactStatus.success,
          )
      );
    } else {
      try {
        User? currUser = AppConstants.getCurrentUser();
        List<User>? response = await getDbHelper().retrieveUsers();
        if (response.isNotEmpty && currUser != null) {
          List<User> filteredList = List.empty(growable: true);

          for (var element in response) {
            if (element.id != currUser.id) {
              String userName = element.username ?? "";
              if (element.userEmail.contains(searchText) || userName.contains(searchText)) {
                filteredList.add(element);
              }
            }
          }

          emit(
              state.copyWith(
                userList: filteredList,
                status: SearchContactStatus.success,
              )
          );
        }
      } catch (error) {
        emit(state.copyWith(status: SearchContactStatus.error));
      }
    }

  }


  Future<bool> addContact(BuildContext context, {
    required User userContact,
    required String searchText
  }) async {
    User? currUser = AppConstants.getCurrentUser();

    if (currUser != null) {
      int? response = await getDbHelper().insertUserContact(
          UserContact(
              id: userContact.id,
              email: userContact.userEmail,
              vottunId: userContact.vottunId,
              userId: currUser.id,
              username: userContact.username ?? "",
              address: userContact.accountHash
          )
      );
      if (response != null) {
        getAppUser(searchText: searchText);
        return true;
      }
    }
    return false;
  }
}
