import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_theme_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _identityController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _showRegisterTab = false;

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final palette = _LoginPalette.fromBrightness(isDark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: palette.panel,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: palette.panel,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final panelTop = height * 0.34;
            final topInset = MediaQuery.paddingOf(context).top;

            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: height * 0.56,
                  child: _HeroArtwork(isDark: isDark),
                ),
                Positioned(
                  top: topInset + 72,
                  left: 27,
                  right: 136,
                  child: _WelcomeHeading(isDark: isDark),
                ),
                Positioned(
                  top: topInset + 12,
                  right: 22,
                  child: _ThemeToggle(isDark: isDark),
                ),
                Positioned(
                  top: panelTop,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: palette.panel,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(34),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: isDark ? 0.24 : 0.10,
                          ),
                          blurRadius: 22,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 430),
                            child: _buildForm(context, palette, isDark),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, _LoginPalette palette, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AuthTabs(
          selectedRegister: _showRegisterTab,
          palette: palette,
          onSelect: (isRegister) {
            setState(() => _showRegisterTab = isRegister);
          },
        ),
        const SizedBox(height: 20),
        AuthTextField(
          controller: _identityController,
          hint: 'Email hoặc số điện thoại',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        AuthTextField(
          controller: _passwordController,
          hint: 'Mật khẩu',
          icon: Icons.lock_outline_rounded,
          isDark: isDark,
          obscureText: _obscurePassword,
          onToggleVisibility: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
        const SizedBox(height: 9),
        _RememberAndForgot(
          checked: _rememberMe,
          palette: palette,
          onRememberChanged: (value) {
            setState(() => _rememberMe = value ?? false);
          },
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 54,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Color(0xFF1765F5), Color(0xFF0860F7)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1765F5).withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () => FocusScope.of(context).unfocus(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _showRegisterTab ? 'Đăng ký' : 'Đăng nhập',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_rounded, size: 19),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        _OrDivider(palette: palette),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: SocialLoginButton(
                label: 'Google',
                google: true,
                isDark: isDark,
                onPressed: () => FocusScope.of(context).unfocus(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SocialLoginButton(
                label: 'Số điện thoại',
                isDark: isDark,
                onPressed: () => FocusScope.of(context).unfocus(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _RegisterFooter(
          isRegistering: _showRegisterTab,
          palette: palette,
          onTap: () => setState(() => _showRegisterTab = !_showRegisterTab),
        ),
      ],
    );
  }
}

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? const [Color(0xFF071427), Color(0xFF102B49)]
                  : const [Color(0xFFEAF5FF), Color(0xFFC5DDF5)],
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(painter: _ApartmentPainter(isDark: isDark)),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                isDark
                    ? const Color(0xFF050912).withValues(alpha: 0.08)
                    : const Color(0xFFF7F9FC).withValues(alpha: 0.02),
                isDark
                    ? const Color(0xFF050912).withValues(alpha: 0.82)
                    : const Color(0xFFF7F9FC).withValues(alpha: 0.55),
              ],
              stops: const [0, 0.55, 1],
            ),
          ),
        ),
      ],
    );
  }
}

class _ApartmentPainter extends CustomPainter {
  const _ApartmentPainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final glowCenter = Offset(width * 0.86, height * 0.45);
    final glowRadius = width * 0.34;
    final glowShader = RadialGradient(
      colors: isDark
          ? const [Color(0x443B86C7), Color(0x003B86C7)]
          : const [Color(0x99FFFFFF), Color(0x00FFFFFF)],
    ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius));
    canvas.drawCircle(glowCenter, glowRadius, Paint()..shader = glowShader);

    final outlineColor = isDark
        ? const Color(0x6679A9D4)
        : const Color(0x665D83A8);
    final fillColor = isDark
        ? const Color(0x1C73A5D2)
        : const Color(0x1A648BB1);

    final tower = Path()
      ..moveTo(width * 0.66, height)
      ..lineTo(width * 0.66, height * 0.52)
      ..quadraticBezierTo(
        width * 0.66,
        height * 0.48,
        width * 0.70,
        height * 0.47,
      )
      ..lineTo(width * 0.88, height * 0.35)
      ..quadraticBezierTo(
        width * 0.91,
        height * 0.34,
        width * 0.93,
        height * 0.38,
      )
      ..lineTo(width, height * 0.46)
      ..lineTo(width, height)
      ..close();

    canvas.drawPath(tower, Paint()..color = fillColor);
    canvas.drawPath(
      tower,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25,
    );

    final facadePaint = Paint()
      ..color = outlineColor.withValues(alpha: 0.68)
      ..strokeWidth = 0.85
      ..style = PaintingStyle.stroke;
    for (var i = 1; i < 5; i++) {
      final y = height * (0.48 + i * 0.085);
      canvas.drawLine(Offset(width * 0.67, y), Offset(width, y), facadePaint);
    }
    for (var i = 1; i < 5; i++) {
      final x = width * (0.67 + i * 0.066);
      canvas.drawLine(Offset(x, height * 0.47), Offset(x, height), facadePaint);
    }

    final sweep = Path()
      ..moveTo(width * 0.68, height * 0.92)
      ..cubicTo(
        width * 0.78,
        height * 0.77,
        width * 0.86,
        height * 0.84,
        width * 0.93,
        height * 0.67,
      )
      ..cubicTo(
        width * 0.96,
        height * 0.57,
        width * 0.98,
        height * 0.59,
        width,
        height * 0.53,
      );
    canvas.drawPath(
      sweep,
      Paint()
        ..color = outlineColor.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );
  }

  @override
  bool shouldRepaint(covariant _ApartmentPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _WelcomeHeading extends StatelessWidget {
  const _WelcomeHeading({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final headingColor = isDark
        ? const Color(0xFFF5F8FE)
        : const Color(0xFF102A49);
    final bodyColor = isDark
        ? const Color(0xFFD0DDED)
        : const Color(0xFF405A77);
    final brandColor = isDark
        ? const Color(0xFF9FCBFF)
        : const Color(0xFF2878F9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.apartment_rounded, size: 16, color: brandColor),
            const SizedBox(width: 7),
            Text(
              'RENTFLOW',
              style: TextStyle(
                color: brandColor,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Chào mừng!',
          style: TextStyle(
            color: headingColor,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.9,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Quản lý nhà trọ của bạn dễ dàng hơn',
          style: TextStyle(
            color: bodyColor,
            fontSize: 13,
            height: 1.3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? const Color(0x99091320) : const Color(0xCCFFFFFF),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: context.read<AppThemeCubit>().toggleTheme,
        tooltip: isDark
            ? 'Chuyển sang giao diện sáng'
            : 'Chuyển sang giao diện tối',
        icon: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          color: isDark ? Colors.white : const Color(0xFF17304F),
          size: 20,
        ),
        constraints: const BoxConstraints.tightFor(width: 42, height: 42),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _AuthTabs extends StatelessWidget {
  const _AuthTabs({
    required this.selectedRegister,
    required this.palette,
    required this.onSelect,
  });

  final bool selectedRegister;
  final _LoginPalette palette;
  final ValueChanged<bool> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AuthTab(
          label: 'Đăng nhập',
          selected: !selectedRegister,
          palette: palette,
          onTap: () => onSelect(false),
        ),
        _AuthTab(
          label: 'Đăng ký',
          selected: selectedRegister,
          palette: palette,
          onTap: () => onSelect(true),
        ),
      ],
    );
  }
}

class _AuthTab extends StatelessWidget {
  const _AuthTab({
    required this.label,
    required this.selected,
    required this.palette,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final _LoginPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected ? palette.primaryText : palette.secondaryText,
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: selected ? 2.5 : 1,
                color: selected ? palette.accent : palette.divider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RememberAndForgot extends StatelessWidget {
  const _RememberAndForgot({
    required this.checked,
    required this.palette,
    required this.onRememberChanged,
  });

  final bool checked;
  final _LoginPalette palette;
  final ValueChanged<bool?> onRememberChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Checkbox(
            value: checked,
            onChanged: onRememberChanged,
            activeColor: palette.accent,
            checkColor: Colors.white,
            side: BorderSide(color: palette.checkboxBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            'Ghi nhớ đăng nhập',
            style: TextStyle(color: palette.secondaryText, fontSize: 10.5),
          ),
        ),
        TextButton(
          onPressed: () => FocusScope.of(context).unfocus(),
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: palette.accent,
          ),
          child: const Text(
            'Quên mật khẩu?',
            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.palette});

  final _LoginPalette palette;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: palette.divider, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Hoặc đăng nhập với',
            style: TextStyle(color: palette.secondaryText, fontSize: 10.5),
          ),
        ),
        Expanded(child: Divider(color: palette.divider, height: 1)),
      ],
    );
  }
}

class _RegisterFooter extends StatelessWidget {
  const _RegisterFooter({
    required this.isRegistering,
    required this.palette,
    required this.onTap,
  });

  final bool isRegistering;
  final _LoginPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isRegistering ? 'Đã có tài khoản? ' : 'Chưa có tài khoản? ',
          style: TextStyle(color: palette.secondaryText, fontSize: 11),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            isRegistering ? 'Đăng nhập' : 'Đăng ký',
            style: TextStyle(
              color: palette.accent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginPalette {
  const _LoginPalette({
    required this.panel,
    required this.primaryText,
    required this.secondaryText,
    required this.accent,
    required this.divider,
    required this.checkboxBorder,
  });

  factory _LoginPalette.fromBrightness(bool isDark) {
    if (isDark) {
      return const _LoginPalette(
        panel: Color(0xFF050912),
        primaryText: Color(0xFFF3F6FC),
        secondaryText: Color(0xFF91A5BF),
        accent: Color(0xFF1680FF),
        divider: Color(0xFF172235),
        checkboxBorder: Color(0xFF32435A),
      );
    }
    return const _LoginPalette(
      panel: Color(0xFFFCFDFE),
      primaryText: Color(0xFF152A43),
      secondaryText: Color(0xFF7B899B),
      accent: Color(0xFF2878F9),
      divider: Color(0xFFE5EAF1),
      checkboxBorder: Color(0xFFD4DDE8),
    );
  }

  final Color panel;
  final Color primaryText;
  final Color secondaryText;
  final Color accent;
  final Color divider;
  final Color checkboxBorder;
}
