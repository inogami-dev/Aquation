import 'package:aquation/ai/domain/sensor_data.dart';
import 'package:flutter/material.dart';
import 'parameter_detail_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: [
          GestureDetector(
            onTap: () {
              SensorData.randomize();
            },
            child: Container(
              width: 60,
              height: 60,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<SensorInfo>>(
        valueListenable: SensorData.parametersNotifier,
        builder: (context, parameters, child) {
          // Calculate overall health state dynamically
          final isHealthy = !parameters.any((p) => 
            p.status == "Toxic" || 
            p.status == "Critical" || 
            p.status == "Warning" || 
            p.status == "High" || 
            p.status == "Acidic" || 
            p.status == "Alkaline"
          );

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildOverviewCard(isHealthy),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: parameters.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: 0.80,
                    ),
                    itemBuilder: (context, index) {
                      final parameter = parameters[index];

                      return _ParameterCard(
                        title: parameter.title,
                        value: parameter.value.toString(),
                        unit: parameter.unit,
                        status: parameter.status,
                        color: parameter.color,
                        icon: parameter.icon,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ParameterDetailPage(
                                title: parameter.title,
                                color: parameter.color,
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
          );
        },
      ),
    );
  }

  Widget _buildOverviewCard(bool isHealthy) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isHealthy
              ? [const Color(0xff2563EB), const Color(0xff1D4ED8)]
              : [const Color(0xffE11D48), const Color(0xff9F1239)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (isHealthy ? Colors.blue : Colors.red).withValues(alpha: .25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isHealthy ? Icons.water_drop : Icons.warning_amber_rounded,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 10),
              Text(
                "Water Quality",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            isHealthy ? "HEALTHY" : "ATTENTION",
            style: const TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: (isHealthy ? Colors.greenAccent : Colors.orangeAccent).withValues(alpha: .2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isHealthy ? Icons.check_circle : Icons.info_outline,
                  color: isHealthy ? Colors.greenAccent : Colors.orangeAccent,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  isHealthy ? "All parameters are within range" : "Some parameters need checking",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Updated • Just Now",
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
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),

                const Spacer(),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0F172A),
                  ),
                ),

                const SizedBox(height: 4),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value,
                          style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: " $unit",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        status,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
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
