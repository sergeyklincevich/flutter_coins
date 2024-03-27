import 'package:flutter/material.dart';
import 'package:flutter_coins/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      initialRoute: "/",
      routes: routes,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
