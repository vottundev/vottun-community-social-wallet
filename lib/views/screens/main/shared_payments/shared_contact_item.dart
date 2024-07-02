
import 'package:flutter/material.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../../../models/shared_contact_model.dart';
import '../../../../utils/app_colors.dart';


class SharedContactItem extends StatefulWidget {

  SharedContactModel sharedContactModel;
  Function() onClick;

  SharedContactItem({super.key, 
    required this.sharedContactModel,
    required this.onClick
  });

  @override
  _SharedContactItemState createState() => _SharedContactItemState();
}

class _SharedContactItemState extends State<SharedContactItem>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
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
                  height: 42.0,
                  width: 42.0,
                  fit:BoxFit.cover, //change image fill type
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
                  widget.sharedContactModel.contactName,
                  style: context.bodyTextMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                )
            ),
            Text(
              widget.sharedContactModel.amountToPay.toString(),
              textAlign: TextAlign.end,
              style: context.bodyTextMedium.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
