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
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(.75)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Current Reading",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "°C",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Normal",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Last Updated\n2:35 PM",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
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
                    "26.2",
                    Icons.arrow_downward,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    "Maximum",
                    "27.8",
                    Icons.arrow_upward,
                    Colors.red,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    "Average",
                    "27.1",
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
                            "24°C - 30°C",
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
        padding: const EdgeInsets.all(18),
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
