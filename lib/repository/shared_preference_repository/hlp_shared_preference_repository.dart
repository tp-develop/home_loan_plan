import 'dart:convert';
import 'dart:developer';

import 'package:home_loan_plan/constance/shared_pref_constance.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/repository/shared_preference_repository/ab_shared_preference_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HLPSharedPreferenceRepository extends SharedPreferenceRepository {
  late SharedPreferences prefs;

  HLPSharedPreferenceRepository(this.prefs);

  @override
  List<Plan> getPlanList() {
    // TODO: implement getPlanList

    List<dynamic>? jsonList = prefs.getStringList(SharedPrefConstance.PLANS);

    if (jsonList != null) {
      return jsonList.map((jsonString) => Plan.fromJson(jsonDecode(jsonString))).toList();
    } else {
      return [];
    }
  }

  @override
  Future<bool> savePlanToPref(Plan plan) async {
    List<Plan> planList = getPlanList();

    List<String> jsonList = planList.map((obj) => jsonEncode(obj.toJson())).toList();
    jsonList.add(jsonEncode(plan.toJson()));

    return await prefs.setStringList(SharedPrefConstance.PLANS, jsonList);
  }

  @override
  Future<bool> deleteAll() async {
    // TODO: implement deleteAll
    return await prefs.clear();
  }

  @override
  Future<bool> deleteById(String id) async {
    // TODO: implement deleteById
    final List<Plan> planList = getPlanList();

    planList.removeWhere((element) => element.id == id);
    final deleteResult = await deleteAll();

    log('after $planList');
    if (deleteResult) {
      List<String> jsonList = planList.map((obj) => jsonEncode(obj.toJson())).toList();

      return await prefs.setStringList(SharedPrefConstance.PLANS, jsonList);
    }

    return Future.value(false);
  }

  @override
  Future<bool> savePlanListToPref(List<Plan> planList) {
    // TODO: implement savePlanListToPref
    throw UnimplementedError();
  }
}
