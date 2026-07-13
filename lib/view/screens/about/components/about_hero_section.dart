import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/about/components/about_info_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutHeroSection extends StatelessWidget {
  const AboutHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT ME',
          style: AppTextStyles.eyebrow(),
        ).animate().fade(duration: 500.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 16.v),
        RichText(
          text: TextSpan(
            style: AppTextStyles.heading(fontSize: 48),
            children: [
              const TextSpan(text: 'Bridging the gap between\n'),
              TextSpan(
                text: 'design & performance.',
                style: TextStyle(color: WebColors.greenPrimary),
              ),
            ],
          ),
        ).animate().fade(duration: 500.ms, delay: 100.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 28.v),
        Text(
          'I am a Senior Flutter Engineer dedicated to building highly performant, visually stunning, and architecturally sound mobile and web applications. My development philosophy is rooted in Clean Architecture, ensuring codebases remain testable, scalable, and maintainable.',
          style: AppTextStyles.body(fontSize: 16, height: 1.6),
        ).animate().fade(duration: 500.ms, delay: 200.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 16.v),
        Text(
          'With a keen eye for UI/UX, I translate complex design specs into fluid, 60fps animations and intuitive interfaces. By combining state-of-the-art state management with strict performance optimization, I bridge the gap between pixel-perfect aesthetics and engineering excellence.',
          style: AppTextStyles.body(fontSize: 16, height: 1.6),
        ).animate().fade(duration: 500.ms, delay: 300.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 32.v),
        const AboutInfoCard().animate().fade(duration: 500.ms, delay: 400.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }
}
