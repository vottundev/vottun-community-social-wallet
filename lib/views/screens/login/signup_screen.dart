

import 'package:flutter/material.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';

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

  //ToggleStateCubit cubitShowPass = getToggleStateCubit();

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
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            AppRouter.pop();
                          },
                          child: Text(
                              "Back",
                              textAlign: TextAlign.start,
                              style: context.bodyTextMedium.copyWith(
                                  fontSize: 20,
                                  color: Colors.blue
                              )
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      labelText: AppConstants.getStrings(context).emailTextInstructions,
                      inputStyle: context.bodyTextLarge,
                      keyboardType: TextInputType.text,
                      floatingText: AppConstants.getStrings(context).emailText,
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: FormValidator.emptyValidator,
                      onTap: () {},
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.03),
                    CustomTextField(
                      labelText: "Username",
                      inputStyle: context.bodyTextLarge,
                      keyboardType: TextInputType.text,
                      floatingText: AppConstants.getStrings(context).emailText,
                      textInputAction: TextInputAction.next,
                      controller: usernameController,
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
                      controller: passwordController,
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
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: ContextUtils(context).screenHeight * 0.01),
                    Row(
                      children: [
                        Expanded(child: getSignupButton()),
                      ],
                    ),
                    SizedBox(height: ContextUtils(context).screenHeight * 0.04),
                  ],
                ),

                //FundedByComponent(),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget getSignupButton() {
    return CustomButton(
      buttonText: "Sign up",
      radius: 15,
      elevation: 2,
      onTap: () async {
        addOrEditUser();
      },
    );
  }

  Future<void> addOrEditUser() async {
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    if (!isEditing) {
      User user = User(
          userEmail: email,
          username: username,
          password: password,
          strategy: 0,
          accountHash: "",
          creationTimestamp: DateTime.timestamp().microsecondsSinceEpoch
      );
      await addUser(user);
    } else {
      //_user.userEmail = email;
      //_user.password = password;
      await updateUser(_user);
    }
  }

  Future<int> addUser(User user) async {
    return await getDbHelper().insertUser(user);
  }

  Future<int?> updateUser(User user) async {
    return await getDbHelper().updateUser(user);
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
