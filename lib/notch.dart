import 'dart:math' as math;
import 'dart:ui';

import 'package:devcafe_app/dart_api.dart' as notch;
import 'package:devcafe_app/status_bar.dart';
import 'package:devcafe_app/utils.dart';
import 'package:flutter/material.dart';

class NotchProgress extends StatefulWidget {
  final Widget child;

  const NotchProgress({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<NotchProgress> createState() => _NotchProgressState();
}

class _NotchProgressState extends State<NotchProgress> {
  notch.Path? _notchPath;

  @override
  void initState() {
    super.initState();
    _computeNotchPath();
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        StatusBarProgressController.of(context, listen: true)?.progress ?? 0.0;

    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        if (_notchPath != null)
          Positioned.fill(
            child: CustomPaint(
              foregroundPainter: _NotchPainter(
                _notchPath!.toPath(MediaQuery.of(context).devicePixelRatio),
                _notchPath!.circular,
                progress,
              ),
            ),
          ),
      ],
    );
  }

  void _computeNotchPath() async {
    _notchPath = await notch.NotchApi().getNotchPath();
    setState(() {});
  }
}

class _NotchPainter extends CustomPainter {
  _NotchPainter(
    this.path,
    this.circular,
    this.progress,
  ) : _paint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5.0;

  final Path? path;
  final bool circular;
  final double progress;

  final Paint _paint;

  Path? _linePath;

  @override
  void paint(Canvas canvas, Size size) {
    double progress = this.progress.clamp(0.0, 1.0);

    // Circle
    if (circular && path?.isSquare == true) {
      Rect bounds = path!.getBounds();

      canvas.drawArc(
        bounds,
        math.pi * 1.5,
        (math.pi * 2) * progress,
        false,
        _paint,
      );
    } else {
      if (_linePath == null) {
        _linePath = Path();
        _linePath!.moveTo(0, 0);

        double start = path!.getBounds().left;

        for (double i = 0; i <= start; i++) {
          _linePath!.addRect(Rect.fromLTRB(i, 0, i + 1, 1.0));
        }

        for (double i = path!.getBounds().right; i <= size.width; i++) {
          _linePath!.addRect(Rect.fromLTRB(i, 0, i + 1, 1.0));
        }

        _linePath!.close();
      }

      PathMetric combinedPath = Path.combine(
        PathOperation.union,
        _linePath!,
        path!,
      ).computeMetrics().first;

      double totalPoints = _linePath!.computeMetrics().length +
          path!.computeMetrics().first.length;

      canvas.drawPath(
        combinedPath.extractPath(0, totalPoints * progress,
            startWithMoveTo: false),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(_NotchPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
