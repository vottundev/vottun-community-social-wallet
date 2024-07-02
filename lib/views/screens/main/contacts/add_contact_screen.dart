import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/db/user_contact.dart';
import 'package:social_wallet/utils/app_colors.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/contacts/add_contact_item.dart';
import 'package:social_wallet/views/screens/main/contacts/cubit/search_contact_cubit.dart';
import 'package:social_wallet/views/screens/main/contacts/cubit/user_contact_cubit.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';
import 'package:social_wallet/views/widget/top_toolbar.dart';

class AddContactScreen extends StatefulWidget {

  bool emptyFormations = false;

  AddContactScreen({super.key});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> with WidgetsBindingObserver {

  ToggleStateCubit cubit = getToggleStateCubit();
  TextEditingController textFieldController = TextEditingController();
  late List<UserContact> userContactsList;
  
  @override
  void initState() {
    //getSearchContactCubit().getCustomerCustiodedWallets();
    getSearchContactCubit().getAppUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userContactsList = getUserContactCubit().state.userContactList ?? [];
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: TopToolbar(enableBack: true, toolbarTitle: getStrings().addContact),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              children: [
                TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: "test_srs_33@invalidmail.com",
                    hintStyle: context.bodyTextMedium.copyWith(
                      fontSize: 16,
                      color: Colors.grey
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor
                        )
                    ),
                    prefixIcon: const Icon(Icons.search, size: 32, color: AppColors.primaryColor),
                  ),
                  style: context.bodyTextMedium.copyWith(
                    fontSize: 18,
                  ),
                  onChanged: (text) {
                    getSearchContactCubit().getAppUser(searchText: text);
                  },
                ),
                const SizedBox(height: 10),
                BlocListener<UserContactCubit, UserContactState>(
                  bloc: getUserContactCubit(),
                  listener: (context, state) {
                    // TODO: implement listener
                    userContactsList = state.userContactList ?? [];
                  },
                  child: BlocBuilder<SearchContactCubit, SearchContactState>(
                    bloc: getSearchContactCubit(),
                    builder: (context, state) {
                      if (state.userList == null) {
                        return Container();
                      }
                      if (state.userList!.isEmpty) {
                        return Center(
                          child: Text(getStrings().searchByHintText),
                        );
                      }
                      if (state.status == SearchContactStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Expanded(child: SingleChildScrollView(
                        child: Column(
                          children: state.userList!.map((e) {
                            bool contactExist = false;
                            for (var element in userContactsList) {
                              if (element.id == e.id) {
                                contactExist = true;
                              }
                            }
                            return AddContactItem(
                                userContact: e,
                                contactExist: contactExist,
                                onClick: () async {

                                  if (contactExist) {
                                    if (mounted) {
                                      AppConstants.showToast(context, getStrings().contactAlreadyAddedText);
                                    }
                                  } else {
                                    bool success = await getSearchContactCubit().addContact(
                                        context,
                                        userContact: e,
                                        searchText: textFieldController.text
                                    );
                                    if (success) {
                                      await getUserContactCubit().getUserContacts();
                                    }
                                  }
                                }
                            );
                          }
                          ).toList(),
                        ),
                      )
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
