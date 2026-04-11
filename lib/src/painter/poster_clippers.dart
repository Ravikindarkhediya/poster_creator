import 'package:flutter/material.dart';

class WavyProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double waveHeight = size.height * 0.16;
    final double waveWidth = size.width / 1;
    path.moveTo(0, waveHeight);
    for (var i = 0; i < 20; i++) {
      path.relativeQuadraticBezierTo(
          waveWidth / 4, -waveHeight, waveWidth / 2, 0);
      path.relativeQuadraticBezierTo(
          waveWidth / 4, waveHeight, waveWidth / 2, 0);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class WavyTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double waveHeight = size.height * 0.18;
    final double waveWidth = size.width / 10;
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - waveHeight);
    for (var i = 0; i < 10; i++) {
      path.relativeQuadraticBezierTo(
          -waveWidth / 4, waveHeight, -waveWidth / 2, 0);
      path.relativeQuadraticBezierTo(
          -waveWidth / 4, -waveHeight, -waveWidth / 2, 0);
    }
    path.lineTo(0, size.height - waveHeight);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class WavyEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double startY = size.height * 0.2;
    path.moveTo(0, startY);
    double waveHeight = size.height * 0.1;
    double waveWidth = size.width / 10;
    for (var i = 0; i < 10; i++) {
      path.relativeQuadraticBezierTo(
          waveWidth / 4, -waveHeight, waveWidth / 2, 0);
      path.relativeQuadraticBezierTo(
          waveWidth / 4, waveHeight, waveWidth / 2, 0);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class SleekRibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - size.height * 0.4, size.height * 0.5)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class ModernAngledBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.height * 0.5, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - size.height * 0.5, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class ModernAngledTagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - size.height * 0.3, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class SharpAngleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double angleOffset = size.height * 0.18;
    path.moveTo(0, angleOffset);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class SharpAngleClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double angleOffset = size.height * 0.18;
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - angleOffset);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class NotchClipper extends CustomClipper<Path> {
  final double avatarRadius;
  final double centerX;

  NotchClipper({required this.avatarRadius, required this.centerX});

  @override
  Path getClip(Size size) {
    final path = Path();
    final notchRadius = avatarRadius + 8;
    path.lineTo(0, 0);
    path.lineTo(centerX - notchRadius, 0);
    path.arcToPoint(
      Offset(centerX + notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class NotchClipperBottom extends CustomClipper<Path> {
  final double avatarRadius;
  final double centerX;

  NotchClipperBottom({required this.avatarRadius, required this.centerX});

  @override
  Path getClip(Size size) {
    final notchRadius = avatarRadius + 8;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(centerX + notchRadius, size.height);
    path.arcToPoint(
      Offset(centerX - notchRadius, size.height),
      radius: Radius.circular(notchRadius),
      clockwise: true,
    );
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class DiagonalSlashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double cutHeight = size.height * 0.5;
    path.moveTo(0, cutHeight);
    path.lineTo(size.width, cutHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class DiagonalSlashAccentClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double topLine = size.height * 0.55;
    final double bottomLine = size.height * 0.62;
    path.moveTo(0, topLine);
    path.lineTo(size.width, topLine);
    path.lineTo(size.width, bottomLine);
    path.lineTo(0, bottomLine);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class ArcRevealClipper extends CustomClipper<Path> {
  final double arcHeightFraction;

  const ArcRevealClipper({required this.arcHeightFraction});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double centerY = size.height * arcHeightFraction;
    final double radiusX = size.width * 0.72;
    final double radiusY = size.height * 0.48;
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, centerY);
    path.arcToPoint(
      Offset(0, centerY),
      radius: Radius.elliptical(radiusX, radiusY),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(ArcRevealClipper old) =>
      old.arcHeightFraction != arcHeightFraction;
}

class CornerBadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - size.height * 0.5, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width - size.height * 0.5, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}
