
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';
import 'init_binding.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';

class PicGridApp extends StatelessWidget {
  const PicGridApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetMaterialApp(
        onGenerateTitle: (context) => S.of(context).appTitle,
        getPages: Pages.pages,
        builder: (context, widget) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: TextScaler.noScaling),
            child: widget ?? Container(),
          );
        },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [...S.delegate.supportedLocales],
        debugShowCheckedModeBanner: false,
        initialBinding: InitBinding(),
        initialRoute: Routes.startView,
      ),
    );
  }
}