import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/Splash.dart';
import 'ThemeProvider/theme_provider.dart';
import 'language/AppLocalizationsDelegate.dart';
import 'language/LocalConstant.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main(){
  runApp(MyApp2());
}

class MyApp2 extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);
  const MyApp2({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyApp2State>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> ThemeProvider(),
        builder: (context, _){
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          return GetMaterialApp(
            themeMode: ThemeMode.system,
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            locale: _locale,
            home: Splash(),
            supportedLocales: const [
              Locale('en', ''),
              Locale('bn', ''),
            ],
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },

          );
        }
    );

  }

}