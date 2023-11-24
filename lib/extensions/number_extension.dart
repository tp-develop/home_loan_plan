import 'package:easy_localization/easy_localization.dart';

extension DoubleNumberExtension on double {
  String toHLPNumber() {
    return this.toStringAsFixed(2).toString();
  }

  String toCurrencyDisplay() {
    var formatter = NumberFormat('###,000.00');

    return formatter.format(this);
  }
}

extension IntNumberExtension on int {
  String toHLPNumber() {
    return this.toStringAsFixed(2).toString();
  }
}
