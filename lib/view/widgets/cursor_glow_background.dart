// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:portfolio/constants/colors.dart';
//
// /// Wraps the whole app with a soft, cursor-reactive ambient glow —
// /// similar to the interactive background on antigravity.google.
// ///
// /// How it works:
// /// - A [Listener] tracks the live pointer/mouse position (works with
// ///   mouse hover on web/desktop, and with drag on touch devices).
// /// - A [Ticker] smoothly eases ("lerps") the glow's position toward the
// ///   cursor every frame instead of snapping instantly, which is what
// ///   gives it that floaty, trailing feel.
// /// - The glow itself is painted with an ADDITIVE blend mode
// ///   ([BlendMode.plus]) directly ON TOP of all screen content, at very
// ///   low opacity. Because it only brightens (never darkens or covers)
// ///   whatever is underneath, it doesn't require every screen's
// ///   [Scaffold] to be made transparent — it simply overlays a subtle
// ///   highlight wherever the cursor goes.
// /// - The overlay is wrapped in [IgnorePointer], so it never blocks
// ///   clicks, hovers, or scrolling on the real UI beneath it.
// ///
// /// Usage: wrap the whole app once, e.g. in `MyApp`:
// /// ```dart
// /// GetMaterialApp(
// ///   builder: (context, child) => CursorGlowBackground(child: child!),
// ///   ...
// /// )
// /// ```
// class CursorGlowBackground extends StatefulWidget {
//   final Widget child;
//
//   const CursorGlowBackground({super.key, required this.child});
//
//   @override
//   State<CursorGlowBackground> createState() => _CursorGlowBackgroundState();
// }
//
// class _CursorGlowBackgroundState extends State<CursorGlowBackground>
//     with SingleTickerProviderStateMixin {
//   Offset? _target;
//   Offset? _current;
//   late final Ticker _ticker;
//
//   @override
//   void initState() {
//     super.initState();
//     _ticker = createTicker(_onTick)..start();
//   }
//
//   void _onTick(Duration elapsed) {
//     final target = _target;
//     if (target == null) return;
//
//     final current = _current ?? target;
//     final next = Offset.lerp(current, target, 0.07)!;
//
//     // Only rebuild while actually moving/settling, so the glow stops
//     // repainting once it has caught up to a stationary cursor.
//     if (_current == null || (next - current).distance > 0.05) {
//       setState(() => _current = next);
//     }
//   }
//
//   void _updateTarget(PointerEvent event) {
//     _target = event.position;
//   }
//
//   @override
//   void dispose() {
//     _ticker.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final current = _current;
//
//     return Listener(
//       behavior: HitTestBehavior.translucent,
//       onPointerHover: _updateTarget,
//       onPointerMove: _updateTarget,
//       child: Stack(
//         children: [
//           widget.child,
//           if (current != null)
//             Positioned.fill(
//               child: IgnorePointer(
//                 child: RepaintBoundary(
//                   child: CustomPaint(
//                     painter: _CursorGlowPainter(center: current),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _CursorGlowPainter extends CustomPainter {
//   final Offset center;
//
//   _CursorGlowPainter({required this.center});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Primary glow, tight and bright, right at the cursor.
//     _blob(canvas, center, 260, WebColors.greenBright, 0.10);
//     // Secondary, larger and dimmer glow offset behind it for depth.
//     _blob(canvas, center.translate(-120, 80), 320, WebColors.greenPrimary, 0.05);
//   }
//
//   void _blob(Canvas canvas, Offset position, double radius, Color color, double opacity) {
//     final paint = Paint()
//       ..blendMode = BlendMode.plus
//       ..shader = RadialGradient(
//         colors: [
//           color.withValues(alpha: opacity),
//           color.withValues(alpha: 0),
//         ],
//       ).createShader(Rect.fromCircle(center: position, radius: radius));
//     canvas.drawCircle(position, radius, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant _CursorGlowPainter oldDelegate) => oldDelegate.center != center;
// }

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:portfolio/constants/colors.dart';

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
    final next = Offset.lerp(current, target, 0.07)!;

    // Only rebuild while actually moving/settling, so the glow stops
    // repainting once it has caught up to a stationary cursor.
    if (_current == null || (next - current).distance > 0.05) {
      setState(() => _current = next);
    }
  }

  void _updateTarget(PointerEvent event) {
    // The dot must track the pointer with zero lag, so this updates
    // immediately (separate from the ticker-driven ring/glow lerp).
    setState(() => _target = event.position);
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

    return MouseRegion(
      // Hide the native system cursor everywhere in the app.
      cursor: SystemMouseCursors.none,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: _updateTarget,
        onPointerMove: _updateTarget,
        child: Stack(
          children: [
            widget.child,
            if (ringCenter != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: _CursorGlowPainter(center: ringCenter),
                    ),
                  ),
                ),
              ),
            if (dotCenter != null)
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

  static const double _ringSize = 32;
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
                color: WebColors.greenBright.withValues(alpha: 0.6),
                width: 1.4,
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
                  color: WebColors.greenBright.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
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
    _blob(canvas, center, 260, WebColors.greenBright, 0.10);
    // Secondary, larger and dimmer glow offset behind it for depth.
    _blob(canvas, center.translate(-120, 80), 320, WebColors.greenPrimary, 0.05);
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
