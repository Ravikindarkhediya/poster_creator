import 'package:flutter/material.dart';

class WavyProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const wH = 0.16;
    const wW = 1.0;
    path.moveTo(0, size.height * wH);
    for (var i = 0; i < 20; i++) {
      path.relativeQuadraticBezierTo(
        size.width * wW / 4,
        -size.height * wH,
        size.width * wW / 2,
        0,
      );
      path.relativeQuadraticBezierTo(
        size.width * wW / 4,
        size.height * wH,
        size.width * wW / 2,
        0,
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class WavyTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final wH = size.height * 0.18;
    final wW = size.width / 10;
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - wH);
    for (var i = 0; i < 10; i++) {
      path.relativeQuadraticBezierTo(-wW / 4, wH, -wW / 2, 0);
      path.relativeQuadraticBezierTo(-wW / 4, -wH, -wW / 2, 0);
    }
    path.lineTo(0, size.height - wH);
    return path..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class WavyEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final startY = size.height * 0.2;
    final wH = size.height * 0.1;
    final wW = size.width / 10;
    path.moveTo(0, startY);
    for (var i = 0; i < 10; i++) {
      path.relativeQuadraticBezierTo(wW / 4, -wH, wW / 2, 0);
      path.relativeQuadraticBezierTo(wW / 4, wH, wW / 2, 0);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class SleekRibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width - size.height * 0.4, size.height * 0.5)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();
  @override
  bool shouldReclip(_) => false;
}

class ModernAngledBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.height * 0.5, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width - size.height * 0.5, size.height)
    ..lineTo(0, size.height)
    ..close();
  @override
  bool shouldReclip(_) => false;
}

class ModernAngledTagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width - size.height * 0.3, size.height)
    ..lineTo(0, size.height)
    ..close();
  @override
  bool shouldReclip(_) => false;
}

class SharpAngleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final off = size.height * 0.18;
    return Path()
      ..moveTo(0, off)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class SharpAngleClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final off = size.height * 0.18;
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - off)
      ..lineTo(0, size.height)
      ..close();
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
    final nr = avatarRadius + 8;
    return Path()
      ..lineTo(0, 0)
      ..lineTo(centerX - nr, 0)
      ..arcToPoint(
        Offset(centerX + nr, 0),
        radius: Radius.circular(nr),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
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
    final nr = avatarRadius + 8;
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(centerX + nr, size.height)
      ..arcToPoint(
        Offset(centerX - nr, size.height),
        radius: Radius.circular(nr),
        clockwise: true,
      )
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class DiagonalSlashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final cut = size.height * 0.5;
    return Path()
      ..moveTo(0, cut)
      ..lineTo(size.width, cut)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class DiagonalSlashAccentClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final top = size.height * 0.55;
    final bot = size.height * 0.62;
    return Path()
      ..moveTo(0, top)
      ..lineTo(size.width, top)
      ..lineTo(size.width, bot)
      ..lineTo(0, bot)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}

class ArcRevealClipper extends CustomClipper<Path> {
  final double arcHeightFraction;
  const ArcRevealClipper({this.arcHeightFraction = 0.72});
  @override
  Path getClip(Size size) {
    final cy = size.height * arcHeightFraction;
    final rx = size.width * 0.72;
    final ry = size.height * 0.48;
    return Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, cy)
      ..arcToPoint(
        Offset(0, cy),
        radius: Radius.elliptical(rx, ry),
        clockwise: false,
      )
      ..close();
  }

  @override
  bool shouldReclip(ArcRevealClipper old) =>
      old.arcHeightFraction != arcHeightFraction;
}

class CornerBadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width - size.height * 0.5, 0)
    ..lineTo(size.width, size.height * 0.5)
    ..lineTo(size.width - size.height * 0.5, size.height)
    ..lineTo(0, size.height)
    ..close();
  @override
  bool shouldReclip(_) => false;
}
