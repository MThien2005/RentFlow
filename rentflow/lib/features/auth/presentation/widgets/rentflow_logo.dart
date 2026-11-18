import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

/// RentFlow's geometric RF mark, drawn in code so it stays crisp at small sizes.
class RentFlowLogo extends StatelessWidget {
  const RentFlowLogo({
    this.size = 42,
    this.showWordmark = true,
    this.lightOnDark = true,
    super.key,
  });

  final double size;
  final bool showWordmark;
  final bool lightOnDark;

  @override
  Widget build(BuildContext context) {
    final wordmarkColor = lightOnDark ? Colors.white : const Color(0xFF07182C);
    final wordmarkRole = Theme.of(context).textTheme.titleMedium;
    final wordmarkStyle = wordmarkRole?.copyWith(
      fontFamily: RentFlowTypography.display,
      color: wordmarkColor,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.35,
    );

    return Semantics(
      label: 'RentFlow',
      image: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: size,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size.square(size),
                  painter: _RentFlowRoofPainter(
                    roofColor: RentFlowPalette.accentBright,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size * .035),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'RF',
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                        fontFamily: RentFlowTypography.display,
                        fontSize: size * .59,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -size * .075,
                        height: 1,
                        color: wordmarkColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showWordmark) ...[
            const SizedBox(width: 10),
            Text(
              'RentFlow',
              textScaler: TextScaler.noScaling,
              style: wordmarkStyle,
            ),
          ],
        ],
      ),
    );
  }
}

class _RentFlowRoofPainter extends CustomPainter {
  const _RentFlowRoofPainter({required this.roofColor});

  final Color roofColor;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 40;
    canvas.save();
    canvas.scale(scale, scale);

    final roofPaint = Paint()
      ..color = roofColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final roof = Path()
      ..moveTo(4.5, 13.8)
      ..lineTo(20, 4.8)
      ..lineTo(35.5, 13.8);
    canvas.drawPath(roof, roofPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RentFlowRoofPainter oldDelegate) {
    return oldDelegate.roofColor != roofColor;
  }
}
