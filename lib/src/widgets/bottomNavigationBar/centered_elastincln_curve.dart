import 'package:flutter/material.dart';
import 'dart:math' as math;

class CenteredElasticOutCurve extends Curve {
  final double period;
  CenteredElasticOutCurve([this.period = 0.4]);
  @override
  double transform(double t) {
    // TODO: implement transform
    return math.pow(2.0, -10.0 * t) * math.sin(t * 0.2 * math.pi / period) +
        0.5;
  }
}

class CenteredElasticInCurve extends Curve {
  final double period;
  CenteredElasticInCurve([this.period = 0.1]);
  @override
  double transform(double t) {
    // TODO: implement transform
    return -math.pow(2.0, 10.0 * (t - 1.0)) *
            math.sin((t - 1.0) * 2.0 * math.pi / period) +
        0.5;
  }
}

class LinearPointCurve extends Curve {
  final double pIn;
  final double pOut;
  LinearPointCurve({this.pIn, this.pOut});

  @override
  double transform(double t) {
    // TODO: implement transform
    final lowerScale = pOut / pIn;
    final upperScale = (1.0 - pOut) / (1.0 / pIn);
    final upperOffset = 1.0 - upperScale;
    return t < pIn ? t * lowerScale : t * upperScale + upperOffset;
  }
}
