class FragrancePercentages {
  final double sweet;
  final double fresh;
  final double floral;
  final double woody;

  const FragrancePercentages({
    required this.sweet,
    required this.fresh,
    required this.floral,
    required this.woody,
  });

  double get total => sweet + fresh + floral + woody;

  bool get isValidSelection {
    final values = [sweet, fresh, floral, woody];

    return values.every(
          (value) => value.isFinite && value >= 0 && value <= 100,
        ) &&
        (total - 100).abs() < 0.001;
  }

  double differenceFrom(FragrancePercentages other) {
    return (sweet - other.sweet).abs() +
        (fresh - other.fresh).abs() +
        (floral - other.floral).abs() +
        (woody - other.woody).abs();
  }
}
