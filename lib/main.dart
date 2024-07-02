import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/services/local_storage/key_value_storage_base.dart';
import 'package:social_wallet/utils/app_configuration.dart';
import 'package:social_wallet/utils/locale/app_localization.dart';
import 'package:social_wallet/views/custom_theme.dart';

import 'di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = setDebugPrint;
  await KeyValueStorageBase.init();

  registerDependencyInjection();

  runApp(App(AppConfiguration("es")));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void setDebugPrint(String? message, {int? wrapWidth}) {
  final date = clock.now();
  var msg = '${date.year}/${date.month}/${date.day}';
  msg += ' ${date.hour}:${date.minute}:${date.second}';
  msg += ' $message';
  debugPrintSynchronously(
    msg,
    wrapWidth: wrapWidth,
  );
}


class App extends StatelessWidget {

  final AppConfiguration appConfiguration;
  late AppLocalizationDelegate _localeOverrideDelegate;

  App(this.appConfiguration, {Key? key}): super(key: key) {
    _localeOverrideDelegate = AppLocalizationDelegate(
        Locale(
            appConfiguration.localLanguage ?? "es",
            appConfiguration.localLanguage?.toUpperCase() ?? "ES")
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _localeOverrideDelegate
      ],
      supportedLocales: const [
        Locale('es','ES'),
      ],
      title: 'SocialWallet',
      theme: CustomTheme.mainTheme,
      debugShowCheckedModeBanner: kDebugMode,
      //theme: widget._theme
    );
  }
}




