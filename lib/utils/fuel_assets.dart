class FuelAssets {
  static String svgForFuel(String fuelName) {
    final normalized = fuelName.toLowerCase();

    if (normalized.contains('gasolina premium')) {
      return 'assets/fuels/gasoline_premium.svg';
    }
    if (normalized.contains('gasolina regular')) {
      return 'assets/fuels/gasoline_regular.svg';
    }
    if (normalized.contains('gasoil óptimo') || normalized.contains('gasoil optimo')) {
      return 'assets/fuels/diesel_premium.svg';
    }
    if (normalized.contains('gasoil regular')) {
      return 'assets/fuels/diesel_regular.svg';
    }
    if (normalized.contains('glp') || normalized.contains('licuado')) {
      return 'assets/fuels/glp.svg';
    }
    if (normalized.contains('natural') || normalized.contains('gnl-gnc')) {
      return 'assets/fuels/natural_gas.svg';
    }

    return 'assets/fuels/fuel_generic.svg';
  }
}
