import 'dart:math';
import 'package:flutter/material.dart';
import 'sensor_history.dart';

class SensorInfo {
  final String title;
  final double value;
  final String unit;
  final String status;
  final Color color;
  final IconData icon;

  const SensorInfo({
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
    required this.color,
    required this.icon,
  });
}

class SensorData {
  SensorData._();

  static final ValueNotifier<List<SensorInfo>> parametersNotifier = ValueNotifier<List<SensorInfo>>([
    const SensorInfo(
      title: "Temperature",
      value: 27.6,
      unit: "°C",
      status: "Normal",
      color: Colors.orange,
      icon: Icons.thermostat,
    ),
    const SensorInfo(
      title: "pH Level",
      value: 7.4,
      unit: "",
      status: "Optimal",
      color: Colors.green,
      icon: Icons.science,
    ),
    const SensorInfo(
      title: "Ammonia",
      value: 0.02,
      unit: "mg/L",
      status: "Safe",
      color: Colors.blue,
      icon: Icons.water_drop,
    ),
    const SensorInfo(
      title: "Nitrite",
      value: 0.08,
      unit: "mg/L",
      status: "Safe",
      color: Colors.purple,
      icon: Icons.opacity,
    ),
    const SensorInfo(
      title: "Dissolved Oxygen",
      value: 6.8,
      unit: "mg/L",
      status: "Good",
      color: Colors.teal,
      icon: Icons.air,
    ),
    const SensorInfo(
      title: "Turbidity",
      value: 14.0,
      unit: "NTU",
      status: "Clear",
      color: Colors.brown,
      icon: Icons.blur_on,
    ),
  ]);

  static List<SensorInfo> get parameters => parametersNotifier.value;

  static List<double> get values => parametersNotifier.value.map((p) => p.value).toList();

  static void randomize() {
    // Record current parameters to history before updating them
    SensorHistory.addRecord(parametersNotifier.value);

    final random = Random();

    // 1. Temperature: 15.0 to 35.0 °C
    final temp = double.parse((15.0 + random.nextDouble() * 20.0).toStringAsFixed(1));
    String tempStatus = "Normal";
    Color tempColor = Colors.orange;
    if (temp < 18.0) {
      tempStatus = "Cold";
      tempColor = Colors.blue;
    } else if (temp >= 18.0 && temp <= 28.0) {
      tempStatus = "Optimal";
      tempColor = Colors.green;
    } else if (temp > 32.0) {
      tempStatus = "High";
      tempColor = Colors.red;
    }

    // 2. pH Level: 5.5 to 9.0
    final ph = double.parse((5.5 + random.nextDouble() * 3.5).toStringAsFixed(1));
    String phStatus = "Optimal";
    Color phColor = Colors.green;
    if (ph < 6.5) {
      phStatus = "Acidic";
      phColor = Colors.purple;
    } else if (ph > 8.5) {
      phStatus = "Alkaline";
      phColor = Colors.red;
    }

    // 3. Ammonia: 0.0 to 1.0 mg/L (usually low)
    final rawAmmonia = random.nextDouble() < 0.7 ? random.nextDouble() * 0.04 : random.nextDouble() * 0.8;
    final ammonia = double.parse(rawAmmonia.toStringAsFixed(2));
    String ammoniaStatus = "Safe";
    Color ammoniaColor = Colors.blue;
    if (ammonia >= 0.05 && ammonia <= 0.2) {
      ammoniaStatus = "Warning";
      ammoniaColor = Colors.orange;
    } else if (ammonia > 0.2) {
      ammoniaStatus = "Toxic";
      ammoniaColor = Colors.red;
    }

    // 4. Nitrite: 0.0 to 1.0 mg/L (usually low)
    final rawNitrite = random.nextDouble() < 0.7 ? random.nextDouble() * 0.09 : random.nextDouble() * 0.7;
    final nitrite = double.parse(rawNitrite.toStringAsFixed(2));
    String nitriteStatus = "Safe";
    Color nitriteColor = Colors.purple;
    if (nitrite >= 0.1 && nitrite <= 0.5) {
      nitriteStatus = "Warning";
      nitriteColor = Colors.orange;
    } else if (nitrite > 0.5) {
      nitriteStatus = "Toxic";
      nitriteColor = Colors.red;
    }

    // 5. Dissolved Oxygen: 2.0 to 9.0 mg/L
    final doVal = double.parse((2.0 + random.nextDouble() * 7.0).toStringAsFixed(1));
    String doStatus = "Good";
    Color doColor = Colors.teal;
    if (doVal < 4.0) {
      doStatus = "Critical";
      doColor = Colors.red;
    } else if (doVal >= 4.0 && doVal <= 5.0) {
      doStatus = "Low";
      doColor = Colors.orange;
    }

    // 6. Turbidity: 5.0 to 45.0 NTU
    final turbidity = double.parse((5.0 + random.nextDouble() * 40.0).toStringAsFixed(1));
    String turbidityStatus = "Clear";
    Color turbidityColor = Colors.brown;
    if (turbidity >= 25.0 && turbidity <= 40.0) {
      turbidityStatus = "Moderate";
      turbidityColor = Colors.orange;
    } else if (turbidity > 40.0) {
      turbidityStatus = "Turbid";
      turbidityColor = Colors.red;
    }

    parametersNotifier.value = [
      SensorInfo(
        title: "Temperature",
        value: temp,
        unit: "°C",
        status: tempStatus,
        color: tempColor,
        icon: Icons.thermostat,
      ),
      SensorInfo(
        title: "pH Level",
        value: ph,
        unit: "",
        status: phStatus,
        color: phColor,
        icon: Icons.science,
      ),
      SensorInfo(
        title: "Ammonia",
        value: ammonia,
        unit: "mg/L",
        status: ammoniaStatus,
        color: ammoniaColor,
        icon: Icons.water_drop,
      ),
      SensorInfo(
        title: "Nitrite",
        value: nitrite,
        unit: "mg/L",
        status: nitriteStatus,
        color: nitriteColor,
        icon: Icons.opacity,
      ),
      SensorInfo(
        title: "Dissolved Oxygen",
        value: doVal,
        unit: "mg/L",
        status: doStatus,
        color: doColor,
        icon: Icons.air,
      ),
      SensorInfo(
        title: "Turbidity",
        value: turbidity,
        unit: "NTU",
        status: turbidityStatus,
        color: turbidityColor,
        icon: Icons.blur_on,
      ),
    ];
  }
}

