import 'package:aquation/features/ai/domain/sensor_data.dart';
import 'package:aquation/features/auth/presentation/login_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _deviceIdController;

  @override
  void initState() {
    super.initState();
    _deviceIdController = TextEditingController(text: "ESP32-AQ-984");
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF3F8),
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffF4F7FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(
                      0xff0F62FE,
                    ).withValues(alpha: 0.1),
                    child: const Text(
                      "AR",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0F62FE),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Alden Recharge",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Pond Operator",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profile Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(Icons.calendar_today_rounded, "Age", "44"),
                  const Divider(height: 24, color: Color(0xffF1F5F9)),
                  _buildDetailRow(Icons.pin_rounded, "Pond No.", "2"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stock details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Crayfish/Tab",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    Icons.waves_rounded,
                    "Tab 1",
                    "300 Craylings",
                  ),
                  const Divider(height: 24, color: Color(0xffF1F5F9)),
                  _buildDetailRow(
                    Icons.waves_rounded,
                    "Tab 2",
                    "350 Craylings",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Modular Device ID Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.developer_board_rounded,
                          color: Color(0xff0F62FE),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Base Device Config",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Enter your modular hardware base device ID (e.g. ESP32 board) to sync attached modular sensors.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _deviceIdController,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0F172A),
                    ),
                    decoration: InputDecoration(
                      labelText: "Device Hardware ID",
                      labelStyle: const TextStyle(
                        color: Color(0xff64748B),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      hintText: "Enter ESP32 Base ID",
                      hintStyle: const TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff0F62FE),
                          width: 1.5,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.memory_rounded,
                        color: Color(0xff64748B),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Device ID '${_deviceIdController.text}' successfully synced!",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: const Color(0xff0F62FE),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0F62FE),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Confirm & Sync Device",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Manage Sensors Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ValueListenableBuilder<Set<String>>(
                valueListenable: SensorData.activeSensorTitlesNotifier,
                builder: (context, activeSensorTitles, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Manage Pond Sensors",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Toggle modular sensors to enable/disable them on your dashboard telemetry card and AI logs.",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      _buildSensorToggleRow(
                        title: "Temperature",
                        icon: Icons.thermostat,
                        color: Colors.orange,
                        isActive: true,
                        isDefault: true,
                        onChanged: (_) {},
                      ),
                      const Divider(height: 20, color: Color(0xffF1F5F9)),
                      _buildSensorToggleRow(
                        title: "pH Level",
                        icon: Icons.science,
                        color: Colors.green,
                        isActive: true,
                        isDefault: true,
                        onChanged: (_) {},
                      ),
                      const Divider(height: 20, color: Color(0xffF1F5F9)),
                      _buildSensorToggleRow(
                        title: "Dissolved Oxygen",
                        icon: Icons.air,
                        color: Colors.teal,
                        isActive: true,
                        isDefault: true,
                        onChanged: (_) {},
                      ),
                      const Divider(height: 20, color: Color(0xffF1F5F9)),
                      _buildSensorToggleRow(
                        title: "Turbidity",
                        icon: Icons.blur_on,
                        color: Colors.brown,
                        isActive: true,
                        isDefault: true,
                        onChanged: (_) {},
                      ),
                      const Divider(height: 20, color: Color(0xffF1F5F9)),
                      _buildSensorToggleRow(
                        title: "Ammonia",
                        icon: Icons.water_drop,
                        color: Colors.blue,
                        isActive: activeSensorTitles.contains("Ammonia"),
                        isDefault: false,
                        onChanged: (val) {
                          _toggleSensor("Ammonia", val);
                        },
                      ),
                      const Divider(height: 20, color: Color(0xffF1F5F9)),
                      _buildSensorToggleRow(
                        title: "Nitrite",
                        icon: Icons.opacity,
                        color: Colors.purple,
                        isActive: activeSensorTitles.contains("Nitrite"),
                        isDefault: false,
                        onChanged: (val) {
                          _toggleSensor("Nitrite", val);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button Card
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.logout_rounded,
                      color: Color(0xffEF4444),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffEF4444),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSensor(String title, bool val) {
    final activeTitles = Set<String>.from(
      SensorData.activeSensorTitlesNotifier.value,
    );
    if (val) {
      activeTitles.add(title);
    } else {
      activeTitles.remove(title);
    }
    SensorData.activeSensorTitlesNotifier.value = activeTitles;
    SensorData.updateActiveParameters();
  }

  Widget _buildSensorToggleRow({
    required String title,
    required IconData icon,
    required Color color,
    required bool isActive,
    required bool isDefault,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),
              if (isDefault)
                const Text(
                  "Required Sensor",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
            ],
          ),
        ),
        Switch(
          value: isActive,
          onChanged: isDefault ? null : onChanged,
          activeTrackColor: const Color(0xff0F62FE),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xff0F62FE), size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff0F172A),
          ),
        ),
      ],
    );
  }
}
