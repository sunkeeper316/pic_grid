import 'package:flutter/material.dart';
import 'package:pic_grid/resource/values/app_colors.dart';

class AdCard extends StatelessWidget {
  final String mainText;
  final String highlightText;
  final String subText;
  final bool isVip;

  const AdCard({
    super.key,
    required this.mainText,
    required this.highlightText,
    required this.subText,
    this.isVip = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isSmallScreen = screenWidth <= 320;
    final double mainFontSize = isSmallScreen ? 14 : 18;
    final double highlightFontSize = isSmallScreen ? 18 : 22;
    final double subFontSize = isSmallScreen ? 14 : 18;

    Widget baseCard(double scale) => Transform.scale(
      scale: scale,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isVip
                ? [Colors.orange.shade300, Colors.deepOrange.shade400]
                : AppColors.linearGradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isVip
              ? [
            BoxShadow(
              color: Colors.orange.withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        width: double.infinity,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(1.0),
              text: TextSpan(
                text: mainText,
                style: TextStyle(
                  fontSize: mainFontSize,
                  color: isVip ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: highlightText,
                    style: TextStyle(
                      fontSize: highlightFontSize,
                      color: isVip ? Colors.yellow[50] : AppColors.primaryColorDark,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: subText,
                    style: TextStyle(
                      fontSize: subFontSize,
                      color: isVip ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (!isVip) return baseCard(1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.03),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, scale, child) => baseCard(scale),
      onEnd: () {
        // 建議搭配 Stateful Widget 讓它持續跳動（也可改 AnimatedBuilder+Controller 做持續效果）
      },
    );
  }
}