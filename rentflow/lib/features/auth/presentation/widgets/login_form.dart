import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'auth_text_field.dart';
import 'social_login_button.dart';

enum AuthIntent { signIn, signUp, google, phone, resetPassword }

/// The sign-in and registration surface, kept separate from the page layout.
class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.isDark,
    required this.onAuthIntent,
    super.key,
  });

  final bool isDark;
  final ValueChanged<AuthIntent> onAuthIntent;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();

  bool _isRegistering = false;
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void dispose() {
    _nameController.dispose();
    _identityController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _selectMode(bool register) {
    if (_isRegistering == register) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isRegistering = register;
    });
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    final formKey = _isRegistering ? _signUpFormKey : _signInFormKey;
    if (!(formKey.currentState?.validate() ?? false)) return;
    widget.onAuthIntent(_isRegistering ? AuthIntent.signUp : AuthIntent.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final primaryText = isDark
        ? RentFlowPalette.darkText
        : RentFlowPalette.lightText;
    final secondaryText = isDark
        ? RentFlowPalette.darkMuted
        : RentFlowPalette.lightMuted;
    final divider = isDark
        ? RentFlowPalette.darkBorder
        : RentFlowPalette.lightBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AuthTabs(
          isRegistering: _isRegistering,
          isDark: isDark,
          onSelect: _selectMode,
        ),
        const SizedBox(height: 10),
        Text(
          _isRegistering
              ? 'Tạo tài khoản RentFlow'
              : 'Quản lý nhà trọ của bạn dễ dàng hơn.',
          style:
              (_isRegistering
                      ? RentFlowTypography.title(context)
                      : RentFlowTypography.body(context))
                  .copyWith(
                    color: _isRegistering ? primaryText : secondaryText,
                    height: 1.35,
                    fontWeight: _isRegistering
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
        ),
        const SizedBox(height: 14),
        AnimatedSize(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 210),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, .025),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _buildFields(isDark, key: ValueKey(_isRegistering)),
          ),
        ),
        const SizedBox(height: 8),
        if (!_isRegistering) ...[
          _RememberAndForgot(
            checked: _rememberMe,
            isDark: isDark,
            onRememberChanged: (value) {
              setState(() => _rememberMe = value ?? false);
            },
            onForgot: () => widget.onAuthIntent(AuthIntent.resetPassword),
          ),
          const SizedBox(height: 8),
        ] else
          const SizedBox(height: 5),
        _PrimaryAuthButton(
          label: _isRegistering ? 'Tạo tài khoản' : 'Đăng nhập',
          onPressed: _submit,
        ),
        const SizedBox(height: 12),
        _OrDivider(
          label: _isRegistering ? 'Hoặc tiếp tục với' : 'Hoặc đăng nhập với',
          color: secondaryText,
          divider: divider,
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final textScale = MediaQuery.textScalerOf(context).scale(1);
            final googleOption = SocialLoginButton(
              label: 'Google',
              statusLabel: 'Chưa cấu hình',
              google: true,
              isDark: isDark,
              isAvailable: false,
              onPressed: () => widget.onAuthIntent(AuthIntent.google),
            );
            final phoneOption = SocialLoginButton(
              label: 'Số điện thoại',
              statusLabel: 'Chưa cấu hình',
              isDark: isDark,
              isAvailable: false,
              onPressed: () => widget.onAuthIntent(AuthIntent.phone),
            );

            if (constraints.maxWidth < 320 || textScale > 1.25) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  googleOption,
                  const SizedBox(height: 8),
                  phoneOption,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: googleOption),
                const SizedBox(width: 10),
                Expanded(child: phoneOption),
              ],
            );
          },
        ),
        const SizedBox(height: 6),
        _RegisterFooter(
          isRegistering: _isRegistering,
          isDark: isDark,
          onTap: () => _selectMode(!_isRegistering),
        ),
      ],
    );
  }

  Widget _buildFields(bool isDark, {required Key key}) {
    return Form(
      key: _isRegistering ? _signUpFormKey : _signInFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isRegistering) ...[
            AuthTextField(
              controller: _nameController,
              hint: 'Họ và tên',
              icon: Icons.person_outline_rounded,
              iosIcon: CupertinoIcons.person,
              isDark: isDark,
              textCapitalization: TextCapitalization.words,
              autofillHints: const [AutofillHints.name],
              validator: (value) => (value?.trim().isNotEmpty ?? false)
                  ? null
                  : 'Vui lòng nhập họ và tên.',
            ),
            const SizedBox(height: 10),
          ],
          AuthTextField(
            controller: _identityController,
            hint: 'Email hoặc số điện thoại',
            icon: Icons.mail_outline_rounded,
            iosIcon: CupertinoIcons.envelope,
            isDark: isDark,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.username, AutofillHints.email],
            validator: _validateIdentity,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          const SizedBox(height: 10),
          AuthTextField(
            controller: _passwordController,
            hint: 'Mật khẩu',
            icon: Icons.lock_outline_rounded,
            iosIcon: CupertinoIcons.lock,
            isDark: isDark,
            textInputAction: _isRegistering
                ? TextInputAction.next
                : TextInputAction.done,
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
            autofillHints: const [AutofillHints.password],
            validator: (value) =>
                value?.isNotEmpty ?? false ? null : 'Vui lòng nhập mật khẩu.',
            onSubmitted: (_) =>
                _isRegistering ? FocusScope.of(context).nextFocus() : _submit(),
          ),
          if (_isRegistering) ...[
            const SizedBox(height: 10),
            AuthTextField(
              controller: _confirmationController,
              hint: 'Nhập lại mật khẩu',
              icon: Icons.lock_outline_rounded,
              iosIcon: CupertinoIcons.lock,
              isDark: isDark,
              textInputAction: TextInputAction.done,
              obscureText: _obscureConfirmation,
              onToggleVisibility: () {
                setState(() {
                  _obscureConfirmation = !_obscureConfirmation;
                });
              },
              validator: (value) => value == _passwordController.text
                  ? null
                  : 'Mật khẩu nhập lại chưa khớp.',
              onSubmitted: (_) => _submit(),
            ),
          ],
        ],
      ),
    );
  }

  String? _validateIdentity(String? value) {
    final identity = value?.trim() ?? '';
    if (identity.isEmpty) return 'Vui lòng nhập email hoặc số điện thoại.';
    if (identity.contains('@')) {
      final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
      return emailPattern.hasMatch(identity)
          ? null
          : 'Email chưa đúng định dạng.';
    }
    final phonePattern = RegExp(r'^\+?[0-9 ()-]{7,}$');
    return phonePattern.hasMatch(identity)
        ? null
        : 'Hãy nhập email hoặc số điện thoại hợp lệ.';
  }
}

class _AuthTabs extends StatelessWidget {
  const _AuthTabs({
    required this.isRegistering,
    required this.isDark,
    required this.onSelect,
  });

  final bool isRegistering;
  final bool isDark;
  final ValueChanged<bool> onSelect;

  @override
  Widget build(BuildContext context) {
    final active = isDark
        ? RentFlowPalette.darkText
        : RentFlowPalette.lightText;
    final inactive = isDark
        ? RentFlowPalette.darkMuted
        : RentFlowPalette.lightMuted;
    final divider = isDark
        ? RentFlowPalette.darkBorder
        : RentFlowPalette.lightBorder;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final tabHeight = (36 * textScale + 14).clamp(50.0, 150.0).toDouble();

    return SizedBox(
      height: tabHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(height: 1, color: divider),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: isRegistering
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: FractionallySizedBox(
              widthFactor: .5,
              child: Container(
                height: 2.5,
                decoration: BoxDecoration(
                  color: RentFlowPalette.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          Row(
            children: [
              _AuthTab(
                label: 'Đăng nhập',
                selected: !isRegistering,
                active: active,
                inactive: inactive,
                height: tabHeight,
                onTap: () => onSelect(false),
              ),
              _AuthTab(
                label: 'Đăng ký',
                selected: isRegistering,
                active: active,
                inactive: inactive,
                height: tabHeight,
                onTap: () => onSelect(true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthTab extends StatelessWidget {
  const _AuthTab({
    required this.label,
    required this.selected,
    required this.active,
    required this.inactive,
    required this.height,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color active;
  final Color inactive;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final label = Semantics(
      button: true,
      selected: selected,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: RentFlowTypography.control(context).copyWith(
            color: selected ? active : inactive,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
          child: Text(
            this.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    return Expanded(
      child: SizedBox(
        height: height,
        child: isIOS
            ? CupertinoButton(
                minimumSize: Size(0, height),
                padding: EdgeInsets.zero,
                onPressed: onTap,
                child: label,
              )
            : Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap, child: label),
              ),
      ),
    );
  }
}

class _RememberAndForgot extends StatelessWidget {
  const _RememberAndForgot({
    required this.checked,
    required this.isDark,
    required this.onRememberChanged,
    required this.onForgot,
  });

  final bool checked;
  final bool isDark;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgot;

  @override
  Widget build(BuildContext context) {
    final secondary = isDark
        ? RentFlowPalette.darkMuted
        : RentFlowPalette.lightMuted;

    return SizedBox(
      height: 48,
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Checkbox.adaptive(
                value: checked,
                onChanged: onRememberChanged,
                activeColor: RentFlowPalette.accent,
                checkColor: Colors.white,
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFF52647C)
                      : const Color(0xFF9AAABD),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              excludeFromSemantics: true,
              behavior: HitTestBehavior.opaque,
              onTap: () => onRememberChanged(!checked),
              child: SizedBox(
                height: 48,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ghi nhớ đăng nhập',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: RentFlowTypography.supporting(
                      context,
                    ).copyWith(color: secondary),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          _InlineAction(
            label: 'Quên mật khẩu?',
            onPressed: onForgot,
            color: isDark
                ? RentFlowPalette.accentBright
                : RentFlowPalette.accent,
          ),
        ],
      ),
    );
  }
}

class _PrimaryAuthButton extends StatelessWidget {
  const _PrimaryAuthButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: RentFlowTypography.control(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 10),
        Icon(
          isIOS ? CupertinoIcons.arrow_right : Icons.arrow_forward_rounded,
          size: 19,
          color: Colors.white,
        ),
      ],
    );

    return SizedBox(
      height: 54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF1F6FF0), Color(0xFF145BD1)],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: isIOS
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 54),
                borderRadius: BorderRadius.circular(15),
                onPressed: onPressed,
                child: child,
              )
            : Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(15),
                  child: Center(child: child),
                ),
              ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({
    required this.label,
    required this.color,
    required this.divider,
  });

  final String label;
  final Color color;
  final Color divider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: divider, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: RentFlowTypography.supporting(
              context,
            ).copyWith(color: color),
          ),
        ),
        Expanded(child: Divider(color: divider, height: 1)),
      ],
    );
  }
}

class _RegisterFooter extends StatelessWidget {
  const _RegisterFooter({
    required this.isRegistering,
    required this.isDark,
    required this.onTap,
  });

  final bool isRegistering;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final secondary = isDark
        ? RentFlowPalette.darkMuted
        : RentFlowPalette.lightMuted;
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              isRegistering ? 'Đã có tài khoản?' : 'Chưa có tài khoản?',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: RentFlowTypography.supporting(
                context,
              ).copyWith(color: secondary),
            ),
          ),
          _InlineAction(
            label: isRegistering ? 'Đăng nhập' : 'Đăng ký',
            onPressed: onTap,
            color: isDark
                ? RentFlowPalette.accentBright
                : RentFlowPalette.accent,
          ),
        ],
      ),
    );
  }
}

class _InlineAction extends StatelessWidget {
  const _InlineAction({
    required this.label,
    required this.onPressed,
    required this.color,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      label,
      style: RentFlowTypography.control(
        context,
      ).copyWith(color: color, fontWeight: FontWeight.w700),
    );
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoButton(
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        onPressed: onPressed,
        child: text,
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: text,
    );
  }
}
