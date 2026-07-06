import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/contact/components/contact_form_section.dart';
import 'package:portfolio/view/screens/contact/components/contact_info_section.dart';
import 'package:animations/animations.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: WebColors.bgPrimary,
          child: child,
        );
      },
      child: Scaffold(
        key: const ValueKey('ContactScreen'),
        backgroundColor: WebColors.bgPrimary,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 32.h,
            vertical: 64.v,
          ),
          child: Obx(() {
            final isMobile = Get.find<ResponsiveController>().isMobile;

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContactInfoSection(),
                  SizedBox(height: 48.v),
                  const ContactFormSection(),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 5,
                  child: ContactInfoSection(),
                ),
                SizedBox(width: 64.h),
                const Expanded(
                  flex: 5,
                  child: ContactFormSection(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
