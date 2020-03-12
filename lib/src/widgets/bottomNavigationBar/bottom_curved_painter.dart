import 'package:flutter/material.dart';
import './centered_elastincln_curve.dart';

class BackGroundCurvePainter extends CustomPainter {
  static const RADIUS_TOP = 50.0;
  static const RADIUS_BOTTOM = 30.0;
  static const HORIZONTAL_TOP = 0.6;
  static const HORIZONTAL_BOTTOM = 0.5;
  static const POINT_TOP = 0.35;
  static const POINT_BOTTOM = 0.85;
  static const TOP_Y = -60.0;
  static const BOTTOM_Y = 0.0;
  static const TOP_DISTANCE = 0.0;
  static const BOTTOM_DISTANCE = 10.0;

  final double _x;
  final double _normalizedY;
  final Color _color;
  BackGroundCurvePainter(double x, double normalizedY, Color color)
      : _x = x,
        _normalizedY = normalizedY,
        _color = color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final norm =
        LinearPointCurve(pIn: 0.5, pOut: 2.0).transform(_normalizedY) / 5;
    final radius =
        Tween<double>(begin: RADIUS_TOP, end: RADIUS_BOTTOM).transform(norm);
    final anchorControlOffset = Tween<double>(
            begin: radius * HORIZONTAL_TOP, end: radius * HORIZONTAL_BOTTOM)
        .transform(LinearPointCurve(pIn: 0.5, pOut: 0.75).transform(norm));
    final dipControlOffset = Tween<double>(
      begin: radius * POINT_TOP,
      end: radius * POINT_BOTTOM,
    ).transform(LinearPointCurve(pIn: 0.2, pOut: 0.7).transform(norm));
    final y = Tween<double>(begin: TOP_Y, end: BOTTOM_Y)
        .transform(LinearPointCurve(pIn: 0.2, pOut: 0.7).transform(norm));
    final dist = Tween<double>(begin: TOP_DISTANCE, end: BOTTOM_DISTANCE)
        .transform(LinearPointCurve(pIn: 0.5, pOut: 0.0).transform(norm));
    final x0 = _x - dist / 2;
    final x1 = _x + dist / 2;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x0 - radius, 0)
      ..cubicTo(
          x0 - radius + anchorControlOffset, 0, x0 - dipControlOffset, y, x0, y)
      ..lineTo(x1, y)
      ..cubicTo(x1 + dipControlOffset, y, x1 + radius - anchorControlOffset, 0,
          x1 + radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    final paint = Paint()..color = _color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackGroundCurvePainter oldDelegate) {
    // TODO: implement shouldRepaint
    return _x != oldDelegate._x ||
        _normalizedY != oldDelegate._normalizedY ||
        _color != oldDelegate._color;
  }
}
