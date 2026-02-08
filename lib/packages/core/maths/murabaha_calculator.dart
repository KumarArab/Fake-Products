class MurabahaCalculator {
  MurabahaCalculator._();

  static final MurabahaCalculator _instance = MurabahaCalculator._();

  double profitMarignPercentage = 0.12;

  factory MurabahaCalculator() {
    return _instance;
  }
}
