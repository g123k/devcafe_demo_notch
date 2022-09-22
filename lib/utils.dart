import 'dart:typed_data';
import 'dart:ui';

import 'package:devcafe_app/dart_api.dart' as notch;

extension NotchPathExtension on notch.Path {
  Path toPath(double devicePixelRatio) {
    Path path = Path();

    if (segments!.first!.type == notch.PathMovementType.line) {
      _moveInstruction(path, segments!.first!.points!, devicePixelRatio);
    }

    for (notch.PathSegment? segment in segments!) {
      // ignore: missing_enum_constant_in_switch
      switch (segment!.type) {
        case notch.PathMovementType.move:
          _moveInstruction(path, segment.points!, devicePixelRatio);
          break;
        case notch.PathMovementType.quadratic:
          _quadraticInstruction(path, segment.points!, devicePixelRatio);
          break;
        case notch.PathMovementType.line:
          _lineInstruction(path, segment.points!, devicePixelRatio);
          break;
        case notch.PathMovementType.cubic:
          _cubicInstruction(path, segment.points!, devicePixelRatio);
          break;
        case notch.PathMovementType.close:
          _closeInstruction(path);
          break;
        default:
          throw UnimplementedError();
      }
    }

    return path;
  }

  bool get circular {
    notch.PathSegment? first = segments!.firstWhere(
        (element) => element!.type == notch.PathMovementType.quadratic,
        orElse: () => null);
    notch.PathSegment? last = segments!.lastWhere(
        (element) => element!.type == notch.PathMovementType.quadratic,
        orElse: () => null);

    return first?.points?.first!.isEqual(last?.points?.last) ?? false;
  }

  void _moveInstruction(
    Path path,
    List<Float64List?> points,
    double pixelRatio,
  ) {
    path.moveTo(
      points[0]![0] / pixelRatio,
      points[0]![1] / pixelRatio,
    );
  }

  void _quadraticInstruction(
    Path path,
    List<Float64List?> points,
    double pixelRatio,
  ) {
    path.quadraticBezierTo(
      points[1]![0] / pixelRatio,
      points[1]![1] / pixelRatio,
      points[2]![0] / pixelRatio,
      points[2]![1] / pixelRatio,
    );
  }

  void _lineInstruction(
    Path path,
    List<Float64List?> points,
    double pixelRatio,
  ) {
    path.lineTo(points[0]![0] / pixelRatio, points[0]![1] / pixelRatio);
  }

  void _cubicInstruction(
    Path path,
    List<Float64List?> points,
    double pixelRatio,
  ) {
    path.cubicTo(
      points[0]![0] / pixelRatio,
      points[0]![1] / pixelRatio,
      points[1]![0] / pixelRatio,
      points[1]![1] / pixelRatio,
      points[2]![0] / pixelRatio,
      points[2]![1] / pixelRatio,
    );
  }

  void _closeInstruction(Path path) {
    path.close();
  }
}

extension PathExtension on Path {
  bool get isSquare =>
      getBounds().width.toStringAsFixed(1) ==
      getBounds().height.toStringAsFixed(1);
}

extension Float64ListExt on Float64List {
  bool isEqual(Float64List? list) {
    if (list == null) {
      return false;
    } else if (list.length != length) {
      return false;
    }

    for (int i = 0; i < length; i++) {
      if (this[i] != list[i]) {
        return false;
      }
    }

    return true;
  }
}
