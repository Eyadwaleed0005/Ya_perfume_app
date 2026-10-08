class FragrancePercentages {
  final double sweet;
  final double fresh;
  final double floral;
  final double woody;
  final double fruity;
  final double whiteFloralJasmin;

  const FragrancePercentages({
    required this.sweet,
    required this.fresh,
    required this.floral,
    required this.woody,
    required this.fruity,
    required this.whiteFloralJasmin,
  });

  double get total =>
      sweet + fresh + floral + woody + fruity + whiteFloralJasmin;

  bool get isValidSelection {
    final values = [
      sweet,
      fresh,
      floral,
      woody,
      fruity,
      whiteFloralJasmin,
    ];

    return values.every(
          (value) => value.isFinite && value >= 0 && value <= 100,
        ) &&
        (total - 100).abs() < 0.001;
  }

  double differenceFrom(FragrancePercentages other) {
    return (sweet - other.sweet).abs() +
        (fresh - other.fresh).abs() +
        (floral - other.floral).abs() +
        (woody - other.woody).abs() +
        (fruity - other.fruity).abs() +
        (whiteFloralJasmin - other.whiteFloralJasmin).abs();
  }
}