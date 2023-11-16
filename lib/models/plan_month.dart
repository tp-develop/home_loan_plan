// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlanMonth {
  final int periodNo;
  final double totalPrice;
  final double installmentPrice;
  final double interestPercent;
  final double interestPrice;
  final double deductionOfPrincipalPrice;
  final double outstandingDebtBalance;

  PlanMonth({
    required this.periodNo,
    required this.totalPrice,
    required this.installmentPrice,
    required this.interestPercent,
    required this.interestPrice,
    required this.deductionOfPrincipalPrice,
    required this.outstandingDebtBalance,
  });

  PlanMonth copyWith({
    int? periodNo,
    double? totalPrice,
    double? installmentPrice,
    double? interestPercent,
    double? interestPrice,
    double? deductionOfPrincipalPrice,
    double? outstandingDebtBalance,
  }) {
    return PlanMonth(
      periodNo: periodNo ?? this.periodNo,
      totalPrice: totalPrice ?? this.totalPrice,
      installmentPrice: installmentPrice ?? this.installmentPrice,
      interestPercent: interestPercent ?? this.interestPercent,
      interestPrice: interestPrice ?? this.interestPrice,
      deductionOfPrincipalPrice: deductionOfPrincipalPrice ?? this.deductionOfPrincipalPrice,
      outstandingDebtBalance: outstandingDebtBalance ?? this.outstandingDebtBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'periodNo': periodNo,
      'totalPrice': totalPrice,
      'installmentPrice': installmentPrice,
      'interestPercent': interestPercent,
      'interestPrice': interestPrice,
      'deductionOfPrincipalPrice': deductionOfPrincipalPrice,
      'outstandingDebtBalance': outstandingDebtBalance,
    };
  }

  factory PlanMonth.fromMap(Map<String, dynamic> map) {
    return PlanMonth(
      periodNo: map['periodNo'] as int,
      totalPrice: map['totalPrice'] as double,
      installmentPrice: map['installmentPrice'] as double,
      interestPercent: map['interestPercent'] as double,
      interestPrice: map['interestPrice'] as double,
      deductionOfPrincipalPrice: map['deductionOfPrincipalPrice'] as double,
      outstandingDebtBalance: map['outstandingDebtBalance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanMonth.fromJson(String source) => PlanMonth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlanMonth(periodNo: $periodNo, totalPrice: $totalPrice, installmentPrice: $installmentPrice, interestPercent: $interestPercent, interestPrice: $interestPrice, deductionOfPrincipalPrice: $deductionOfPrincipalPrice, outstandingDebtBalance: $outstandingDebtBalance)';
  }

  @override
  bool operator ==(covariant PlanMonth other) {
    if (identical(this, other)) return true;

    return other.periodNo == periodNo &&
        other.totalPrice == totalPrice &&
        other.installmentPrice == installmentPrice &&
        other.interestPercent == interestPercent &&
        other.interestPrice == interestPrice &&
        other.deductionOfPrincipalPrice == deductionOfPrincipalPrice &&
        other.outstandingDebtBalance == outstandingDebtBalance;
  }

  @override
  int get hashCode {
    return periodNo.hashCode ^
        totalPrice.hashCode ^
        installmentPrice.hashCode ^
        interestPercent.hashCode ^
        interestPrice.hashCode ^
        deductionOfPrincipalPrice.hashCode ^
        outstandingDebtBalance.hashCode;
  }
}
