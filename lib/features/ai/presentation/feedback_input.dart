import 'package:flutter/material.dart';

class FeedbackInput extends StatefulWidget {
  final ValueChanged<String>? onSendFeedback;

  const FeedbackInput({super.key, this.onSendFeedback});

  @override
  State<FeedbackInput> createState() => FeedbackInputState();
}

class FeedbackInputState extends State<FeedbackInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _fadeAnimation;

  bool _showFeedback = false;
  bool _isTextEmpty = true;
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
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _animationController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    final currentlyEmpty = _controller.text.trim().isEmpty;
    if (currentlyEmpty != _isTextEmpty) {
      setState(() {
        _isTextEmpty = currentlyEmpty;
      });
    }
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
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
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
                // left: 12.0,
                // right: 12.0,
                bottom: 12.0,
                // top: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
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
                      AnimatedOpacity(
                        opacity: _isTextEmpty ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: _isTextEmpty
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Material(
                                      color: const Color(0xff0F62FE),
                                      borderRadius: BorderRadius.circular(8),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.send_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          final text = _controller.text.trim();
                                          if (text.isNotEmpty && widget.onSendFeedback != null) {
                                            widget.onSendFeedback!(text);
                                          }
                                          // Clear input and remove focus on send
                                          _controller.clear();
                                          _focusNode.unfocus();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Disclaimer: The prompt must be relevant to the AI insights, such as a correction or a follow-up question.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
