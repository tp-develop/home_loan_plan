import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_loan_plan/main.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/models/plan_month.dart';
import 'package:home_loan_plan/models/plan_year.dart';
import 'package:home_loan_plan/provider/plan/hlp_repository_provider.dart';

extension PlanExtenstion on WidgetRef {
  List<Plan> get planList => watch(planProvider);

  fetchPlanList() {
    final planList = watch(repositoryProvider).sharedPreferenceRepository.getPlanList();
    read(planProvider.notifier).addPlanList(planList);
  }

  refreshPlanList() {
    refresh(planProvider);
  }

  clearAllPlan() async {
    final result = await read(repositoryProvider).sharedPreferenceRepository.deleteAll();

    if (result) {
      refreshPlanList();
    }
  }

  removePlanById(String id) async {
    final result = await read(repositoryProvider).sharedPreferenceRepository.deleteById(id);

    if (result) {
      fetchPlanList();
    }
  }

  Future<Plan?> createPlan(Plan plan, double installmentPermonth) async {
    Plan planCalculated = _calculatePlan(plan, installmentPermonth);

    log(planCalculated.toString(), name: 'createPlan');
    final saveResult = await read(repositoryProvider).sharedPreferenceRepository.savePlanToPref(planCalculated);

    final planList = read(repositoryProvider).sharedPreferenceRepository.getPlanList();
    if (saveResult) {
      // log('addNew ${plans.sharedPreferenceRepository.getPlanList()}', name: this.runtimeType.toString());
      read(planProvider.notifier).addPlanList(planList);
    }

    return planCalculated;
  }

  Plan _calculatePlan(Plan plan, double installmentPermonth) {
    double totalPrice = plan.totalPrice;
    int totalYear = (plan.periodInstallment / 12).ceil();

    for (var i = 0; i < totalYear; i++) {
      List<PlanMonth> planMonthList = [];

      for (var j = 0; j < 12; j++) {
        double lastBalance = i == 0
            ? j == 0
                ? totalPrice
                : planMonthList[j - 1].outstandingDebtBalance
            : j == 0
                ? plan.planYearList[i - 1].planMonthList[11].outstandingDebtBalance
                : planMonthList[j - 1].outstandingDebtBalance;

        double interestPerMonth = lastBalance * (plan.averageInterest / 100) / 12;

        planMonthList.add(
          PlanMonth(
            periodNo: j + 1,
            totalPrice: lastBalance,
            installmentPrice: installmentPermonth,
            interestPercent: plan.averageInterest,
            interestPrice: interestPerMonth,
            deductionOfPrincipalPrice: installmentPermonth - interestPerMonth,
            outstandingDebtBalance: lastBalance - (installmentPermonth - interestPerMonth),
          ),
        );
      }
      plan.planYearList.add(PlanYear(
        periodNo: i + 1,
        planMonthList: planMonthList,
      ));
    }

    return plan;
  }
}
