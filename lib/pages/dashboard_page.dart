import 'package:flutter/material.dart';
import 'parameter_detail_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> parameters = [
      {
        "title": "Temperature",
        "value": "27.6",
        "unit": "°C",
        "status": "Normal",
        "color": Colors.orange,
        "icon": Icons.thermostat,
      },
      {
        "title": "pH Level",
        "value": "7.4",
        "unit": "",
        "status": "Optimal",
        "color": Colors.green,
        "icon": Icons.science,
      },
      {
        "title": "Ammonia",
        "value": "0.02",
        "unit": "mg/L",
        "status": "Safe",
        "color": Colors.blue,
        "icon": Icons.water_drop,
      },
      {
        "title": "Nitrite",
        "value": "0.08",
        "unit": "mg/L",
        "status": "Safe",
        "color": Colors.purple,
        "icon": Icons.opacity,
      },
      {
        "title": "Dissolved Oxygen",
        "value": "6.8",
        "unit": "mg/L",
        "status": "Good",
        "color": Colors.teal,
        "icon": Icons.air,
      },
      {
        "title": "Turbidity",
        "value": "14",
        "unit": "NTU",
        "status": "Clear",
        "color": Colors.brown,
        "icon": Icons.blur_on,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffEEF3F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffF4F7FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Good Afternoon 👋",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "Aquation",
              style: TextStyle(
                color: Color(0xff0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOverviewCard(),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: parameters.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 0.88,
                ),
                itemBuilder: (context, index) {
                  final parameter = parameters[index];

                  return _ParameterCard(
                    title: parameter["title"],
                    value: parameter["value"],
                    unit: parameter["unit"],
                    status: parameter["status"],
                    color: parameter["color"],
                    icon: parameter["icon"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ParameterDetailPage(
                            title: parameter["title"],
                            color: parameter["color"],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.water_drop, color: Colors.white, size: 28),

              SizedBox(width: 10),

              Text(
                "Water Quality",
                style: TextStyle(color: Colors.white70, fontSize: 17),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            "HEALTHY",
            style: TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),

                SizedBox(width: 6),

                Text(
                  "All parameters are within range",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Updated • 2:35 PM",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ParameterCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String status;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _ParameterCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),

                const Spacer(),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0F172A),
                  ),
                ),

                const SizedBox(height: 10),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: " $unit",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        status,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
