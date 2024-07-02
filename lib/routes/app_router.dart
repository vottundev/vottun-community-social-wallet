import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_wallet/models/db/shared_payment.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/views/screens/configuration/configuration_screen.dart';
import 'package:social_wallet/views/screens/login/otp_screen.dart';
import 'package:social_wallet/views/screens/login/signup_screen.dart';
import 'package:social_wallet/views/screens/main/contacts/add_contact_screen.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payment_select_contacts_screen.dart';
import 'package:social_wallet/views/screens/main/wallet/nft_detail_screen.dart';
import 'package:social_wallet/views/screens/main/wallet/nft_zone/contracts_deployed_screen.dart';

import '../views/screens/app_startup_screen.dart';
import '../views/screens/login/login_screen.dart';
import '../views/screens/main/main_screen.dart';
import '../views/screens/main/wallet/nft_zone/create_nft_main_screen.dart';

//Screens

//Routes

/// A utility class provides basic methods for navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class AppRouter {
  const AppRouter._();

  /// The global key used to access navigator without context
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    //errorPageBuilder: (context, state) => _errorRoute(),
    redirect: (_, __) => null,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: RouteNames.AppStartupScreenRoute.name,
        path: Routes.AppStartupScreenRoute,
        builder: (_, __) => const AppStartupScreen(),
        routes: [
          GoRoute(
              name: RouteNames.LoginScreenRoute.name,
              path: Routes.LoginScreenRoute,
              builder: (_, __) => LoginScreen(),
              routes: [
                GoRoute(
                  name: RouteNames.SignUpScreenRoute.name,
                  path: Routes.SignUpScreenRoute,
                  builder: (_, __) => const SignUpScreen(),
                ),
                GoRoute(
                  name: RouteNames.OtpScreenRoute.name,
                  path: Routes.OtpScreenRoute,
                  builder: (_, state) => OtpScreen(userEmail: state.extra as String),
                ),
              ]),
          GoRoute(
              name: RouteNames.MainScreenRoute.name,
              path: Routes.MainScreenRoute,
              builder: (_, __) => const MainScreen(),
              routes: [
                GoRoute(
                  name: RouteNames.SharedPaymentSelectContacsScreenRoute.name,
                  path: Routes.SharedPaymentSelectContacsScreen,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                      child: SharedPaymentSelectContactsScreen(
                          sharedPayment: state.extra as SharedPayment),
                      transitionsBuilder: transitionLeftToRight),
                ),
                GoRoute(
                  name: RouteNames.ConfigurationScreenRoute.name,
                  path: Routes.ConfigurationScreenRoute,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ConfigurationScreen(),
                      transitionsBuilder: transitionLeftToRight),
                ),
                GoRoute(
                  name: RouteNames.AddContactsScreenRoute.name,
                  path: Routes.AddContactsScreenRoute,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: AddContactScreen(),
                      transitionsBuilder: transitionLeftToRight),
                ),
                GoRoute(
                  name: RouteNames.CreateNftScreenRoute.name,
                  path: Routes.CreateNftScreenRoute,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CreateNftMainScreen(),
                      transitionsBuilder: transitionLeftToRight),
                ),
                GoRoute(
                  name: RouteNames.NFTDetailScreenRoute.name,
                  path: Routes.NFTDetailScreenRoute,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: NFTDetailScreen(),
                      transitionsBuilder: transitionLeftToRight),
                ),
                GoRoute(
                  name: RouteNames.DeployedContractsScreenRoute.name,
                  path: Routes.DeployedContractsScreenRoute,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ContractsDeployedScreen(
                          contractSpecId: state.extra as int),
                      transitionsBuilder: transitionLeftToRight),
                ),
                /*GoRoute(
              name: RouteNames.WeProposeScreenRoute.name,
              path: Routes.WeProposeScreenRoute,
              builder: (_, __) => WeProposeScreen(),
            ),
            GoRoute(
              name: RouteNames.PendingTasksScreenRoute.name,
              path: Routes.PendingTasksScreenRoute,
              builder: (_, __) => PendingTasksScreen(),
            ),
            GoRoute(
              name: RouteNames.ManageDocumentScreenRoute.name,
              path: Routes.ManageDocumentScreenRoute,
              builder: (_, __) => ManageDocumentsScreen(),
            ),*/
              ]),
        ],
      ),
    ],
  );

  static Widget transitionLeftToRight(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const Offset begin = Offset(1.0, 0.0);
    const Offset end = Offset.zero;
    const Curve curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// The name of the route that loads on app startup
  static const String initialRoute = Routes.AppStartupScreenRoute;

  /// This method returns an error page to indicate redirection to an
  /// unknown route.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Route'),
        ),
        body: const Center(
          child: Text('Unknown Route'),
        ),
      ),
    );
  }

  /// This method is used to navigate to a screen using it's name
  static void pushNamed(String routeName, {dynamic args, Function? onBack}) {
    router.pushNamed(routeName, extra: args).then((value) => {
          if (onBack != null) {onBack()} else {value}
        });
  }

  /// This method is used to navigate back to the previous screen.
  ///
  /// The [result] can contain any value that we want to return to the previous
  /// screen.
  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  /// This method is used to navigate all the way back to a specific screen.
  ///
  /// The [routeName] is the name of the screen we want to go back to.
  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  /// This method is used to navigate all the way back to the first screen
  /// shown on startup i.e. the [initialRoute].
  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(initialRoute));
  }

  /// This method is used when the app is navigating using named routes.
  ///
  /// It maps each route name to a specific screen route.
  ///
  /// In case of unknown route name, it returns a route indicating error.
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
