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
      planMonthList: planMonthList ?? this.planMonthList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'periodNo': periodNo,
      'planMonthList': planMonthList.map((x) => x.toMap()).toList(),
    };
  }

  factory PlanYear.fromMap(Map<String, dynamic> map) {
    return PlanYear(
      periodNo: map['periodNo'] as int,
      planMonthList: List<PlanMonth>.from(
        (map['planMonthList'] as List<dynamic>).map<PlanMonth>(
          (x) => PlanMonth.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanYear.fromJson(String source) => PlanYear.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlanYear(periodNo: $periodNo, planMonthList: $planMonthList)';

  @override
  bool operator ==(covariant PlanYear other) {
    if (identical(this, other)) return true;

    return other.periodNo == periodNo && listEquals(other.planMonthList, planMonthList);
  }

  @override
  int get hashCode => periodNo.hashCode ^ planMonthList.hashCode;
}
