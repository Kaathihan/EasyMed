import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/view/google_sign_in.dart';
import 'package:reminder/view/home_page.dart';
import 'package:reminder/view/login.dart';
import 'package:reminder/view/reminder_list.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
        localizationsDelegates: [
          FlutterI18nDelegate(
            missingTranslationHandler: (key, locale) {
              print(
                  "MISSING KEY: $key, Language Code: ${locale!.languageCode}");
            },
            translationLoader: FileTranslationLoader(
                useCountryCode: false,
                fallbackFile: 'en',
                basePath: 'assets/i18n'),
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('fr'),
        ],
      ));
}
