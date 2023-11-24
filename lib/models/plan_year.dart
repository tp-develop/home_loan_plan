// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_loan_plan/models/plan_month.dart';

class PlanYear {
  final int periodNo;
  final List<PlanMonth> planMonthList;
  PlanYear({
    required this.periodNo,
    required this.planMonthList,
  });

  PlanYear copyWith({
    int? periodNo,
    List<PlanMonth>? planMonthList,
  }) {
    return PlanYear(
      periodNo: periodNo ?? this.periodNo,
      planMonthList: planMonthList ?? List.from(this.planMonthList.map((e) => e.copyWith())),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'periodNo': periodNo,
      'planMonthList': planMonthList.map((x) => x.toMap()).toList(),
    };
  }

  factory PlanYear.fromMap(Map<String, dynamic> map) {
    return PlanYear(
      periodNo: map['periodNo']?.toInt() ?? 0,
      planMonthList: List<PlanMonth>.from(map['planMonthList']?.map((x) => PlanMonth.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanYear.fromJson(String source) => PlanYear.fromMap(json.decode(source));

  @override
  String toString() => 'PlanYear(periodNo: $periodNo, planMonthList: $planMonthList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlanYear && other.periodNo == periodNo && listEquals(other.planMonthList, planMonthList);
  }

  @override
  int get hashCode => periodNo.hashCode ^ planMonthList.hashCode;
}
