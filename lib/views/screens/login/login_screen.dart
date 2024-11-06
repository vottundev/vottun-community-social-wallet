import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/helpers/extensions/context_extensions.dart';
import '../../../utils/helpers/form_validator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key}) {
    if (kDebugMode) {
      usernameController.text = AppConstants.testEmail;
      passwordController.text = AppConstants.testPassword;
    }
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {

  bool isLoading = false;
  ToggleStateCubit loadingCubit = getToggleStateCubit();


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/app_icon.jpg", width: 250, height: 150),
                    Text(
                        "SocialWallet",
                        style: context.titleTextMediumW700.copyWith(
                          fontSize: 28
                        ),
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.05),
                    CustomTextField(
                      labelText: AppConstants.getStrings(context).emailTextInstructions,
                      inputStyle: context.bodyTextLarge,
                      keyboardType: TextInputType.text,
                      floatingText: AppConstants.getStrings(context).emailText,
                      textInputAction: TextInputAction.next,
                      controller: widget.usernameController,
                      validator: FormValidator.emptyValidator,
                      onTap: () {},
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.03),
                    CustomTextField(
                      labelText: AppConstants.getStrings(context).passwordTextInstructions,
                      isPasswordField: true,
                      inputStyle: context.bodyTextLarge,
                      floatingText: AppConstants.getStrings(context).passwordText,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.none,
                      controller: widget.passwordController,
                      validator: FormValidator.emptyValidator,
                      /*inputIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              //cubitShowPass.toggleState();
                            },
                            child: SvgPicture.asset("assets/ic_eye.svg",
                                color: AppColors.primaryColor)),
                      ),*/
                      onTap: () {},
                    ),
                    /*BlocBuilder<ToggleStateCubit, ToggleStateState>(
                        bloc: cubitShowPass,
                        builder: (context, state) {
                          return CustomTextField(
                            labelText: AppConstants.getStrings(context).passwordTextInstructions,
                            isPasswordField: !state.isEnabled,
                            inputStyle: context.bodyTextLarge,
                            floatingText: AppConstants.getStrings(context).passwordText,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.none,
                            controller: widget.passwordController,
                            validator: FormValidator.emptyValidator,
                            inputIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    cubitShowPass.toggleState();
                                  },
                                  child: SvgPicture.asset("assets/ic_eye.svg",
                                      color: state.isEnabled
                                          ? AppColors.primaryColor
                                          : null)),
                            ),
                            onTap: () {},
                          );
                        },
                      ),*/
                    SizedBox(height: ContextUtils(context).screenHeight * 0.02),
                    InkWell(
                      onTap: () {

                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppConstants.getStrings(context).forgottenPassText,
                                style: context.titleTextMediumW700.copyWith(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.03),
                    const Row(
                      children: [
                        /*Expanded(
                          child:
                          BlocBuilder<LoginCubit, LoginState>(
                              bloc: getLoginCubit(),
                              builder: (context, state) {
                              switch (state.status) {
                                case LoginStatus.authenticating:
                                  return const SpinKitDoubleBounce(color: AppColors.primaryColor, size: 24);
                                case LoginStatus.initial:
                                case LoginStatus.authenticated:
                                  return getLoginButton();
                                case LoginStatus.fail:
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return IncorrectCredentialsDialog(
                                          title: AppConstants.getStrings(context).incorrectCredentialsTitle,
                                        );
                                      });
                                  return Column(
                                    children: [getLoginButton()],
                                  );
                              }
                            }
                          ),

                        ),*/
                      ],
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getLoginButton(),
                      ],
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.01),
                    Row(
                      children: [
                        Expanded(child: getSignUpButton()),
                      ],
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.04),
                    //FundedByComponent(),
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
          child: CustomButton(
            buttonText: AppConstants.getStrings(context).loginText,
            radius: 15,
            elevation: 2,
            onTap: () async {
              _loginAction();
            },
          ),
        );
      },
    );
  }

  void _loginAction() async {
    loadingCubit.toggleState();
    //todo move to cubit
    String infoToHash = "${widget.usernameController.text}:${widget.passwordController.text}";
    String encoded = base64.encode(utf8.encode(infoToHash));
    //TODO check which error returns or not?
    String? response = await getAuthRepository().loginUser(userAndPassHashed: encoded);
    if (response != null) {
      //TODO set account hash and use model into shared prefs
      AppRouter.pushNamed(RouteNames.OtpScreenRoute.name, args: widget.usernameController.text);
    } else {
      if (mounted) {
        AppConstants.showToast(context, "Incorrect user or password");
      }
    }
    loadingCubit.toggleState();
  }

  Widget getSignUpButton() {
    return CustomButton(
      buttonText: "Sign Up",
      radius: 15,
      inverseColors: true,
      elevation: 2,
      onTap: () async {
        AppRouter.pushNamed(RouteNames.SignUpScreenRoute.name);
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
