import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/send_otp_response.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

import '../../../models/db/user.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/helpers/extensions/context_extensions.dart';
import '../../../utils/helpers/form_validator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class OtpScreen extends StatefulWidget {

  TextEditingController otpCodeController = TextEditingController();
  String userEmail;

  OtpScreen({super.key, required this.userEmail});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with WidgetsBindingObserver {

  bool isLoading = false;
  ToggleStateCubit loadingCubit = getToggleStateCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        getStrings().otpAuthenticationTitle,
                        style: context.titleTextMediumW700.copyWith(
                          fontSize: 28
                        ),
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.05),
                    CustomTextField(
                      labelText: getStrings().otpCodeHint,
                      controller: widget.otpCodeController,
                      inputStyle: context.bodyTextLarge,
                      keyboardType: TextInputType.text,
                      floatingText: getStrings().otpCodeLabelText,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.emptyValidator,
                      onTap: () {},
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getLoginButton(),
                      ],
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.01),
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginButton() {
    return BlocBuilder<ToggleStateCubit, ToggleStateState>(
      bloc: loadingCubit,
      builder: (context, state) {
        if (state.isEnabled) {
          return const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator()
            ],
          );
        }
        return Expanded(
          child: CustomButton (
            buttonText: getStrings().sendText,
            radius: 15,
            elevation: 2,
            onTap: () async {
              loadingCubit.toggleState();
              //todo move to cubit
              SendOtpResponse? response = await getAuthRepository().verifyUserReceivedOtp(otpCode: widget.otpCodeController.text);
              User? user = await getDbHelper().retrieveUserByEmail(widget.userEmail);
              if (response != null && user != null) {
                getKeyValueStorage().setToken(accessToken: response.accessToken);
                getKeyValueStorage().setUserAddress(user.accountHash);
                getKeyValueStorage().setCurrentModel(user);
                AppRouter.pushNamed(RouteNames.MainScreenRoute.name);
              } else {
                if (mounted) {
                  AppConstants.showToast(context, getStrings().incorrectOtpCodeMessage);
                }
              }
              loadingCubit.toggleState();
            },
          ),
        );
      },
    );
  }



  @override
  void dispose() {
    super.dispose();
  }

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   switch (state) {
//     case AppLifecycleState.resumed:
//       setState(() {
//       });
//       break;
//     case AppLifecycleState.inactive:
//       break;
//     case AppLifecycleState.paused:
//       break;
//     case AppLifecycleState.detached:
//       break;
//   }
// }
}
