import 'package:flutter/material.dart';

class FeedbackInput extends StatefulWidget {
  const FeedbackInput({super.key});

  @override
  State<FeedbackInput> createState() => FeedbackInputState();
}

class FeedbackInputState extends State<FeedbackInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _fadeAnimation;

  bool _showFeedback = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleFeedback(bool value) {
    setState(() {
      _showFeedback = value;
      if (_showFeedback) {
        _animationController.forward();
        // Request focus when the field starts animating in to make it ready for input.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNode.requestFocus();
        });
      } else {
        _animationController.reverse();
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => _toggleFeedback(!_showFeedback),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _showFeedback,
                  onChanged: (value) => _toggleFeedback(value ?? false),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Add Feedback',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: -1.0,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 12.0,
                top: 4.0,
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Type your feedback here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
