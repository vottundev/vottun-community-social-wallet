import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/views/screens/main/main_screen.dart';

import 'login/cubit/auth_cubit.dart';
import 'login/login_screen.dart';

class AppStartupScreen extends StatefulWidget {
  const AppStartupScreen({super.key});

  @override
  _AppStartupScreenState createState() => _AppStartupScreenState();
}

class _AppStartupScreenState extends State<AppStartupScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    getDbHelper().initDB();
    getAuthCubit().getUserAccessTokenValidity();
    getNetworkCubit().getAvailableNetworks();
    WidgetsBinding.instance.addObserver(this);
    if (Platform.isIOS) {
      //initPlugin();
    }
  }

  @override
  void dispose() {
    //don't forget to dispose of it when not needed anymore
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: getAuthCubit(),
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.initial:
            return const Scaffold(
                body: SafeArea(
                    child: Center(
                      child: SpinKitDoubleBounce(color: Colors.blue),
                    )
                )
            );
          case AuthStatus.logged:
            return const MainScreen();
          case AuthStatus.notLogged:
            return LoginScreen();
          default:
            return const Scaffold(
                body: SafeArea(
                    child: Center(
                      child: SpinKitDoubleBounce(color: Colors.blue),
                    )
                )
            );
        }
      },
    );

    /* return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getAuthCubit()),
          BlocProvider.value(value: getLoginCubit())
        ],
        child: BlocBuilder<AuthCubit, AuthState>(
          bloc: getAuthCubit(),
          builder: (context, state) {

            switch(state.status) {
              case AuthStatus.loged:
                return MainScreen();
              case AuthStatus.not_loged:
                return LoginScreen();
              case AuthStatus.init:
                return Scaffold(
                    body: SafeArea(
                        child: Center(
                          child: SpinKitDoubleBounce(color: AppColors.primaryColor),
                        )
                    )
                );
            }
          },
        )
    );*/
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {});
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }
}
