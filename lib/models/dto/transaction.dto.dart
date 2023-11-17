// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:home_loan_plan/models/dto/currency_unit.dto.dart';

@HiveType(typeId: 4)
class Transaction extends HiveObject {
  @HiveField(0)
  int timestamp;

  @HiveField(1)
  String customerId;

  @HiveField(2)
  String staffId;

  @HiveField(3)
  String branchId;

  @HiveField(4)
  double tax;

  @HiveField(5)
  double rateBuy;

  @HiveField(6)
  double rateSell;

  @HiveField(7)
  CurrencyUnit currencyBuy;

  @HiveField(8)
  CurrencyUnit currencySell;

  @HiveField(9)
  double amountOut;

  @HiveField(10)
  double amountIn;
  Transaction({
    required this.timestamp,
    required this.customerId,
    required this.staffId,
    required this.branchId,
    required this.tax,
    required this.rateBuy,
    required this.rateSell,
    required this.currencyBuy,
    required this.currencySell,
    required this.amountOut,
    required this.amountIn,
  });
}
