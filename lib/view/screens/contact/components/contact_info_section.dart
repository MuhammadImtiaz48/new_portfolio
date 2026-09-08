import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/contact_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/contact/components/contact_info_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: AppTextStyles.eyebrow(),
        ).animate().fade(duration: 400.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 12.v),

        RichText(
          text: TextSpan(
            style: AppTextStyles.heading(fontSize: 46, height: 1.15),
            children: const [
              TextSpan(text: 'Let\'s Build Something\n'),
              TextSpan(
                text: 'Exceptional Together.',
                style: TextStyle(
                  color: WebColors.greenBright,
                  shadows: [
                    Shadow(
                      color: WebColors.greenGlow,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fade(duration: 500.ms, delay: 100.ms).slideX(begin: -0.1, end: 0),

        SizedBox(height: 18.v),

        // Timezone & Availability Chip
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.adaptSize, vertical: 6.adaptSize),
          decoration: BoxDecoration(
            color: WebColors.bgCard,
            borderRadius: BorderRadius.circular(20.adaptSize),
            border: Border.all(color: WebColors.borderLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7.adaptSize,
                height: 7.adaptSize,
                decoration: const BoxDecoration(
                  color: WebColors.greenBright,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.adaptSize),
              Text(
                'PKT (UTC+5) · Usually responds within 2 hours',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 11.fSize,
                  fontWeight: FontWeight.w600,
                  color: WebColors.textSecondary,
                ),
              ),
            ],
          ),
        ).animate().fade(duration: 500.ms, delay: 150.ms).slideX(begin: -0.1, end: 0),

        SizedBox(height: 20.v),

        Obx(
          () => Text(
            contactController.subtext,
            style: AppTextStyles.body(fontSize: 15, height: 1.6),
          ),
        ).animate().fade(duration: 500.ms, delay: 200.ms).slideX(begin: -0.1, end: 0),

        SizedBox(height: 36.v),

        Obx(() {
          final email = contactController.email;
          return ContactInfoCard(
            iconWidget: const Icon(
              Icons.email_outlined,
              color: WebColors.greenBright,
              size: 20,
            ),
            label: 'Email',
            value: email,
            urlScheme: 'mailto:$email',
            showCopyButton: true,
          );
        }).animate().fade(duration: 500.ms, delay: 280.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 14.v),

        Obx(() {
          final whatsapp = contactController.whatsapp;
          final cleanWa = whatsapp.replaceAll(RegExp(r'[^\d]'), '');
          return ContactInfoCard(
            iconWidget: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: WebColors.greenBright,
              size: 20,
            ),
            label: 'WhatsApp Direct',
            value: whatsapp,
            urlScheme: 'https://wa.me/$cleanWa?text=Hi%20Imtiaz,%20I%20saw%20your%20portfolio...',
            showCopyButton: false,
          );
        }).animate().fade(duration: 500.ms, delay: 360.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 14.v),

        Obx(() {
          final phone = contactController.phone;
          final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');
          return ContactInfoCard(
            iconWidget: const Icon(
              Icons.phone_outlined,
              color: WebColors.greenBright,
              size: 20,
            ),
            label: 'Phone Call',
            value: phone,
            urlScheme: 'tel:$cleanPhone',
            showCopyButton: true,
          );
        }).animate().fade(duration: 500.ms, delay: 440.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 14.v),

        Obx(() {
          final githubUser = contactController.githubUsername;
          final githubUrl = contactController.githubUrl;
          final targetUrl = githubUrl.isNotEmpty ? githubUrl : 'https://github.com/$githubUser';
          return ContactInfoCard(
            iconWidget: const FaIcon(
              FontAwesomeIcons.github,
              color: WebColors.greenBright,
              size: 20,
            ),
            label: 'GitHub Profile',
            value: githubUser,
            urlScheme: targetUrl,
            showCopyButton: false,
          );
        }).animate().fade(duration: 500.ms, delay: 520.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }
}
