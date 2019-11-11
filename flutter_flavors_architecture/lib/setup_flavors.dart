enum FlavorType { MOCK, PROD }

class Flavor {
  const Flavor._();

  static final FlavorType _flavorType = FlavorType.MOCK;

  static FlavorType get flavorType => _flavorType;
}
