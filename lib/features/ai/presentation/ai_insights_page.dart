import 'package:aquation/features/ai/data/db_helper.dart';
import 'package:aquation/features/ai/domain/ai_logic.dart';
import 'package:aquation/features/ai/domain/dimensions.dart';
import 'package:aquation/features/ai/domain/sensor_data.dart';
import 'package:aquation/features/ai/domain/sensor_history.dart';
import 'package:aquation/features/ai/presentation/ai_analyze_button.dart';
import 'package:aquation/features/ai/presentation/feedback_input.dart';
import 'package:aquation/features/ai/presentation/saved_insights_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AiTestScreen extends StatefulWidget {
  const AiTestScreen({super.key});

  @override
  State<AiTestScreen> createState() => _AiTestScreenState();
}

class _AiTestScreenState extends State<AiTestScreen> {
  bool _isLoading = false;
  String _response = "Press the button above to analyze the water conditions.";
  int? _currentInsightId;

  Future<void> _runAnalysis() async {
    setState(() {
      _isLoading = true;
      _response = "Analyzing water conditions...";
      _currentInsightId = null;
    });

    try {
      // Initialize your improved logic class with synced data
      final logic = MyAquationAiLogic(sensorValues: SensorData.values);
      final result = await logic.getResponse();

      final parameters = SensorData.parameters;
      final temp = parameters[0].value;
      final ph = parameters[1].value;
      final dissolvedOxygen = parameters[2].value;
      final turbidity = parameters[3].value;

      int? newId;
      try {
        newId = await DatabaseHelper.instance.insertInsight(
          temperature: temp,
          phLevel: ph,
          dissolvedOxygen: dissolvedOxygen,
          turbidity: turbidity,
          insight: result,
        );
      } catch (dbError) {
        debugPrint("SQLite Database write error (this can happen on Windows without FFI initialization): $dbError");
      }

      SensorHistory.addRecord(
        parameters,
        aiInsight: result,
      );

      setState(() {
        _isLoading = false;
        _response = result;
        _currentInsightId = newId;
      });
    } catch (e) {
      debugPrint("Water quality analysis error: $e");
      setState(() {
        _isLoading = false;
        _response = "Error running analysis: $e\n\nPlease check your internet connection or Gemini API credentials.";
      });
    }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: "Saved Insights",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedInsightsPage()),
              );
            },
          ),
        ],
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
                              final displayUnit = parameter.unit.isNotEmpty
                                  ? " ${parameter.unit}"
                                  : "";
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
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
                PremiumAnalyzeButton(
                  isLoading: _isLoading,
                  onPressed: _runAnalysis,
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
                const SizedBox(height: 16),

                // Feedback Input Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 4,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: FeedbackInput(
                    onSendFeedback: (feedback) async {
                      final messenger = ScaffoldMessenger.of(context);
                      if (_currentInsightId != null) {
                        await DatabaseHelper.instance.updateFeedback(
                          _currentInsightId!,
                          feedback,
                        );

                        // Also update the in-memory history list so the new feedback is visible in Pond History
                        final historyList = SensorHistory.historyNotifier.value;
                        if (historyList.isNotEmpty) {
                          final updatedList = List<SensorHistoryRecord>.from(historyList);
                          final latest = updatedList.first;
                          updatedList[0] = SensorHistoryRecord(
                            timestamp: latest.timestamp,
                            parameters: latest.parameters,
                            aiInsight: latest.aiInsight,
                            feedback: feedback,
                          );
                          SensorHistory.historyNotifier.value = updatedList;
                        }

                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Feedback and analysis saved to database!",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: Color(0xff0F62FE),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please run analysis before sending feedback.",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: Colors.orange,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
