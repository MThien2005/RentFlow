import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.label,
    required this.isDark,
    required this.onPressed,
    this.google = false,
    super.key,
  });

  final String label;
  final bool isDark;
  final bool google;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foreground = isDark
        ? const Color(0xFFE8EFF8)
        : const Color(0xFF23364E);
    final border = isDark ? const Color(0xFF1B2A3D) : const Color(0xFFE7ECF3);
    final background = isDark
        ? const Color(0xFF0B1421)
        : const Color(0xFFF7F9FC);

    return SizedBox(
      height: 45,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          side: BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (google)
              const Text(
                'G',
                style: TextStyle(
                  color: Color(0xFF4285F4),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              )
            else
              const Icon(Icons.phone_iphone_rounded, size: 17),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
