import 'dart:math';
import 'package:flutter/material.dart';

class PremiumAnalyzeButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const PremiumAnalyzeButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<PremiumAnalyzeButton> createState() => _PremiumAnalyzeButtonState();
}

class _PremiumAnalyzeButtonState extends State<PremiumAnalyzeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Faster sweep
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null;

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double targetWidth = constraints.maxWidth - 16;

          return GestureDetector(
            onTapDown: isEnabled && !widget.isLoading
                ? (_) => setState(() => _scale = 0.90) // More noticeable press (0.90 instead of 0.95)
                : null,
            onTapUp: isEnabled && !widget.isLoading
                ? (_) => setState(() => _scale = 1.0)
                : null,
            onTapCancel: isEnabled && !widget.isLoading
                ? () => setState(() => _scale = 1.0)
                : null,
            onTap: isEnabled && !widget.isLoading ? widget.onPressed : null,
            child: AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 100),
              child: AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  // Pulse shadow blur and spread in sync with the shimmer
                  final pulse = sin(_shimmerController.value * 2 * pi);
                  final shadowAlpha = 0.35 + (pulse * 0.1);
                  final blurRadius = 14.0 + (pulse * 4.0);
                  final spreadRadius = pulse * 1.5;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 54,
                    // Remains rectangular
                    width: targetWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F62FE), Color(0xFF0043CE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F62FE).withValues(alpha: shadowAlpha),
                          blurRadius: blurRadius,
                          spreadRadius: spreadRadius,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Shimmer shine animation runs continuously
                          Positioned.fill(
                            child: FractionallySizedBox(
                              widthFactor: 2.0,
                              alignment: Alignment(
                                -2.0 + _shimmerController.value * 4.0,
                                0.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.0),
                                      Colors.white.withValues(alpha: 0.45), // Brighter shine
                                      Colors.white.withValues(alpha: 0.0),
                                    ],
                                    stops: const [0.4, 0.5, 0.6], // Sharper profile
                                    transform: const GradientRotation(0.3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Button Content
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: widget.isLoading
                                ? const SizedBox(
                                    key: ValueKey('loader'),
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    key: const ValueKey('text_content'),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.science_outlined, color: Colors.white, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "Analyze Conditions",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
