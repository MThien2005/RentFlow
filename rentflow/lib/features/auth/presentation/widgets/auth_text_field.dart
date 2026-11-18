import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.isDark,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onToggleVisibility,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isDark;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark
        ? const Color(0xFFF3F6FC)
        : const Color(0xFF172B45);
    final hintColor = isDark
        ? const Color(0xFF8296B0)
        : const Color(0xFF8795A8);
    final fillColor = isDark
        ? const Color(0xFF0B1421)
        : const Color(0xFFF7F9FC);
    final borderColor = isDark
        ? const Color(0xFF1B2A3D)
        : const Color(0xFFE7ECF3);
    const accentColor = Color(0xFF2878F9);

    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: textColor, fontSize: 14),
        cursorColor: accentColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: hintColor, fontSize: 13),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 11),
            child: Icon(icon, color: hintColor, size: 19),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 44),
          suffixIcon: onToggleVisibility == null
              ? null
              : IconButton(
                  onPressed: onToggleVisibility,
                  tooltip: obscureText ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: hintColor,
                    size: 19,
                  ),
                ),
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: accentColor, width: 1.45),
          ),
        ),
      ),
    );
  }
}
