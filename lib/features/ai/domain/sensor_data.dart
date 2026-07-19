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

  static final ValueNotifier<Set<String>> activeSensorTitlesNotifier = ValueNotifier<Set<String>>({
    "Temperature",
    "pH Level",
    "Dissolved Oxygen",
    "Turbidity",
  });

  static List<SensorInfo> get parameters => parametersNotifier.value;

  static List<double> get values => parametersNotifier.value.map((p) => p.value).toList();

  static SensorInfo createSensorInfo(String title, double value) {
    switch (title) {
      case "Temperature":
        String status = "Normal";
        Color color = Colors.orange;
        if (value < 18.0) {
          status = "Cold";
          color = Colors.blue;
        } else if (value >= 18.0 && value <= 28.0) {
          status = "Optimal";
          color = Colors.green;
        } else if (value > 32.0) {
          status = "High";
          color = Colors.red;
        }
        return SensorInfo(
          title: "Temperature",
          value: value,
          unit: "°C",
          status: status,
          color: color,
          icon: Icons.thermostat,
        );
      case "pH Level":
        String status = "Optimal";
        Color color = Colors.green;
        if (value < 6.5) {
          status = "Acidic";
          color = Colors.purple;
        } else if (value > 8.5) {
          status = "Alkaline";
          color = Colors.red;
        }
        return SensorInfo(
          title: "pH Level",
          value: value,
          unit: "",
          status: status,
          color: color,
          icon: Icons.science,
        );
      case "Dissolved Oxygen":
        String status = "Good";
        Color color = Colors.teal;
        if (value < 4.0) {
          status = "Critical";
          color = Colors.red;
        } else if (value >= 4.0 && value <= 5.0) {
          status = "Low";
          color = Colors.orange;
        }
        return SensorInfo(
          title: "Dissolved Oxygen",
          value: value,
          unit: "mg/L",
          status: status,
          color: color,
          icon: Icons.air,
        );
      case "Turbidity":
        String status = "Clear";
        Color color = Colors.brown;
        if (value >= 25.0 && value <= 40.0) {
          status = "Moderate";
          color = Colors.orange;
        } else if (value > 40.0) {
          status = "Turbid";
          color = Colors.red;
        }
        return SensorInfo(
          title: "Turbidity",
          value: value,
          unit: "NTU",
          status: status,
          color: color,
          icon: Icons.blur_on,
        );
      case "Ammonia":
        String status = "Safe";
        Color color = Colors.blue;
        if (value > 0.05) {
          status = "Toxic";
          color = Colors.red;
        } else if (value > 0.02) {
          status = "Warning";
          color = Colors.orange;
        }
        return SensorInfo(
          title: "Ammonia",
          value: value,
          unit: "mg/L",
          status: status,
          color: color,
          icon: Icons.water_drop,
        );
      case "Nitrite":
        String status = "Safe";
        Color color = Colors.purple;
        if (value > 0.1) {
          status = "Toxic";
          color = Colors.red;
        } else if (value > 0.05) {
          status = "Warning";
          color = Colors.orange;
        }
        return SensorInfo(
          title: "Nitrite",
          value: value,
          unit: "mg/L",
          status: status,
          color: color,
          icon: Icons.opacity,
        );
      default:
        throw ArgumentError("Unknown sensor title: $title");
    }
  }

  static void updateActiveParameters() {
    final activeTitles = activeSensorTitlesNotifier.value;
    final List<SensorInfo> list = [];

    for (final title in activeTitles) {
      double defaultValue = 0.0;
      switch (title) {
        case "Temperature":
          defaultValue = 27.6;
          break;
        case "pH Level":
          defaultValue = 7.4;
          break;
        case "Dissolved Oxygen":
          defaultValue = 6.8;
          break;
        case "Turbidity":
          defaultValue = 14.0;
          break;
        case "Ammonia":
          defaultValue = 0.02;
          break;
        case "Nitrite":
          defaultValue = 0.08;
          break;
      }
      list.add(createSensorInfo(title, defaultValue));
    }
    parametersNotifier.value = list;
  }

  static void randomize() {
    // Record current parameters to history before updating them
    SensorHistory.addRecord(parametersNotifier.value);

    final random = Random();
    final activeTitles = activeSensorTitlesNotifier.value;
    final List<SensorInfo> newList = [];

    for (final title in activeTitles) {
      double value = 0.0;
      switch (title) {
        case "Temperature":
          value = double.parse((15.0 + random.nextDouble() * 20.0).toStringAsFixed(1));
          break;
        case "pH Level":
          value = double.parse((5.5 + random.nextDouble() * 3.5).toStringAsFixed(1));
          break;
        case "Dissolved Oxygen":
          value = double.parse((2.0 + random.nextDouble() * 7.0).toStringAsFixed(1));
          break;
        case "Turbidity":
          value = double.parse((5.0 + random.nextDouble() * 40.0).toStringAsFixed(1));
          break;
        case "Ammonia":
          final raw = random.nextDouble() < 0.7 ? random.nextDouble() * 0.04 : random.nextDouble() * 0.8;
          value = double.parse(raw.toStringAsFixed(2));
          break;
        case "Nitrite":
          final raw = random.nextDouble() < 0.7 ? random.nextDouble() * 0.09 : random.nextDouble() * 0.7;
          value = double.parse(raw.toStringAsFixed(2));
          break;
      }
      newList.add(createSensorInfo(title, value));
    }
    parametersNotifier.value = newList;
  }
}
