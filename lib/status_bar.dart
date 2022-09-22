import 'package:devcafe_app/dart_api.dart';
import 'package:devcafe_app/notch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusBarProgress extends StatelessWidget {
  final Widget child;
  final StatusBarProgressController _controller;

  StatusBarProgress({
    required this.child,
    Key? key,
  })  : _controller = StatusBarProgressController._(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatusBarProgressController>(
      create: (_) => _controller,
      child: ScrollNotificationObserver(
        child: _StatusBarProgressContent(
          child: child,
        ),
      ),
    );
  }
}

class _StatusBarProgressContent extends StatelessWidget {
  final Widget child;

  const _StatusBarProgressContent({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: NotchApi().hasNotch(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data == true
              ? NotchProgress(child: child)
              : _StatusBarProgress(child: child);
        } else {
          return child;
        }
      },
    );
  }
}

class _StatusBarProgress extends StatelessWidget {
  final Widget child;

  const _StatusBarProgress({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _StatusBarPainter(
        statusBarHeight: MediaQuery.of(context).padding.top,
        progress: Provider.of<StatusBarProgressController>(context).progress,
      ),
      child: child,
    );
  }
}

class _StatusBarPainter extends CustomPainter {
  _StatusBarPainter({
    required this.statusBarHeight,
    required this.progress,
  }) : assert(progress >= 0.0 && progress <= 1.0);

  final double statusBarHeight;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width * progress, statusBarHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(_StatusBarPainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(_StatusBarPainter oldDelegate) => false;
}

class StatusBarProgressController extends ChangeNotifier {
  StatusBarProgressController._({
    double progress = 0.0,
  }) : _progress = progress;

  double _progress;

  set progress(double progress) {
    _progress = progress;
    notifyListeners();
  }

  double get progress => _progress;

  static StatusBarProgressController? of(BuildContext context,
      {bool listen = false}) {
    try {
      return Provider.of<StatusBarProgressController>(context, listen: listen);
    } catch (err) {
      return null;
    }
  }
}
