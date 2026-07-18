import 'package:aquation/features/ai/domain/sensor_data.dart';
import 'package:flutter/material.dart';

class SensorHistoryRecord {
  final DateTime timestamp;
  final List<SensorInfo> parameters;

  const SensorHistoryRecord({
    required this.timestamp,
    required this.parameters,
  });
}

class SensorHistory {
  SensorHistory._();

  static final ValueNotifier<List<SensorHistoryRecord>> historyNotifier =
      ValueNotifier<List<SensorHistoryRecord>>([
        // Today, 15 minutes ago
        SensorHistoryRecord(
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          parameters: const [
            SensorInfo(
              title: "Temperature",
              value: 27.2,
              unit: "°C",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.thermostat,
            ),
            SensorInfo(
              title: "pH Level",
              value: 7.3,
              unit: "",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.science,
            ),
            SensorInfo(
              title: "Ammonia",
              value: 0.02,
              unit: "mg/L",
              status: "Safe",
              color: Colors.blue,
              icon: Icons.water_drop,
            ),
            SensorInfo(
              title: "Nitrite",
              value: 0.07,
              unit: "mg/L",
              status: "Safe",
              color: Colors.purple,
              icon: Icons.opacity,
            ),
            SensorInfo(
              title: "Dissolved Oxygen",
              value: 6.9,
              unit: "mg/L",
              status: "Good",
              color: Colors.teal,
              icon: Icons.air,
            ),
            SensorInfo(
              title: "Turbidity",
              value: 13.0,
              unit: "NTU",
              status: "Clear",
              color: Colors.brown,
              icon: Icons.blur_on,
            ),
          ],
        ),
        // Today, 2 hours ago
        SensorHistoryRecord(
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          parameters: const [
            SensorInfo(
              title: "Temperature",
              value: 28.5,
              unit: "°C",
              status: "Normal",
              color: Colors.orange,
              icon: Icons.thermostat,
            ),
            SensorInfo(
              title: "pH Level",
              value: 7.5,
              unit: "",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.science,
            ),
            SensorInfo(
              title: "Ammonia",
              value: 0.03,
              unit: "mg/L",
              status: "Safe",
              color: Colors.blue,
              icon: Icons.water_drop,
            ),
            SensorInfo(
              title: "Nitrite",
              value: 0.09,
              unit: "mg/L",
              status: "Safe",
              color: Colors.purple,
              icon: Icons.opacity,
            ),
            SensorInfo(
              title: "Dissolved Oxygen",
              value: 6.2,
              unit: "mg/L",
              status: "Good",
              color: Colors.teal,
              icon: Icons.air,
            ),
            SensorInfo(
              title: "Turbidity",
              value: 15.0,
              unit: "NTU",
              status: "Clear",
              color: Colors.brown,
              icon: Icons.blur_on,
            ),
          ],
        ),
        // Yesterday, 3 hours ago
        SensorHistoryRecord(
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
          parameters: const [
            SensorInfo(
              title: "Temperature",
              value: 29.1,
              unit: "°C",
              status: "Normal",
              color: Colors.orange,
              icon: Icons.thermostat,
            ),
            SensorInfo(
              title: "pH Level",
              value: 7.6,
              unit: "",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.science,
            ),
            SensorInfo(
              title: "Ammonia",
              value: 0.04,
              unit: "mg/L",
              status: "Safe",
              color: Colors.blue,
              icon: Icons.water_drop,
            ),
            SensorInfo(
              title: "Nitrite",
              value: 0.11,
              unit: "mg/L",
              status: "Warning",
              color: Colors.orange,
              icon: Icons.opacity,
            ),
            SensorInfo(
              title: "Dissolved Oxygen",
              value: 5.7,
              unit: "mg/L",
              status: "Good",
              color: Colors.teal,
              icon: Icons.air,
            ),
            SensorInfo(
              title: "Turbidity",
              value: 18.0,
              unit: "NTU",
              status: "Clear",
              color: Colors.brown,
              icon: Icons.blur_on,
            ),
          ],
        ),
        // Yesterday, 6 hours ago
        SensorHistoryRecord(
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
          parameters: const [
            SensorInfo(
              title: "Temperature",
              value: 32.4,
              unit: "°C",
              status: "High",
              color: Colors.red,
              icon: Icons.thermostat,
            ),
            SensorInfo(
              title: "pH Level",
              value: 6.2,
              unit: "",
              status: "Acidic",
              color: Colors.purple,
              icon: Icons.science,
            ),
            SensorInfo(
              title: "Ammonia",
              value: 0.22,
              unit: "mg/L",
              status: "Toxic",
              color: Colors.red,
              icon: Icons.water_drop,
            ),
            SensorInfo(
              title: "Nitrite",
              value: 0.08,
              unit: "mg/L",
              status: "Safe",
              color: Colors.purple,
              icon: Icons.opacity,
            ),
            SensorInfo(
              title: "Dissolved Oxygen",
              value: 3.5,
              unit: "mg/L",
              status: "Critical",
              color: Colors.red,
              icon: Icons.air,
            ),
            SensorInfo(
              title: "Turbidity",
              value: 41.5,
              unit: "NTU",
              status: "Turbid",
              color: Colors.red,
              icon: Icons.blur_on,
            ),
          ],
        ),
        // 2 Days ago
        SensorHistoryRecord(
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
          parameters: const [
            SensorInfo(
              title: "Temperature",
              value: 26.8,
              unit: "°C",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.thermostat,
            ),
            SensorInfo(
              title: "pH Level",
              value: 7.2,
              unit: "",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.science,
            ),
            SensorInfo(
              title: "Ammonia",
              value: 0.01,
              unit: "mg/L",
              status: "Safe",
              color: Colors.blue,
              icon: Icons.water_drop,
            ),
            SensorInfo(
              title: "Nitrite",
              value: 0.04,
              unit: "mg/L",
              status: "Safe",
              color: Colors.purple,
              icon: Icons.opacity,
            ),
            SensorInfo(
              title: "Dissolved Oxygen",
              value: 7.4,
              unit: "mg/L",
              status: "Good",
              color: Colors.teal,
              icon: Icons.air,
            ),
            SensorInfo(
              title: "Turbidity",
              value: 11.0,
              unit: "NTU",
              status: "Clear",
              color: Colors.brown,
              icon: Icons.blur_on,
            ),
          ],
        ),
        // 3 Days ago
        SensorHistoryRecord(
          timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
          parameters: const [
            SensorInfo(
              title: "Temperature",
              value: 27.5,
              unit: "°C",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.thermostat,
            ),
            SensorInfo(
              title: "pH Level",
              value: 7.4,
              unit: "",
              status: "Optimal",
              color: Colors.green,
              icon: Icons.science,
            ),
            SensorInfo(
              title: "Ammonia",
              value: 0.02,
              unit: "mg/L",
              status: "Safe",
              color: Colors.blue,
              icon: Icons.water_drop,
            ),
            SensorInfo(
              title: "Nitrite",
              value: 0.06,
              unit: "mg/L",
              status: "Safe",
              color: Colors.purple,
              icon: Icons.opacity,
            ),
            SensorInfo(
              title: "Dissolved Oxygen",
              value: 6.8,
              unit: "mg/L",
              status: "Good",
              color: Colors.teal,
              icon: Icons.air,
            ),
            SensorInfo(
              title: "Turbidity",
              value: 14.0,
              unit: "NTU",
              status: "Clear",
              color: Colors.brown,
              icon: Icons.blur_on,
            ),
          ],
        ),
      ]);

  static List<SensorHistoryRecord> get history => historyNotifier.value;

  static void addRecord(List<SensorInfo> parameters) {
    final newRecord = SensorHistoryRecord(
      timestamp: DateTime.now(),
      parameters: parameters,
    );
    final updatedList = [newRecord, ...historyNotifier.value];

    // Sort descending chronologically (newest timestamp first)
    updatedList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    historyNotifier.value = updatedList;
  }
}
