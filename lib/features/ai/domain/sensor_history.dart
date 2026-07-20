import 'package:aquation/features/ai/domain/sensor_data.dart';
import 'package:flutter/material.dart';

class SensorHistoryRecord {
  final DateTime timestamp;
  final List<SensorInfo> parameters;
  final String? aiInsight;
  final String? feedback;

  const SensorHistoryRecord({
    required this.timestamp,
    required this.parameters,
    this.aiInsight,
    this.feedback,
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
          aiInsight: "**Water Quality Status: Optimal**\n\nAll parameters are within healthy thresholds. Dissolved oxygen levels are good. No action is required.",
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
          aiInsight: "**Water Quality Status: Normal**\n\nThe water temperature is slightly elevated at 28.5°C, but still within acceptable parameters. Continue monitoring standard temperature patterns.",
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
          aiInsight: "**Water Quality Status: Normal (Slight Turbidity)**\n\nTurbidity is slightly elevated at 18.0 NTU. Dissolved oxygen is stable at 5.7 mg/L. Check water filtration systems to prevent further sediment accumulation.",
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
          aiInsight: "### ⚠️ CRITICAL WATER QUALITY ALERT\n\nMultiple parameters are in dangerous thresholds:\n\n1. **High Temperature (32.4°C)**: Dangerous heat stress risk for crayfish.\n2. **Acidic pH (6.2)**: Needs buffering.\n3. **Critical Dissolved Oxygen (3.5 mg/L)**: Severe suffocation risk.\n4. **Turbid Water (41.5 NTU)**: Reduced visibility and safety.\n\n**Recommendation:** Activate backup aerators immediately, add fresh cool water, and apply calcium carbonate to raise pH.",
          feedback: "Activated backup aeration and fresh water buffer. Temperature reduced to 28°C and DO recovered to 6.0 mg/L within 2 hours.",
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
          aiInsight: "**Water Quality Status: Optimal**\n\nPerfect parameters for optimal crayfish growth. Oxygen saturation is excellent. No intervention needed.",
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
          aiInsight: "**Water Quality Status: Optimal**\n\nValues are fully stable and within safe operating parameters.",
        ),
      ]);

  static List<SensorHistoryRecord> get history => historyNotifier.value;

  static void addRecord(List<SensorInfo> parameters, {String? aiInsight, String? feedback}) {
    final newRecord = SensorHistoryRecord(
      timestamp: DateTime.now(),
      parameters: parameters,
      aiInsight: aiInsight,
      feedback: feedback,
    );
    final updatedList = [newRecord, ...historyNotifier.value];

    // Sort descending chronologically (newest timestamp first)
    updatedList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    historyNotifier.value = updatedList;
  }
}
