import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:portfolio/constants/colors.dart';

/// Wraps the portfolio with a soft, cursor-reactive ambient glow and
/// optional custom cursor ring for pointer devices.
class CursorGlowBackground extends StatefulWidget {
  final Widget child;

  const CursorGlowBackground({super.key, required this.child});

  @override
  State<CursorGlowBackground> createState() => _CursorGlowBackgroundState();
}

class _CursorGlowBackgroundState extends State<CursorGlowBackground>
    with SingleTickerProviderStateMixin {
  Offset? _target;
  Offset? _current;
  bool _isPointerActive = false;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final target = _target;
    if (target == null) return;

    final current = _current ?? target;
    final next = Offset.lerp(current, target, 0.08)!;

    if (_current == null || (next - current).distance > 0.05) {
      setState(() => _current = next);
    }
  }

  void _updateTarget(PointerEvent event) {
    setState(() {
      _target = event.position;
      _isPointerActive = true;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringCenter = _current;
    final dotCenter = _target;
    final isDesktopWeb = kIsWeb && MediaQuery.of(context).size.width >= 768;

    return MouseRegion(
      cursor: isDesktopWeb ? SystemMouseCursors.none : MouseCursor.defer,
      onExit: (_) {
        setState(() {
          _isPointerActive = false;
        });
      },
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: _updateTarget,
        onPointerMove: _updateTarget,
        child: Stack(
          children: [
            widget.child,
            if (ringCenter != null && _isPointerActive)
              Positioned.fill(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: _CursorGlowPainter(center: ringCenter),
                    ),
                  ),
                ),
              ),
            if (isDesktopWeb && dotCenter != null && _isPointerActive)
              IgnorePointer(
                child: RepaintBoundary(
                  child: _CustomCursor(
                    dotCenter: dotCenter,
                    ringCenter: ringCenter ?? dotCenter,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomCursor extends StatelessWidget {
  final Offset dotCenter;
  final Offset ringCenter;

  const _CustomCursor({required this.dotCenter, required this.ringCenter});

  static const double _ringSize = 34;
  static const double _dotSize = 8;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: ringCenter.dx - _ringSize / 2,
          top: ringCenter.dy - _ringSize / 2,
          child: Container(
            width: _ringSize,
            height: _ringSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: WebColors.greenBright.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          left: dotCenter.dx - _dotSize / 2,
          top: dotCenter.dy - _dotSize / 2,
          child: Container(
            width: _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: WebColors.greenBright,
              boxShadow: [
                BoxShadow(
                  color: WebColors.greenBright.withValues(alpha: 0.7),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CursorGlowPainter extends CustomPainter {
  final Offset center;

  _CursorGlowPainter({required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    // Primary glow, tight and bright, right at the cursor.
    _blob(canvas, center, 280, WebColors.greenBright, 0.09);
    // Secondary, larger and dimmer cyan glow offset for rich color depth.
    _blob(canvas, center.translate(-90, 60), 340, WebColors.cyanAccent, 0.04);
  }

  void _blob(Canvas canvas, Offset position, double radius, Color color, double opacity) {
    final paint = Paint()
      ..blendMode = BlendMode.plus
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: opacity),
          color.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: position, radius: radius));
    canvas.drawCircle(position, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _CursorGlowPainter oldDelegate) => oldDelegate.center != center;
}
