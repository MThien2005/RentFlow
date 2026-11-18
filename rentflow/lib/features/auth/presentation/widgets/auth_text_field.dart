import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.isDark,
    this.iosIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.onToggleVisibility,
    this.validator,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isDark;
  final IconData? iosIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final FormFieldValidator<String>? validator;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final isDark = widget.isDark;
    final textColor = isDark
        ? RentFlowPalette.darkText
        : RentFlowPalette.lightText;
    final hintColor = isDark
        ? RentFlowPalette.darkMuted
        : RentFlowPalette.lightMuted;
    final fillColor = isDark
        ? RentFlowPalette.darkInput
        : RentFlowPalette.lightInput;
    final borderColor = isDark
        ? RentFlowPalette.darkBorder
        : RentFlowPalette.lightBorder;
    final errorColor = isDark
        ? const Color(0xFFFF9299)
        : const Color(0xFFB42336);
    final leadingIcon = isIOS ? (widget.iosIcon ?? widget.icon) : widget.icon;

    if (isIOS) {
      return Focus(
        onFocusChange: (focused) {
          if (_hasFocus != focused) setState(() => _hasFocus = focused);
        },
        child: FormField<String>(
          initialValue: widget.controller.text,
          validator: widget.validator,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 55),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: field.hasError
                        ? errorColor
                        : _hasFocus
                        ? RentFlowPalette.accent
                        : borderColor,
                    width: _hasFocus ? 1.4 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 11),
                      child: Icon(leadingIcon, color: hintColor, size: 20),
                    ),
                    Expanded(
                      child: CupertinoTextField(
                        controller: widget.controller,
                        focusNode: _focusNode,
                        placeholder: widget.hint,
                        placeholderStyle: RentFlowTypography.supporting(
                          context,
                        ).copyWith(color: hintColor),
                        style: RentFlowTypography.body(
                          context,
                        ).copyWith(color: textColor),
                        cursorColor: RentFlowPalette.accent,
                        keyboardType: widget.keyboardType,
                        textInputAction: widget.textInputAction,
                        obscureText: widget.obscureText,
                        autofillHints: widget.autofillHints,
                        textCapitalization: widget.textCapitalization,
                        autocorrect: false,
                        enableSuggestions: !widget.obscureText,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: null,
                        onChanged: field.didChange,
                        onSubmitted: widget.onSubmitted,
                      ),
                    ),
                    if (widget.onToggleVisibility case final toggle?)
                      Semantics(
                        button: true,
                        label: widget.obscureText
                            ? 'Hiện mật khẩu'
                            : 'Ẩn mật khẩu',
                        child: CupertinoButton(
                          minimumSize: const Size(44, 44),
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          onPressed: toggle,
                          child: Icon(
                            widget.obscureText
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: hintColor,
                            size: 19,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (field.errorText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 5),
                  child: Text(
                    field.errorText!,
                    style: RentFlowTypography.supporting(
                      context,
                    ).copyWith(color: errorColor, height: 1.25),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
      autocorrect: false,
      enableSuggestions: !widget.obscureText,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      style: RentFlowTypography.body(context).copyWith(color: textColor),
      cursorColor: RentFlowPalette.accent,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: RentFlowTypography.supporting(
          context,
        ).copyWith(color: hintColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, right: 11),
          child: Icon(leadingIcon, color: hintColor, size: 20),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        suffixIcon: widget.onToggleVisibility == null
            ? null
            : IconButton(
                onPressed: widget.onToggleVisibility,
                tooltip: widget.obscureText ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                icon: Icon(
                  widget.obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: hintColor,
                  size: 20,
                ),
              ),
        filled: true,
        fillColor: fillColor,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        errorMaxLines: 2,
        errorStyle: RentFlowTypography.supporting(
          context,
        ).copyWith(color: errorColor, height: 1.25),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: RentFlowPalette.accent,
            width: 1.45,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: errorColor, width: 1.4),
        ),
      ),
    );
  }
}
