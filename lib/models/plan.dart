// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_loan_plan/models/plan_year.dart';

class Plan {
  final String id;
  final String name;
  final double totalPrice;
  final double periodInstallment;
  final double averageInterest;
  final List<PlanYear> planYearList;
  final double averageInstallment;

  Plan({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.periodInstallment,
    required this.averageInterest,
    required this.planYearList,
    required this.averageInstallment,
  });

  Plan copyWith({
    String? id,
    String? name,
    double? totalPrice,
    double? periodInstallment,
    double? averageInterest,
    List<PlanYear>? planYearList,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      totalPrice: totalPrice ?? this.totalPrice,
      periodInstallment: periodInstallment ?? this.periodInstallment,
      averageInterest: averageInterest ?? this.averageInterest,
      planYearList: planYearList ?? List.from(this.planYearList.map((e) => e.copyWith())),
      averageInstallment: averageInterest ?? this.averageInterest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalPrice': totalPrice,
      'periodInstallment': periodInstallment,
      'averageInterest': averageInterest,
      'planYearList': planYearList.map((x) => x.toMap()).toList(),
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      periodInstallment: map['periodInstallment']?.toDouble() ?? 0,
      averageInterest: map['averageInterest']?.toDouble() ?? 0.0,
      planYearList: List<PlanYear>.from(map['planYearList']?.map((x) => PlanYear.fromMap(x)) ?? const []),
      averageInstallment: map['averageInstallment']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Plan(id: $id, name: $name, totalPrice: $totalPrice, periodInstallment: $periodInstallment, averageInterest: $averageInterest, planYearList: $planYearList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plan &&
        other.id == id &&
        other.name == name &&
        other.totalPrice == totalPrice &&
        other.periodInstallment == periodInstallment &&
        other.averageInterest == averageInterest &&
        listEquals(other.planYearList, planYearList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        totalPrice.hashCode ^
        periodInstallment.hashCode ^
        averageInterest.hashCode ^
        planYearList.hashCode;
  }
}
