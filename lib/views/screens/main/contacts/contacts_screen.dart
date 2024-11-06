import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/contacts/contact_item.dart';
import 'package:social_wallet/views/screens/main/contacts/cubit/user_contact_cubit.dart';

import '../../../widget/custom_button.dart';

class ContactsScreen extends StatefulWidget {
  bool emptyFormations = false;

  ContactsScreen({super.key});

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserContactCubit().getUserContacts();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<UserContactCubit, UserContactState>(
              bloc: getUserContactCubit(),
              builder: (context, state) {
                if (state.userContactList == null || state.userContactList!.isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "You don't have contacts, add new contact to start doing payments!",
                              textAlign: TextAlign.center,
                              style: context.bodyTextMedium.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                        getAddContactButton()
                      ],
                    ),
                  );
                }
                if (state.status == UserContactStatus.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: state.userContactList!.map((e) {
                              return ContactItem(
                                userContact: e,
                                onClick: () {},
                                onConfirmDismiss: (isDeletedConfirmed, contactId) async {
                                  getUserContactCubit().deleteContact(contactId: contactId);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      getAddContactButton()
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddContactButton() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            buttonText: "Add Contact",
            radius: 15,
            padding: const EdgeInsets.symmetric(vertical: 10),
            onTap: () {
              AppRouter.pushNamed(RouteNames.AddContactsScreenRoute.name, onBack: () {
                getUserContactCubit().getUserContacts();
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
