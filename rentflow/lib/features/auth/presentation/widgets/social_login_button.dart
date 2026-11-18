import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.label,
    required this.isDark,
    required this.onPressed,
    this.google = false,
    this.isAvailable = true,
    this.statusLabel,
    super.key,
  });

  final String label;
  final bool isDark;
  final bool google;
  final bool isAvailable;
  final String? statusLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final foreground = isAvailable
        ? isDark
              ? RentFlowPalette.darkText
              : RentFlowPalette.lightText
        : isDark
        ? RentFlowPalette.darkMuted
        : RentFlowPalette.lightMuted;
    final border = isDark
        ? RentFlowPalette.darkBorder
        : RentFlowPalette.lightBorder;
    final background = isDark
        ? RentFlowPalette.darkInput
        : RentFlowPalette.lightInput;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final buttonHeight = (54 * textScale).clamp(54.0, 112.0).toDouble();
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (google)
          Opacity(
            opacity: isAvailable ? 1 : .62,
            child: const SizedBox(
              width: 18,
              height: 18,
              child: CustomPaint(painter: _GoogleMarkPainter()),
            ),
          )
        else
          Icon(
            isIOS
                ? CupertinoIcons.device_phone_portrait
                : Icons.phone_iphone_outlined,
            size: 18,
          ),
        const SizedBox(width: 9),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: RentFlowTypography.control(context).copyWith(
                  color: foreground,
                  height: 1.15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (statusLabel case final status?) ...[
                const SizedBox(height: 2),
                Text(
                  status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: RentFlowTypography.supporting(context).copyWith(
                    color: foreground,
                    height: 1.15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );

    if (isIOS) {
      final decoration = BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      );
      if (!isAvailable) {
        return Semantics(
          button: true,
          enabled: false,
          label: [label, if (statusLabel != null) statusLabel].join(', '),
          child: Container(
            height: buttonHeight,
            decoration: decoration,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: ExcludeSemantics(
                child: DefaultTextStyle(
                  style: TextStyle(color: foreground),
                  child: IconTheme(
                    data: IconThemeData(color: foreground),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      }

      return Container(
        height: buttonHeight,
        decoration: decoration,
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          minimumSize: Size(0, buttonHeight),
          onPressed: onPressed,
          child: DefaultTextStyle(
            style: TextStyle(color: foreground),
            child: IconTheme(
              data: IconThemeData(color: foreground),
              child: child,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: buttonHeight,
      child: OutlinedButton(
        onPressed: isAvailable ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background,
          disabledForegroundColor: foreground,
          side: BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _GoogleMarkPainter extends CustomPainter {
  const _GoogleMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final ring = Rect.fromLTWH(
      size.width * .12,
      size.height * .12,
      size.width * .76,
      size.height * .76,
    );
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * .19
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;
    final arcs = <(Color, double, double)>[
      (const Color(0xFFEA4335), -2.25, 1.48),
      (const Color(0xFF4285F4), -.76, 1.55),
      (const Color(0xFF34A853), .79, 1.48),
      (const Color(0xFFFBBC05), 2.27, 1.48),
    ];
    for (final (color, start, sweep) in arcs) {
      canvas.drawArc(ring, start, sweep, false, stroke..color = color);
    }
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * .52,
        size.height * .44,
        size.width * .4,
        size.height * .16,
      ),
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(covariant _GoogleMarkPainter oldDelegate) => false;
}
