import 'package:flutter/material.dart';

/// Custom icons for WeTheFuture app
/// These are painted versions of the provided SVG icons

class AppIcons {
  AppIcons._();

  /// Home icon painter
  static Widget home({
    double size = 24,
    Color? color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HomeIconPainter(
        color: color ?? Colors.black,
        filled: filled,
      ),
    );
  }

  /// Book/Learn icon painter
  static Widget book({
    double size = 24,
    Color? color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BookIconPainter(
        color: color ?? Colors.black,
        filled: filled,
      ),
    );
  }

  /// Earth/Explore icon painter
  static Widget explore({
    double size = 24,
    Color? color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ExploreIconPainter(
        color: color ?? Colors.black,
        filled: filled,
      ),
    );
  }

  /// Profile icon painter
  static Widget profile({
    double size = 24,
    Color? color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ProfileIconPainter(
        color: color ?? Colors.black,
        filled: filled,
      ),
    );
  }
}

class _HomeIconPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _HomeIconPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    
    // Scale factor
    final sx = size.width / 24;
    final sy = size.height / 24;

    // Main house path
    path.moveTo(12 * sx, 2.709 * sy);
    path.lineTo(5.85 * sx, 6.252 * sy);
    path.cubicTo(5.32 * sx, 6.556 * sy, 4.89 * sx, 6.992 * sy, 4.59 * sx, 7.517 * sy);
    path.cubicTo(4.29 * sx, 8.042 * sy, 4.13 * sx, 8.637 * sy, 4.13 * sx, 9.243 * sy);
    path.lineTo(4.13 * sx, 18.556 * sy);
    path.cubicTo(4.13 * sx, 19.402 * sy, 4.47 * sx, 20.213 * sy, 5.07 * sx, 20.811 * sy);
    path.cubicTo(5.67 * sx, 21.409 * sy, 6.47 * sx, 21.746 * sy, 7.32 * sx, 21.749 * sy);
    path.lineTo(9.12 * sx, 21.749 * sy);
    path.cubicTo(9.52 * sx, 21.749 * sy, 9.9 * sx, 21.59 * sy, 10.18 * sx, 21.31 * sy);
    path.cubicTo(10.46 * sx, 21.03 * sy, 10.62 * sx, 20.65 * sy, 10.62 * sx, 20.25 * sy);
    path.lineTo(10.62 * sx, 16.099 * sy);
    path.cubicTo(10.62 * sx, 15.836 * sy, 10.73 * sx, 15.583 * sy, 10.91 * sx, 15.397 * sy);
    path.cubicTo(11.1 * sx, 15.211 * sy, 11.35 * sx, 15.106 * sy, 11.61 * sx, 15.106 * sy);
    path.lineTo(12.39 * sx, 15.106 * sy);
    path.cubicTo(12.65 * sx, 15.106 * sy, 12.9 * sx, 15.211 * sy, 13.09 * sx, 15.397 * sy);
    path.cubicTo(13.27 * sx, 15.583 * sy, 13.38 * sx, 15.836 * sy, 13.38 * sx, 16.099 * sy);
    path.lineTo(13.38 * sx, 20.25 * sy);
    path.cubicTo(13.38 * sx, 20.65 * sy, 13.54 * sx, 21.03 * sy, 13.82 * sx, 21.31 * sy);
    path.cubicTo(14.1 * sx, 21.59 * sy, 14.48 * sx, 21.749 * sy, 14.88 * sx, 21.749 * sy);
    path.lineTo(16.68 * sx, 21.749 * sy);
    path.cubicTo(17.53 * sx, 21.746 * sy, 18.33 * sx, 21.409 * sy, 18.93 * sx, 20.811 * sy);
    path.cubicTo(19.53 * sx, 20.213 * sy, 19.87 * sx, 19.402 * sy, 19.87 * sx, 18.556 * sy);
    path.lineTo(19.87 * sx, 9.243 * sy);
    path.cubicTo(19.87 * sx, 8.637 * sy, 19.71 * sx, 8.042 * sy, 19.41 * sx, 7.517 * sy);
    path.cubicTo(19.11 * sx, 6.992 * sy, 18.68 * sx, 6.556 * sy, 18.15 * sx, 6.252 * sy);
    path.lineTo(12 * sx, 2.709 * sy);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BookIconPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _BookIconPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final sx = size.width / 24;
    final sy = size.height / 24;

    // Book outline
    final path = Path();
    
    // Left page and spine
    path.moveTo(3.815 * sx, 5.589 * sy);
    path.cubicTo(3.815 * sx, 3.749 * sy, 5.299 * sx, 2.25 * sy, 7.146 * sx, 2.25 * sy);
    path.lineTo(18.231 * sx, 2.25 * sy);
    path.cubicTo(19.298 * sx, 2.25 * sy, 20.176 * sx, 3.113 * sy, 20.176 * sx, 4.196 * sy);
    path.lineTo(20.177 * sx, 16.006 * sy);
    path.lineTo(20.185 * sx, 19.784 * sy);
    path.cubicTo(20.185 * sx, 20.871 * sy, 19.303 * sx, 21.729 * sy, 18.231 * sx, 21.729 * sy);
    path.lineTo(7.048 * sx, 21.729 * sy);
    path.cubicTo(6.089 * sx, 21.729 * sy, 5.315 * sx, 20.954 * sy, 5.315 * sx, 19.989 * sy);
    path.cubicTo(5.315 * sx, 19.025 * sy, 6.089 * sx, 18.249 * sy, 7.048 * sx, 18.249 * sy);
    path.lineTo(18.678 * sx, 18.249 * sy);
    path.lineTo(18.676 * sx, 4.196 * sy);
    path.cubicTo(18.676 * sx, 3.948 * sy, 18.476 * sx, 3.75 * sy, 18.231 * sx, 3.75 * sy);
    path.lineTo(7.146 * sx, 3.75 * sy);
    path.cubicTo(6.134 * sx, 3.75 * sy, 5.315 * sx, 4.571 * sy, 5.315 * sx, 5.589 * sy);
    path.lineTo(5.315 * sx, 18.499 * sy);
    path.lineTo(3.815 * sx, 18.499 * sy);
    path.lineTo(3.815 * sx, 5.589 * sy);
    path.close();

    // Bookmark
    path.moveTo(11.629 * sx, 16.759 * sy);
    path.lineTo(14.58 * sx, 16.759 * sy);
    path.lineTo(14.58 * sx, 19.907 * sy);
    path.lineTo(13.485 * sx, 19.292 * sy);
    path.cubicTo(13.258 * sx, 19.164 * sy, 12.98 * sx, 19.164 * sy, 12.752 * sx, 19.291 * sy);
    path.lineTo(11.629 * sx, 19.919 * sy);
    path.lineTo(11.629 * sx, 16.759 * sy);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ExploreIconPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _ExploreIconPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final sx = size.width / 24;
    final sy = size.height / 24;

    // Main circle (Earth)
    final center = Offset(12 * sx, 12 * sy);
    final radius = 9 * sx;
    
    if (filled) {
      canvas.drawCircle(center, radius, fillPaint);
    }
    canvas.drawCircle(center, radius, paint);

    // Continent/land paths (simplified)
    final landPaint = Paint()
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Top continent line
    final topPath = Path();
    topPath.moveTo(20.61 * sx, 8.088 * sy);
    topPath.cubicTo(19.67 * sx, 8.023 * sy, 17.97 * sx, 8.303 * sy, 15.47 * sx, 10.101 * sy);
    topPath.cubicTo(12.49 * sx, 12.246 * sy, 11.81 * sx, 7.713 * sy, 12.75 * sx, 3.013 * sy);
    canvas.drawPath(topPath, landPaint);

    // Left continent line
    final leftPath = Path();
    leftPath.moveTo(12.1 * sx, 21 * sy);
    leftPath.cubicTo(12.1 * sx, 21 * sy, 12.71 * sx, 18.464 * sy, 10.96 * sx, 17.092 * sy);
    leftPath.cubicTo(9.2 * sx, 15.721 * sy, 7.89 * sx, 15.821 * sy, 7.67 * sx, 14.077 * sy);
    leftPath.cubicTo(7.45 * sx, 12.334 * sy, 9.61 * sx, 12.041 * sy, 8.03 * sx, 9.446 * sy);
    leftPath.cubicTo(6.99 * sx, 7.733 * sy, 5.82 * sx, 6.66 * sy, 5.86 * sx, 5.951 * sy);
    canvas.drawPath(leftPath, landPaint);

    // Right continent line
    final rightPath = Path();
    rightPath.moveTo(17.88 * sx, 19.098 * sy);
    rightPath.cubicTo(17.88 * sx, 19.098 * sy, 15.71 * sx, 13.095 * sy, 21.5 * sx, 12 * sy);
    canvas.drawPath(rightPath, landPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProfileIconPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _ProfileIconPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final sx = size.width / 24;
    final sy = size.height / 24;

    // Head circle
    final headCenter = Offset(12 * sx, 7 * sy);
    final headRadius = 4 * sx;
    canvas.drawCircle(headCenter, headRadius, paint);

    // Body arc
    final bodyPath = Path();
    bodyPath.moveTo(4.406 * sx, 18.756 * sy);
    bodyPath.cubicTo(4.406 * sx, 15.951 * sy, 7.883 * sx, 13.581 * sy, 12 * sx, 13.581 * sy);
    bodyPath.cubicTo(16.117 * sx, 13.581 * sy, 19.595 * sx, 15.941 * sy, 19.595 * sx, 18.734 * sy);
    bodyPath.cubicTo(19.595 * sx, 22.381 * sy, 13.878 * sx, 22.381 * sy, 12 * sx, 22.381 * sy);
    bodyPath.cubicTo(10.122 * sx, 22.381 * sy, 4.406 * sx, 22.381 * sy, 4.406 * sx, 18.756 * sy);
    bodyPath.close();
    
    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
