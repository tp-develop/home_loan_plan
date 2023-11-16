import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_loan_plan/constance/AppConstance.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/provider/plan/hlp_plan_state_provider.dart';
import 'package:home_loan_plan/provider/plan/hlp_shared_pref_provider.dart';
import 'package:home_loan_plan/repository/shared_preference_repository/hlp_shared_preference_repository.dart';
import 'package:home_loan_plan/screen/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final planProvider = StateNotifierProvider<HLPPlanStateProvider, List<Plan>>((ref) {
  return HLPPlanStateProvider();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // await SystemChrome.setPreferredOrientations(
  //   Device.get().isTablet
  //       ? [
  //           DeviceOrientation.portraitUp,
  //           DeviceOrientation.landscapeLeft,
  //           DeviceOrientation.landscapeRight,
  //         ]
  //       : [
  //           DeviceOrientation.portraitUp,
  //         ],
  // );

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppConstance.LANGUAGE_TH),
        Locale(AppConstance.LANGUAGE_EN),
      ],
      startLocale: Locale(AppConstance.LANGUAGE_EN),
      path: 'assets/locales',
      saveLocale: true,
      child: ProviderScope(
        overrides: [
          sharedPreferenceRepositoryProvider.overrideWithValue(
            HLPSharedPreferenceRepository(prefs),
          )
        ],
        child: HomeLoanPlanApp(),
      ),
    ),
  );
}

class HomeLoanPlanApp extends StatelessWidget {
  const HomeLoanPlanApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: const Locale(AppConstance.LANGUAGE_EN),
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: getMaterialColor(Colors.black),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey.shade700,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
