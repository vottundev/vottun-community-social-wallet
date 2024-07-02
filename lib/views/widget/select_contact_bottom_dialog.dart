import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/contacts/cubit/user_contact_cubit.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class SelectContactsBottomDialog extends StatefulWidget {

  bool? isShowedAddUserButton;
  String? bottomButtonText;
  String? title;
  int? excludedId;
  Function()? onClickBottomButton;
  Function(int userId, String contactName, String? address) onClickContact;

  SelectContactsBottomDialog(
      {super.key,
      required this.onClickContact,
      this.onClickBottomButton,
      this.bottomButtonText,
      this.excludedId,
      this.title,
      this.isShowedAddUserButton});

  @override
  _SelectContactsBottomDialogState createState() => _SelectContactsBottomDialogState();
}

class _SelectContactsBottomDialogState extends State<SelectContactsBottomDialog> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    getUserContactCubit().getUserContacts(excludedId: widget.excludedId);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  widget.title ?? getStrings().yourContactsText,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: context.bodyTextMedium.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    AppRouter.pop();
                  },
                  child: Text(getStrings().doneText,
                      textAlign: TextAlign.end,
                      style: context.bodyTextMedium.copyWith(fontSize: 20, color: Colors.blue)),
                ),
              )
            ],
          ),
        ),
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
                          getStrings().emptyContactsMessage,
                          textAlign: TextAlign.center,
                          style: context.bodyTextMedium.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScrollShadow(
                    child: SingleChildScrollView(
                      child: Column(
                          children: state.userContactList!
                              .map((e) => InkWell(
                                    onTap: () {
                                      AppRouter.pop();
                                      widget.onClickContact(e.id ?? 0, e.username, e.address);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.primaryColor),
                                                borderRadius: BorderRadius.circular(50)),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50.0),
                                              //make border radius more than 50% of square height & width
                                              child: Image.asset(
                                                "assets/nano.jpg",
                                                height: 32.0,
                                                width: 32.0,
                                                fit: BoxFit.cover, //change image fill type
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.username,
                                                  maxLines: 1,
                                                  style: context.bodyTextMedium.copyWith(
                                                      fontSize: 16,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                if (AppConstants.trimAddress(address: e.address).isNotEmpty) ...[
                                                  Text(
                                                    AppConstants.trimAddress(address: e.address),
                                                    maxLines: 1,
                                                    style: context.bodyTextMedium.copyWith(
                                                        fontSize: 16,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList()),
                    ),
                  ),
                  Visibility(
                    visible: widget.bottomButtonText != null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                if (widget.onClickBottomButton != null) {
                                  AppRouter.pop();
                                  widget.onClickBottomButton!();
                                }
                              },
                              child: Text(widget.bottomButtonText ?? "",
                                  textAlign: TextAlign.end,
                                  style: context.bodyTextMedium.copyWith(fontSize: 20, color: Colors.blue)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
