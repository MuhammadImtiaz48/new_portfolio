import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/contact/components/contact_info_card.dart';
import 'package:portfolio/view/screens/contact/components/pulsing_availability_badge.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.heading(fontSize: 56),
            children: [
              const TextSpan(text: 'Let\'s Build\n'),
              WidgetSpan(
                child: Text(
                  'Together.',
                  style: AppTextStyles.heading(fontSize: 56).copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = WebColors.textPrimary.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fade(duration: 500.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 24.v),
        const PulsingAvailabilityBadge().animate().fade(duration: 500.ms, delay: 100.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 32.v),
        Text(
          'Have a project in mind or just want to say hi?\nI am always open to discussing new opportunities.',
          style: AppTextStyles.body(fontSize: 16),
        ).animate().fade(duration: 500.ms, delay: 200.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 48.v),
        const ContactInfoCard(
          iconWidget: Icon(
            Icons.email_rounded,
            color: WebColors.greenPrimary,
            size: 20,
          ),
          label: 'Email',
          value: 'shahroozshafique6@gmail.com',
          urlScheme: 'mailto:shahroozshafique6@gmail.com',
        ).animate().fade(duration: 500.ms, delay: 300.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 16.v),
        const ContactInfoCard(
          iconWidget: Icon(
            Icons.phone_rounded,
            color: WebColors.greenPrimary,
            size: 20,
          ),
          label: 'Phone',
          value: '+92 313 720 7956',
          urlScheme: 'tel:+923137207956',
        ).animate().fade(duration: 500.ms, delay: 400.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 16.v),
        const ContactInfoCard(
          iconWidget: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: WebColors.greenPrimary,
            size: 20,
          ),
          label: 'WhatsApp',
          value: '+92 313 720 7956',
          urlScheme: 'https://wa.me/923137207956',
        ).animate().fade(duration: 500.ms, delay: 500.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }
}
