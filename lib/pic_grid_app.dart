import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';
import 'init_binding.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';
import 'services/ad_visibility_service.dart';
import 'ui/weiget/ad_banner.dart';

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
          return ValueListenableBuilder<bool>(
            valueListenable: AdVisibilityService.instance,
            builder: (context, isSubscribed, _) => MediaQuery(
              data: data.copyWith(textScaler: TextScaler.noScaling),
              child: Column(
                children: [
                  Expanded(child: widget ?? Container()),
                  if (!isSubscribed) const AdBanner(),
                ],
              ),
            ),
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
