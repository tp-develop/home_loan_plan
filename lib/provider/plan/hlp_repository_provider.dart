import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_loan_plan/provider/plan/hlp_shared_pref_provider.dart';
import 'package:home_loan_plan/repository/Repository.dart';

final Provider<Repository> repositoryProvider = Provider<Repository>(
  (ref) {
    final sharedPreferenceRepository = ref.watch(sharedPreferenceRepositoryProvider);

    return Repository(sharedPreferenceRepository: sharedPreferenceRepository);
  },
);
