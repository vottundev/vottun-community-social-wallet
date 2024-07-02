
import 'package:flutter/material.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../../../utils/helpers/form_validator.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';


class CreateWalletBottomDialog extends StatefulWidget {

  const CreateWalletBottomDialog({super.key});

  @override
  _CreateWalletBottomDialogState createState() => _CreateWalletBottomDialogState();
}

class _CreateWalletBottomDialogState extends State<CreateWalletBottomDialog>
    with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Create Wallet",
                          textAlign: TextAlign.center,
                          style: context.bodyTextMedium.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField(
                      labelText: "User email",
                      inputStyle: context.bodyTextLarge,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.emptyValidator,
                      onTap: () {

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                    buttonText: "CREATE",
                    elevation: 3,
                    backgroundColor: Colors.green,
                    onTap: () {
                      AppRouter.pop();
                    }
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
