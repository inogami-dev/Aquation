import 'package:aquation/features/ai/data/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SavedInsightsPage extends StatefulWidget {
  const SavedInsightsPage({super.key});

  @override
  State<SavedInsightsPage> createState() => _SavedInsightsPageState();
}

class _SavedInsightsPageState extends State<SavedInsightsPage> {
  List<Map<String, dynamic>> _insights = [];
  bool _isLoading = true;
  final Set<int> _expandedIds = {};

  @override
  void initState() {
    super.initState();
    _fetchInsights();
  }

  Future<void> _fetchInsights() async {
    setState(() => _isLoading = true);
    try {
      final data = await DatabaseHelper.instance.getInsights();
      setState(() {
        _insights = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading insights: $e')));
      }
    }
  }

  Future<void> _deleteInsight(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Insight'),
        content: const Text(
          'Are you sure you want to permanently delete this saved analysis?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteInsight(id);
      _fetchInsights();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Insight deleted successfully.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _formatTimestamp(String isoString) {
    try {
      final dt = DateTime.parse(isoString);
      final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      final ampm = dt.hour >= 12 ? "PM" : "AM";
      final minute = dt.minute.toString().padLeft(2, '0');

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final recordDate = DateTime(dt.year, dt.month, dt.day);

      if (recordDate == today) {
        return "Today • $hour:$minute $ampm";
      } else if (recordDate == yesterday) {
        return "Yesterday • $hour:$minute $ampm";
      } else {
        final monthNames = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ];
        return "${monthNames[dt.month - 1]} ${dt.day}, ${dt.year} • $hour:$minute $ampm";
      }
    } catch (_) {
      return isoString;
    }
  }

  void _toggleExpand(int id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF3F8),
      appBar: AppBar(
        title: const Text(
          "AI Insights History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff0F172A),
          ),
        ),
        backgroundColor: const Color(0xffEEF3F8),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff0F172A)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _insights.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_toggle_off_rounded,
                    size: 68,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No saved insights yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Run water analysis and save feedback to see logs.",
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _insights.length,
              itemBuilder: (context, index) {
                final row = _insights[index];
                final id = row['id'] as int;
                final isExpanded = _expandedIds.contains(id);

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () => _toggleExpand(id),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatTimestamp(row['timestamp']),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff64748B),
                                  fontSize: 13,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    onPressed: () => _deleteInsight(id),
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    color: Colors.grey[500],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              _badge(
                                "Temp",
                                "${row['temperature']}°C",
                                Colors.orange,
                              ),
                              _badge(
                                "pH Level",
                                "${row['ph_level']}",
                                Colors.green,
                              ),
                              _badge(
                                "Oxygen",
                                "${row['dissolved_oxygen']} mg/L",
                                Colors.teal,
                              ),
                              _badge(
                                "Turbidity",
                                "${row['turbidity']} NTU",
                                Colors.brown,
                              ),
                            ],
                          ),
                          if (isExpanded) ...[
                            const Divider(height: 24, color: Color(0xffF1F5F9)),
                            const Text(
                              "Analysis Insight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            MarkdownBody(
                              data: row['insight'],
                              styleSheet: MarkdownStyleSheet(
                                p: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            if (row['feedback'] != null &&
                                (row['feedback'] as String).isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFF6FF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xffDBEAFE),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.comment_rounded,
                                      color: Color(0xff3B82F6),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Operator Feedback",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff1E40AF),
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            row['feedback'],
                                            style: const TextStyle(
                                              color: Color(0xff1E3A8A),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _badge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.withValues(alpha: 0.9),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
