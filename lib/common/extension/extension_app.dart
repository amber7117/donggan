extension ExpressionInt on int {
  bool isTrue() {
    return this > 0;
  }
}

extension ExpressionBool on bool {
  int toInt() {
    return this ? 1 : 0;
  }
}

extension ExpressionStr on String {
  int toInt() {
    int? value = int.tryParse(this);
    return value ?? 0;
  }

  double toDouble() {
    double? value = double.tryParse(this);
    return value ?? 0.0;
  }
}
