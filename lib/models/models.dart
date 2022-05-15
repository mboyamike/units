abstract class UnitType {
  static const cups = 'cups';
  static const millilitres = 'millilitres';
}

abstract class Unit {
  double get value;
  String get unit;

  Unit copyWith({double? value});

  Map<String, dynamic> toMap();
  
  Unit.fromMap(Map<String, dynamic> map);
}

class CupsUnit implements Unit {
  CupsUnit({required this.value});

  @override
  final double value;

  @override
  String get unit => UnitType.cups;

  static const conversionFactor = 236.588;

  @override
  CupsUnit copyWith({double? value}) {
    return CupsUnit(value: value ?? this.value);
  }

  MillilitresUnit toMillilitresUnit() {
    return MillilitresUnit(
      value: (value * conversionFactor).roundToDouble(),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'value': value,
        'unit': unit,
      };
}

class MillilitresUnit implements Unit {
  MillilitresUnit({required this.value});

  @override
  final double value;

  
  @override
  String get unit => UnitType.millilitres;

  static const conversionFactor = 236.588;

  @override
  MillilitresUnit copyWith({double? value}) {
    return MillilitresUnit(value: value ?? this.value);
  }

  CupsUnit toCupsUnit() {
    return CupsUnit(
      value: (value / conversionFactor).roundToDouble(),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'value': value,
        'unit': unit,
      };
}
