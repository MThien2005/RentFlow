import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_theme_cubit.dart';
import '../widgets/login_form.dart';
import '../widgets/rentflow_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelColor = isDark
        ? RentFlowPalette.darkPanel
        : RentFlowPalette.lightPanel;
    final keyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: panelColor,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: panelColor,
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final topInset = MediaQuery.paddingOf(context).top;
            final textScale = MediaQuery.textScalerOf(context).scale(1);
            final textScaleRelief = ((textScale - 1).clamp(0.0, 1.0) * .08)
                .toDouble();
            final panelTopFactor = (.36 + textScaleRelief)
                .clamp(.36, .44)
                .toDouble();
            final panelTop = height * (keyboardVisible ? .15 : panelTopFactor);
            final heroHeight = height * (keyboardVisible ? .24 : .49);

            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: heroHeight,
                  child: _HeroArtwork(isDark: isDark),
                ),
                if (!keyboardVisible) ...[
                  Positioned(
                    top: topInset + 15,
                    left: 24,
                    child: RentFlowLogo(size: 42, lightOnDark: isDark),
                  ),
                  Positioned(
                    top: topInset + 9,
                    right: 18,
                    child: const _ThemeToggle(),
                  ),
                  Positioned(
                    top: topInset + 70,
                    // Keep the welcome title against the open sky portion of
                    // the daytime photo instead of the busy apartment facade.
                    left: 25,
                    right: 25,
                    child: _WelcomeHeading(isDark: isDark),
                  ),
                ],
                Positioned(
                  top: panelTop,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: panelColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? const Color(0xFF223247)
                              : const Color(0xFFE6EBF2),
                        ),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(23, 16, 23, 8),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 470),
                            child: LoginForm(
                              isDark: isDark,
                              onAuthIntent: (intent) =>
                                  _showAuthUnavailable(context, intent),
                            ),
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

  void _showAuthUnavailable(BuildContext context, AuthIntent intent) {
    final message = switch (intent) {
      AuthIntent.signIn =>
        'Đăng nhập chưa khả dụng: dự án chưa kết nối dịch vụ xác thực.',
      AuthIntent.signUp =>
        'Đăng ký chưa khả dụng: dự án chưa kết nối dịch vụ xác thực.',
      AuthIntent.google => 'Google Sign-In chưa được cấu hình trong dự án.',
      AuthIntent.phone =>
        'Đăng nhập bằng số điện thoại chưa được cấu hình trong dự án.',
      AuthIntent.resetPassword =>
        'Đặt lại mật khẩu chưa khả dụng vì dịch vụ xác thực chưa được kết nối.',
    };
    final isDark = Theme.of(context).brightness == Brightness.dark;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: isDark
              ? const Color(0xFF17263A)
              : const Color(0xFF20334A),
          content: Text(message),
        ),
      );
  }
}

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final panel = isDark
        ? RentFlowPalette.darkPanel
        : RentFlowPalette.lightPanel;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          isDark
              ? 'assets/images/rentflow_login_hero.png'
              : 'assets/images/rentflow_login_hero_day.png',
          fit: BoxFit.cover,
          alignment: const Alignment(0, -.18),
          errorBuilder: (context, error, stackTrace) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? const [Color(0xFF102A48), Color(0xFF050B14)]
                    : const [Color(0xFFDCEBFA), Color(0xFFF5F7FA)],
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      const Color(0xFF03101E).withValues(alpha: .42),
                      const Color(0xFF03101E).withValues(alpha: .24),
                      const Color(0xFF03101E).withValues(alpha: .60),
                      panel.withValues(alpha: .97),
                    ]
                  : [
                      const Color(0xFFF5F7FA).withValues(alpha: .02),
                      const Color(0xFFF5F7FA).withValues(alpha: .07),
                      const Color(0xFFF5F7FA).withValues(alpha: .18),
                      panel.withValues(alpha: .98),
                    ],
              stops: const [0, .34, .72, 1],
            ),
          ),
        ),
      ],
    );
  }
}

class _WelcomeHeading extends StatelessWidget {
  const _WelcomeHeading({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final role = Theme.of(context).textTheme.headlineMedium;
    const title = 'Chào mừng!';
    final baseStyle = role?.copyWith(
      fontFamily: RentFlowTypography.display,
      fontSize: 31,
      height: 1.15,
      fontWeight: FontWeight.w800,
      letterSpacing: -.7,
    );

    return Text(
      title,
      style: baseStyle?.copyWith(
        color: isDark ? Colors.white : const Color(0xFF07182C),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final tooltip = isDark
        ? 'Chuyển sang giao diện sáng'
        : 'Chuyển sang giao diện tối';
    void onPressed() {
      final nextIsDark = !isDark;
      context.read<AppThemeCubit>().toggleTheme();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: nextIsDark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: nextIsDark
                ? Brightness.dark
                : Brightness.light,
            systemNavigationBarColor: nextIsDark
                ? RentFlowPalette.darkPanel
                : RentFlowPalette.lightPanel,
            systemNavigationBarIconBrightness: nextIsDark
                ? Brightness.light
                : Brightness.dark,
          ),
        );
      });
    }

    final foreground = isDark ? Colors.white : RentFlowPalette.lightText;
    final controlSurface = isDark
        ? const Color(0xB3091728)
        : Colors.white.withValues(alpha: .78);
    final icon = Icon(
      isDark
          ? isIOS
                ? CupertinoIcons.sun_max
                : Icons.light_mode_outlined
          : isIOS
          ? CupertinoIcons.moon
          : Icons.dark_mode_outlined,
      color: foreground,
      size: 20,
    );

    if (isIOS) {
      return Semantics(
        button: true,
        label: tooltip,
        child: CupertinoButton(
          minimumSize: const Size.square(48),
          padding: EdgeInsets.zero,
          color: controlSurface,
          borderRadius: BorderRadius.circular(24),
          onPressed: onPressed,
          child: icon,
        ),
      );
    }

    return Material(
      color: controlSurface,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: icon,
        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
