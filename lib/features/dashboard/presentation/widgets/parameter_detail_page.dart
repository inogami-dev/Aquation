import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ParameterDetailPage extends StatelessWidget {
  final String title;
  final Color color;
  final double value;

  const ParameterDetailPage({
    super.key,
    required this.title,
    required this.color,
    required this.value,
  });

  String _getUnit(String title) {
    switch (title.toLowerCase()) {
      case "temperature":
        return "°C";
      case "ph level":
        return "";
      case "dissolved oxygen":
        return "mg/L";
      case "turbidity":
        return "NTU";
      case "ammonia":
        return "mg/L";
      case "nitrite":
        return "mg/L";
      default:
        return "";
    }
  }

  String _getStatus(String title, double val) {
    switch (title.toLowerCase()) {
      case "temperature":
        return (val >= 24 && val <= 30) ? "Normal" : "Warning";
      case "ph level":
        return (val >= 7.0 && val <= 8.5) ? "Normal" : "Warning";
      case "dissolved oxygen":
        return (val >= 5.0) ? "Normal" : "Toxic";
      case "turbidity":
        return (val >= 5 && val <= 15) ? "Normal" : "Warning";
      case "ammonia":
        return (val <= 0.02) ? "Normal" : (val <= 0.05 ? "Warning" : "Toxic");
      case "nitrite":
        return (val <= 0.05) ? "Normal" : (val <= 0.1 ? "Warning" : "Toxic");
      default:
        return "Normal";
    }
  }

  String _getOptimalRange(String title) {
    switch (title.toLowerCase()) {
      case "temperature":
        return "24°C - 30°C";
      case "ph level":
        return "7.0 - 8.5";
      case "dissolved oxygen":
        return ">= 5.0 mg/L";
      case "turbidity":
        return "5.0 NTU - 15.0 NTU";
      case "ammonia":
        return "<= 0.02 mg/L";
      case "nitrite":
        return "<= 0.05 mg/L";
      default:
        return "";
    }
  }

  Map<String, String> _getMockStats(String title) {
    switch (title.toLowerCase()) {
      case "temperature":
        return {"min": "26.2", "max": "27.8", "avg": "27.1"};
      case "ph level":
        return {"min": "7.2", "max": "7.9", "avg": "7.5"};
      case "dissolved oxygen":
        return {"min": "5.8", "max": "7.2", "avg": "6.5"};
      case "turbidity":
        return {"min": "8.5", "max": "14.8", "avg": "12.1"};
      case "ammonia":
        return {"min": "0.01", "max": "0.03", "avg": "0.02"};
      case "nitrite":
        return {"min": "0.02", "max": "0.07", "avg": "0.04"};
      default:
        return {"min": "0.0", "max": "0.0", "avg": "0.0"};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF3F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffEEF3F8),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xff0F172A)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            //-----------------------------------
            // Current Reading Card
            //-----------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(.75)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Side: Title and Reading Value
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Current Reading",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              value.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_getUnit(title).isNotEmpty) ...[
                              const SizedBox(width: 4),
                              Text(
                                _getUnit(title),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Right Side: Status Capsule and Timestamp
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          _getStatus(title, value),
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Updated Just Now",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //-----------------------------------
            // Graph Card
            //-----------------------------------
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Trend",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          DropdownButton<String>(
                            value: "24 Hours",
                            items: const [
                              DropdownMenuItem(
                                value: "24 Hours",
                                child: Text("24 Hours"),
                              ),
                              DropdownMenuItem(
                                value: "7 Days",
                                child: Text("7 Days"),
                              ),
                              DropdownMenuItem(
                                value: "30 Days",
                                child: Text("30 Days"),
                              ),
                            ],
                            onChanged: (_) {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 260,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),

                            borderData: FlBorderData(show: false),

                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),

                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),

                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 42,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toStringAsFixed(0),
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  interval: 1,
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            "6 AM",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );

                                      case 2:
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            "10 AM",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );

                                      case 4:
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            "2 PM",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );

                                      case 6:
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            "6 PM",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );

                                      case 8:
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            "10 PM",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );
                                    }

                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ),

                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(0, 26.2),
                                  FlSpot(1, 27.0),
                                  FlSpot(2, 27.3),
                                  FlSpot(3, 27.1),
                                  FlSpot(4, 27.8),
                                  FlSpot(5, 27.5),
                                  FlSpot(6, 27.4),
                                  FlSpot(7, 27.7),
                                  FlSpot(8, 27.6),
                                ],

                                isCurved: true,
                                curveSmoothness: .35,

                                color: color,

                                barWidth: 5,

                                isStrokeCapRound: true,

                                dotData: const FlDotData(show: false),

                                belowBarData: BarAreaData(
                                  show: true,
                                  color: color.withOpacity(.20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            //-----------------------------------
            // Statistics
            //-----------------------------------
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    "Minimum",
                    _getMockStats(title)["min"]!,
                    Icons.arrow_downward,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    "Maximum",
                    _getMockStats(title)["max"]!,
                    Icons.arrow_upward,
                    Colors.red,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    "Average",
                    _getMockStats(title)["avg"]!,
                    Icons.analytics,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            //-----------------------------------
            // Optimal Range
            //-----------------------------------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: color.withOpacity(.15),
                      child: Icon(Icons.water_drop, color: color),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Optimal Range",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            _getOptimalRange(title),
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
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

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, color: color),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),

            const SizedBox(height: 5),

            Text(title),
          ],
        ),
      ),
    );
  }
}
