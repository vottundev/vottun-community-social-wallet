
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../../../di/injector.dart';
import '../../../../models/db/user.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/helpers/form_validator.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';
import '../direct_payment/cubit/send_verification_code_cubit.dart';


class VerificationCodeComponent extends StatelessWidget {

  SendVerificationCodeCubit cubit = getSendVerificationCodeCubit();
  int strategy;
  Function(String? response)? onOTPCodeSent;
  Function(String? value) onWriteCode;
  Function(String value)? onResendedCode;

  VerificationCodeComponent({super.key, this.onOTPCodeSent, required this.strategy, required this.onWriteCode, this.onResendedCode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendVerificationCodeCubit, SendVerificationCodeState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          children: [
            if (strategy == 2) ...[
              Row(
                children: [
                  Text(
                    "${getStrings().twoFAValidationCodeText}: ",
                    maxLines: 1,
                    style: context.bodyTextLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLength: 6,
                  onChanged: (value) {
                    if (value != null) {
                      if (value.length == 6) {
                        onWriteCode(value);
                      }
                    }
                  },
                  validator: FormValidator.emptyValidator)
            ] else ...[
              if (state.status == SendVerificationCodeStatus.initial) ...[
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          buttonText: getStrings().sendVerificationCodeText,
                          radius: 10,
                          backgroundColor: Colors.green,
                          onTap: () async {
                            User? currUser = AppConstants.getCurrentUser();
                            String? response = await cubit.sendOTP(currUser?.userEmail ?? "");

                            if (context.mounted) {
                              if (onOTPCodeSent != null) {
                                onOTPCodeSent!(response);
                              }
                              AppConstants.showToast(context, getStrings().otpEmailSendSuccessMessage);
                            }
                          }),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    Text(
                      "${getStrings().otpValidationCodeText}: ",
                      maxLines: 1,
                      style: context.bodyTextLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: 6,
                    onChanged: (value) {
                      if (value != null) {
                        if (value.length == 6) {
                          onWriteCode(value);
                        }
                      }
                    },
                    validator: FormValidator.emptyValidator
                ),
                const SizedBox(height: 10),
                if (state.status == SendVerificationCodeStatus.successAgain) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () async {
                              User? currUser = AppConstants.getCurrentUser();

                              String? response = await cubit.sendOTP(currUser?.userEmail ?? '', isResend: true);
                              if (response != null && context.mounted) {
                                AppConstants.showToast(context, getStrings().otpEmailSendSuccessMessage);
                                if (onResendedCode != null) {
                                  onResendedCode!(response);
                                }
                              }
                            },
                            child: Text(getStrings().resendText)
                        ),
                      )
                    ],
                  )
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getStrings().singleUseCodeMessage,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: context.bodyTextSmall.copyWith(
                              fontSize: 16,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ],
            ],
          ],
        );
      },
    );
  }
}
