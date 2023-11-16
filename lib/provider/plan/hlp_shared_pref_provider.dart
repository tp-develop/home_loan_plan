import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_loan_plan/repository/shared_preference_repository/ab_shared_preference_repository.dart';
import 'package:home_loan_plan/repository/shared_preference_repository/hlp_shared_preference_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<SharedPreferenceRepository> sharedPreferenceRepositoryProvider = Provider<SharedPreferenceRepository>(
  (ref) {
    throw UnimplementedError();
  },
);
