import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/contact_controller.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/widgets/app_text_field.dart';
import 'package:portfolio/view/widgets/gradient_submit_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactFormSection extends StatelessWidget {
  const ContactFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactController());

    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: 300.adaptSize,
              height: 300.adaptSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [WebColors.greenGlow.withValues(alpha: 0.15), Colors.transparent],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 3000.ms),
          ),
        ),
        Container(
          padding: EdgeInsets.all(32.adaptSize),
          decoration: BoxDecoration(
            gradient: WebColors.cardSurfaceGradient,
            borderRadius: BorderRadius.circular(24.adaptSize),
            border: Border.all(
              color: WebColors.borderLight,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.heading(fontSize: 24),
                    children: const [
                      TextSpan(text: 'Send a '),
                      TextSpan(
                        text: 'Message',
                        style: TextStyle(color: WebColors.greenBright),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  'I aim to respond within 24 hours.',
                  style: AppTextStyles.body(fontSize: 14),
                ),
                SizedBox(height: 32.v),
                Obx(() {
                  final isMobile = Get.find<ResponsiveController>().isMobile;
                  if (isMobile) {
                    return Column(
                      children: [
                        _buildNameField(controller),
                        SizedBox(height: 16.v),
                        _buildEmailField(controller),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: _buildNameField(controller)),
                      SizedBox(width: 16.h),
                      Expanded(child: _buildEmailField(controller)),
                    ],
                  );
                }),
                SizedBox(height: 16.v),
                AppTextField(
                  controller: controller.subjectController,
                  labelText: 'Subject',
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required field' : null,
                ),
                SizedBox(height: 16.v),
                AppTextField(
                  controller: controller.messageController,
                  labelText: 'Message',
                  maxLines: 4,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required field' : null,
                ),
                SizedBox(height: 32.v),
                Obx(() => GradientSubmitButton(
                  onPressed: controller.submitForm,
                  isLoading: controller.isLoading.value,
                  isSuccess: controller.isSuccess.value,
                )),
                Obx(() {
                  if (controller.isError.value) {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.v),
                      child: Text(
                        controller.errorMessage.value,
                        style: AppTextStyles.body(
                          fontSize: 14,
                          color: WebColors.error,
                        ),
                      ).animate().fade().slideY(begin: 0.2, end: 0),
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(ContactController controller) {
    return AppTextField(
      controller: controller.nameController,
      labelText: 'Full Name',
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Required field' : null,
    );
  }

  Widget _buildEmailField(ContactController controller) {
    return AppTextField(
      controller: controller.emailController,
      labelText: 'Email Address',
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required field';
        if (!EmailValidator.validate(value)) return 'Invalid email';
        return null;
      },
    );
  }
}
