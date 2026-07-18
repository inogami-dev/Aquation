import 'package:aquation/ai/domain/ai_logic.dart';
import 'package:aquation/ai/domain/dimensions.dart';
import 'package:aquation/ai/domain/sensor_data.dart';
import 'package:aquation/ai/presentation/feedback_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'my_aquation_ai_logic.dart'; // Ensure you import your logic file

class AiTestScreen extends StatefulWidget {
  const AiTestScreen({super.key});

  @override
  State<AiTestScreen> createState() => _AiTestScreenState();
}

class _AiTestScreenState extends State<AiTestScreen> {
  bool _isLoading = false;
  String _response = "Press the button below to analyze the water conditions.";

  Future<void> _runAnalysis() async {
    setState(() {
      _isLoading = true;
      _response = "Analyzing water conditions...";
    });

    // Initialize your improved logic class with synced data
    final logic = MyAquationAiLogic(sensorValues: SensorData.values);
    final result = await logic.getResponse();

    setState(() {
      _isLoading = false;
      _response = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Crayfish Farm AI',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          width: MyDimensions.getWidth(context),
          height: MyDimensions.getHeight(context),
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sensor Data Display Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Sensor Data",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder<List<SensorInfo>>(
                        valueListenable: SensorData.parametersNotifier,
                        builder: (context, parameters, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: parameters.length,
                            itemBuilder: (context, index) {
                              final parameter = parameters[index];
                              final displayUnit = parameter.unit.isNotEmpty ? " ${parameter.unit}" : "";
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  "${parameter.title}: ${parameter.value}$displayUnit",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Analyze Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _runAnalysis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F62FE),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Analyze Conditions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                const SizedBox(height: 32),

                // AI Response Display
                const Text(
                  "AI Insights",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: MarkdownBody(
                    data: _response,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      tableBody: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      // You can customize headings, bold text, and lists here to keep it modern
                    ),
                  ),
                ),

                // Feedback Input
                const FeedbackInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
