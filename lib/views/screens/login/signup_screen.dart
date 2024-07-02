import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

import '../../../models/db/user.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/helpers/extensions/context_extensions.dart';
import '../../../utils/helpers/form_validator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with WidgetsBindingObserver {
  bool isLoading = false;
  bool isEditing = false;
  late User _user;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ToggleStateCubit signUpButtonState = getToggleStateCubit();

  @override
  void initState() {
    super.initState();
    emailController.text = AppConstants.testEmail;
    usernameController.text = AppConstants.testUsername;
    passwordController.text = AppConstants.testPassword;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              AppRouter.pop();
                            },
                            child: Text(getStrings().backText,
                                textAlign: TextAlign.start,
                                style: context.bodyTextMedium.copyWith(fontSize: 20, color: Colors.blue)),
                          ),
                        ],
                      ),
                      CustomTextField(
                        labelText: getStrings().emailTextInstructions,
                        inputStyle: context.bodyTextLarge,
                        keyboardType: TextInputType.text,
                        floatingText: getStrings().emailText,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        validator: FormValidator.emptyValidator,
                        onTap: () {},
                      ),
                      SizedBox(height: ContextUtils(context).screenHeight * 0.03),
                      CustomTextField(
                        labelText: getStrings().usernameText,
                        inputStyle: context.bodyTextLarge,
                        keyboardType: TextInputType.text,
                        floatingText: getStrings().emailText,
                        textInputAction: TextInputAction.next,
                        controller: usernameController,
                        validator: FormValidator.emptyValidator,
                        onTap: () {},
                      ),
                      SizedBox(height: ContextUtils(context).screenHeight * 0.03),
                      CustomTextField(
                        labelText: getStrings().passwordTextInstructions,
                        isPasswordField: true,
                        inputStyle: context.bodyTextLarge,
                        floatingText: getStrings().passwordText,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.none,
                        controller: passwordController,
                        validator: FormValidator.emptyValidator,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: ContextUtils(context).screenHeight * 0.01),
                  BlocBuilder<ToggleStateCubit, ToggleStateState>(
                    bloc: signUpButtonState,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.isEnabled ? const CircularProgressIndicator() : Expanded(child: getSignupButton()),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: ContextUtils(context).screenHeight * 0.04),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget getSignupButton() {
    return CustomButton(
      buttonText: getStrings().signUpText,
      radius: 15,
      elevation: 2,
      onTap: () async {
        signUpButtonState.toggleState();
        addOrEditUser();
      },
    );
  }

  Future<void> addOrEditUser() async {
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    User user = User(
        userEmail: email,
        username: username,
        password: password,
        strategy: 0,
        accountHash: "",
        creationTimestamp: DateTime.timestamp().microsecondsSinceEpoch);

    int? response = await addUser(user);

    if (response != null) {
      AppRouter.pop();
    } else {
      signUpButtonState.toggleState();
      if (mounted) {
        AppConstants.showToast(context, getStrings().registerErrorMessage);
      }
    }
  }

  Future<int?> addUser(User user) async {
    return await getDbHelper().insertUser(user);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
