import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_loan_plan/constance/AppConstance.dart';
import 'package:home_loan_plan/models/dto/staff.dto.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/provider/auth/auth_notifier.dart';
import 'package:home_loan_plan/provider/auth/hive_db_auth_repository.dart';
import 'package:home_loan_plan/provider/plan/hlp_plan_state_provider.dart';
import 'package:home_loan_plan/provider/plan/hlp_shared_pref_provider.dart';
import 'package:home_loan_plan/repository/shared_preference_repository/hlp_shared_preference_repository.dart';
import 'package:home_loan_plan/screen/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final planProvider = StateNotifierProvider<HLPPlanStateProvider, List<Plan>>((ref) {
  return HLPPlanStateProvider();
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, Staff?>((ref) {
  return AuthNotifier();
});

Future<void> loadJsonData(Box box) async {
  final String data = await rootBundle.loadString('assets/storage/data.db.json');
  final dynamic jsonsData = json.decode(data);

  // log(jsonsData.toString(), name: 'loadJsonData');
  for (var jsonData in jsonsData['staff']) {
    final staff = Staff(
      firstName: jsonData['firstName'],
      id: jsonData['id'],
      branchId: jsonData['branchId'],
      username: jsonData['username'],
      lastName: jsonData['lastName'],
      password: jsonData['password'],
      personalId: jsonData['personalId'],
    );

    box.put(staff.username, staff);
  }
}

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StaffAdapter());

  final staffBox = await Hive.openBox('staff');

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await loadJsonData(staffBox);
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

  final user = staffBox.values.toList();

  log('user ${user.map((e) => e.id).toString()}');

  HiveDBAuthRepository authRepository = await HiveDBAuthRepository(boxCollection: [staffBox]);

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
          ),
          authRepositoryProvider.overrideWithValue(authRepository)
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
