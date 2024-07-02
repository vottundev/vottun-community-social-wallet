
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:social_wallet/models/db/user_contact.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';


class ContactItem extends StatelessWidget {

  UserContact userContact;
  Function() onClick;
  Function(OkCancelResult? isDeletedConfirmed, int userId) onConfirmDismiss;

  ContactItem({super.key,
    required this.userContact,
    required this.onClick,
    required this.onConfirmDismiss,
  });


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(userContact.email),
      background: Container(
        color: AppColors.dissmisableBgColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: Text(
          "Delete",
          style: context.bodyTextMedium.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        OkCancelResult isDeletedConfirmed = await showOkCancelAlertDialog(
            context: context,
            okLabel: "Delete",
            cancelLabel: "Cancel",
            canPop: true,
            title: "Delete user",
            message: "Are you sure that you want to delete this contact?",
            style: Platform.isIOS ? AdaptiveStyle.iOS :  AdaptiveStyle.material,
            fullyCapitalizedForMaterial: false
        );
        if (isDeletedConfirmed.index == 0) {
          onConfirmDismiss(isDeletedConfirmed, userContact.id ?? 0);
          return true;
        }
        return false;
      },
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.1},
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  //make border radius more than 50% of square height & width
                  child: Image.asset(
                    "assets/nano.jpg",
                    height: 42.0,
                    width: 42.0,
                    fit: BoxFit.cover, //change image fill type
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userContact.username,
                    style: context.bodyTextMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    userContact.email,
                    style: context.bodyTextMedium.copyWith(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  if (AppConstants.trimAddress(address: userContact.address).isNotEmpty) ...[
                    Text(
                      AppConstants.trimAddress(address: userContact.address),
                      style: context.bodyTextMedium.copyWith(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
