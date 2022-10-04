// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:medical_devices/presentation/Pages/mainPage.dart';
import 'package:medical_devices/presentation/router/app_router.dart';

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());

  var delegate = await LocalizationDelegate.create(fallbackLocale: 'en', supportedLocales: ['en', 'es']);

  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: ValueChangeObserver<bool>(
        cacheKey: 'key-color-mode',
        defaultValue: false,
        builder: (_, isDarkMode, __) => MaterialApp(
          title: 'beHealthApp',
          localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate, localizationDelegate],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          onGenerateRoute: _appRouter.onGenerateRoute,
          theme: isDarkMode
              ? ThemeData.dark().copyWith(
                  primaryColor: Color.fromARGB(255, 213, 94, 85),
                  scaffoldBackgroundColor: Color.fromARGB(255, 16, 16, 16),
                  canvasColor: Color.fromARGB(255, 30, 30, 30),
                  backgroundColor: const Color.fromARGB(255, 48, 48, 48),
                  cardColor: Color.fromARGB(255, 149, 149, 149),
                  focusColor: Color.fromARGB(255, 213, 94, 85),
                  indicatorColor: Colors.white,
                  shadowColor: Color.fromARGB(255, 104, 104, 104),
                  hoverColor: Color.fromARGB(255, 96, 66, 64),
                  highlightColor: Colors.white,
                  hintColor: Color.fromARGB(255, 56, 55, 55),
                  dialogBackgroundColor: Color.fromARGB(255, 226, 226, 226),
                  dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ))
              : ThemeData.light().copyWith(
                  primaryColor: Color.fromARGB(255, 5, 232, 185),
                  scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                  canvasColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  cardColor: Color.fromARGB(255, 30, 61, 72), //For the appbar and nav bar icons
                  focusColor: Color.fromARGB(255, 255, 255, 255),
                  indicatorColor: Color.fromARGB(255, 217, 105, 105),
                  shadowColor: Color.fromARGB(255, 170, 170, 170),
                  hoverColor: Color.fromARGB(255, 253, 225, 187),
                  highlightColor: Colors.black,
                  hintColor: Color.fromARGB(255, 219, 219, 219),
                  dialogBackgroundColor: Color.fromARGB(255, 31, 31, 31),
                  dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  )),
        ),
      ),
    );
  }
}
