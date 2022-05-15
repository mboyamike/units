import 'package:another/models/models.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System converter')),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double maxMillilitres = 10000;
  double maxCups = 30;
  Unit unit = CupsUnit(value: 15);
  String get unitType => unit.unit;

  double get maxValue => unit is CupsUnit ? maxCups : maxMillilitres;

  void onSliderChanged(double newValue) {
    setState(() {
      unit = unit.copyWith(value: newValue);
    });
  }

  void onChanged(String? newUnitType) {
    if (newUnitType == null) {
      return;
    }

    if (newUnitType == UnitType.cups && unit is MillilitresUnit) {
      unit = (unit as MillilitresUnit).toCupsUnit();
    }

    if (newUnitType == UnitType.millilitres && unit is CupsUnit) {
      unit = (unit as CupsUnit).toMillilitresUnit();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DropdownButton<String>(
            items: const [
              DropdownMenuItem(
                value: 'cups',
                child: Text('Cups'),
              ),
              DropdownMenuItem(
                value: 'millilitres',
                child: Text('Millilitres'),
              ),
            ],
            onChanged: onChanged,
            value: unitType,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: unit.value.roundToDouble(),
                  onChanged: onSliderChanged,
                  min: 0,
                  max: maxValue,
                ),
              ),
              const SizedBox(width: 16),
              Text(unit.value.roundToDouble().toString()),
            ],
          )
        ],
      ),
    );
  }
}
