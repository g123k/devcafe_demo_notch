import 'package:pigeon/pigeon.dart';

enum PathMovementType {
  move,
  line,
  quadratic,
  conic,
  cubic,
  close,
  done,
}

class PathSegment {
  PathMovementType? type;
  List<Float64List?>? points;
}

class Path {
  List<PathSegment?>? segments;
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/dart_api.dart',
  objcHeaderOut: 'ios/Runner/dart_api.h',
  objcSourceOut: 'ios/Runner/dart_api.m',
  javaOut: 'android/app/src/main/kotlin/com/example/devcafe_app/DartAPI.java',
  javaOptions: JavaOptions(package: 'com.example.devcafe_app'),
))
@HostApi()
abstract class NotchApi {
  Path? getNotchPath();
  bool hasNotch();
}
