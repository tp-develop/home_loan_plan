import 'package:home_loan_plan/models/plan.dart';

abstract class SharedPreferenceRepository {
  List<Plan> getPlanList();

  Future<bool> savePlanToPref(Plan plan);

  Future<bool> savePlanListToPref(List<Plan> planList);

  Future<bool> deleteAll();

  Future<bool> deleteById(String id);
}
