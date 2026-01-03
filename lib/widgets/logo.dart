import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final LogoSize size;
  final EdgeInsetsGeometry? margin;

  const Logo({
    super.key,
    this.size = LogoSize.medium,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = _getDimensions();
    final fontSize = _getFontSize();

    return Container(
      margin: margin,
      width: dimensions,
      height: dimensions,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1F2937),
            Color(0xFF000000),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF374151),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          'CF',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.08 * fontSize,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  double _getDimensions() {
    switch (size) {
      case LogoSize.small:
        return 48;
      case LogoSize.medium:
        return 80;
      case LogoSize.large:
        return 96;
    }
  }

  double _getFontSize() {
    switch (size) {
      case LogoSize.small:
        return 20;
      case LogoSize.medium:
        return 32;
      case LogoSize.large:
        return 40;
    }
  }
}

enum LogoSize { small, medium, large }