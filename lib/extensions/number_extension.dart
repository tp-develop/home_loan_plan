extension DoubleNumberExtension on double {
  String toHLPNumber() {
    return this.toStringAsFixed(2).toString();
  }
}

extension IntNumberExtension on int {
  String toHLPNumber() {
    return this.toStringAsFixed(2).toString();
  }
}
