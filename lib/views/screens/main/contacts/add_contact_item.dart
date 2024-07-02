
import 'package:flutter/material.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../../../models/db/user.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';


class AddContactItem extends StatelessWidget {


  User userContact;
  bool contactExist;
  Function() onClick;

  AddContactItem({super.key,
    required this.userContact,
    required this.contactExist,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onClick();
      },
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
                  height: 45.0,
                  width: 45.0,
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
                    userContact.username ?? "",
                    style: context.bodyTextMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    userContact.userEmail,
                    style: context.bodyTextMedium.copyWith(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  if (AppConstants.trimAddress(address: userContact.accountHash).isNotEmpty) ...[
                    Text(
                      AppConstants.trimAddress(address: userContact.accountHash),
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
            ),
            if (contactExist) ...{
              const Icon(Icons.check, color: Colors.green)
            },
          ],
        ),
      ),
    );
  }

}
