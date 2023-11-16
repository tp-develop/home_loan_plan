// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:home_loan_plan/models/plan_year.dart';

class Plan {
  final String id;
  final String name;
  final double totalPrice;
  final int periodInstallment;
  final double averageInterest;
  final List<PlanYear> planYearList;
  Plan({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.periodInstallment,
    required this.averageInterest,
    required this.planYearList,
  });

  Plan copyWith({
    String? id,
    String? name,
    double? totalPrice,
    int? periodInstallment,
    double? averageInterest,
    List<PlanYear>? planYearList,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      totalPrice: totalPrice ?? this.totalPrice,
      periodInstallment: periodInstallment ?? this.periodInstallment,
      averageInterest: averageInterest ?? this.averageInterest,
      planYearList: planYearList ?? this.planYearList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      id: map['id'] as String,
      name: map['name'] as String,
      totalPrice: map['totalPrice'] as double,
      periodInstallment: map['periodInstallment'] as int,
      averageInterest: map['averageInterest'] as double,
      planYearList: List<PlanYear>.from(
        (map['planYearList'] as List<dynamic>).map<PlanYear>(
          (x) => PlanYear.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plan(id: $id, name: $name, totalPrice: $totalPrice, periodInstallment: $periodInstallment, averageInterest: $averageInterest, planYearList: $planYearList)';
  }

  @override
  bool operator ==(covariant Plan other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
