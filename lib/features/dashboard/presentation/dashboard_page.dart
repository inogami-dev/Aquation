import 'package:aquation/features/ai/domain/sensor_data.dart';
import 'package:flutter/material.dart';
import 'widgets/parameter_detail_page.dart';

class InAppNotification {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required Color color,
  }) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: _NotificationBanner(
              title: title,
              message: message,
              color: color,
              onDismiss: () {
                overlayEntry.remove();
              },
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    // Auto dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

class _NotificationBanner extends StatefulWidget {
  final String title;
  final String message;
  final Color color;
  final VoidCallback onDismiss;

  const _NotificationBanner({
    required this.title,
    required this.message,
    required this.color,
    required this.onDismiss,
  });

  @override
  State<_NotificationBanner> createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<_NotificationBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: widget.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.message,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              color: Colors.grey[400],
              onPressed: _dismiss,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _wasHealthy = true;

  @override
  void initState() {
    super.initState();
    SensorData.parametersNotifier.addListener(_onParametersChanged);

    // Set initial state
    final parameters = SensorData.parametersNotifier.value;
    _wasHealthy = !_checkIfAnyUnhealthy(parameters);
  }

  @override
  void dispose() {
    SensorData.parametersNotifier.removeListener(_onParametersChanged);
    super.dispose();
  }

  bool _checkIfAnyUnhealthy(List<SensorInfo> parameters) {
    return parameters.any(
      (p) =>
          p.status == "Toxic" ||
          p.status == "Critical" ||
          p.status == "Warning" ||
          p.status == "High" ||
          p.status == "Acidic" ||
          p.status == "Alkaline",
    );
  }

  void _onParametersChanged() {
    if (!mounted) return;

    final parameters = SensorData.parametersNotifier.value;
    final isUnhealthy = _checkIfAnyUnhealthy(parameters);
    final isHealthy = !isUnhealthy;

    // Trigger alert only when water quality transitioning from healthy -> unhealthy
    if (isUnhealthy && _wasHealthy) {
      final badParams = parameters
          .where(
            (p) =>
                p.status == "Toxic" ||
                p.status == "Critical" ||
                p.status == "Warning" ||
                p.status == "High" ||
                p.status == "Acidic" ||
                p.status == "Alkaline",
          )
          .map((p) => p.title)
          .join(", ");

      InAppNotification.show(
        context,
        title: "Water Quality Alert",
        message: "Attention Required! Unhealthy levels detected: $badParams",
        color: const Color(0xffEF4444),
      );
    }

    _wasHealthy = isHealthy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xffF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Good Afternoon 👋",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Inogami",
              style: TextStyle(
                color: Color(0xff0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              SensorData.randomize();
            },
            child: Container(width: 60, height: 60, color: Colors.transparent),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<SensorInfo>>(
        valueListenable: SensorData.parametersNotifier,
        builder: (context, parameters, child) {
          final isHealthy = !_checkIfAnyUnhealthy(parameters);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                _buildOverviewCard(isHealthy),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildWeatherForecastCard(context),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: parameters.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1.15,
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
                                      value: parameter.value,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isHealthy
              ? [const Color(0xff0F62FE), const Color(0xff0043CE)]
              : [const Color(0xffE11D48), const Color(0xff9F1239)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (isHealthy ? Colors.blue : Colors.red).withOpacity(.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -40,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.04),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isHealthy
                            ? Icons.water_drop_rounded
                            : Icons.warning_amber_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Water Quality",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isHealthy ? "HEALTHY" : "ATTENTION REQUIRED",
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isHealthy
                              ? Icons.check_circle_rounded
                              : Icons.info_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isHealthy
                              ? "All parameters are within range"
                              : "Some parameters need checking",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Updated • Just Now",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherForecastCard(BuildContext context) {
    final forecasts = SensorData.weatherForecasts;
    final today = forecasts[0];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xffE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xffEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Pond Area",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0F62FE),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Today's weather highlight
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Icon(today.icon, color: Colors.orange, size: 36),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${today.temp.toStringAsFixed(1)}°C",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0F172A),
                            ),
                          ),
                          Text(
                            "Today • ${today.condition}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 32, width: 1, color: const Color(0xffE2E8F0)),
              const SizedBox(width: 12),
              // Upcoming days
              Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeatherForecastItem(forecasts[1].dayName, forecasts[1].icon, "${forecasts[1].temp.toStringAsFixed(1)}°", Colors.blue[600]!),
                    _buildWeatherForecastItem(forecasts[2].dayName, forecasts[2].icon, "${forecasts[2].temp.toStringAsFixed(1)}°", Colors.grey[600]!),
                    _buildWeatherForecastItem(forecasts[3].dayName, forecasts[3].icon, "${forecasts[3].temp.toStringAsFixed(1)}°", Colors.orange[600]!),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherForecastItem(String day, IconData icon, String temp, Color color) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xff64748B),
          ),
        ),
        const SizedBox(height: 4),
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 4),
        Text(
          temp,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xff0F172A),
          ),
        ),
      ],
    );
  }
}

class _ParameterCard extends StatefulWidget {
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
  State<_ParameterCard> createState() => _ParameterCardState();
}

class _ParameterCardState extends State<_ParameterCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.93, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: const Color(0xffE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon, color: widget.color, size: 22),
                    ),
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.color.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: widget.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.status,
                              style: TextStyle(
                                color: widget.color,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff64748B),
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.value,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color(0xff0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " ${widget.unit}",
                          style: const TextStyle(
                            color: Color(0xff94A3B8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
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
    );
  }
}
