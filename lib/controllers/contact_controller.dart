import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/db_collections.dart';
import 'package:portfolio/models/site_profile_model.dart';
import 'package:portfolio/services/site_profile_service.dart';

class ContactController extends GetxController {
  final SiteProfileService _profileService = Get.put(SiteProfileService(), permanent: true);

  final Rx<SiteProfileModel> profile = SiteProfileModel.defaultProfile().obs;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  final isError = false.obs;
  final errorMessage = ''.obs;

  StreamSubscription<SiteProfileModel>? _subscription;

  @override
  void onInit() {
    super.onInit();
    try {
      _subscription = _profileService.streamProfile().listen(
        (p) => profile.value = p,
        onError: (e) => debugPrint('Contact profile stream error: $e'),
      );
    } catch (e) {
      debugPrint('Error subscribing to contact profile: $e');
    }
  }

  String get subtext => profile.value.contactSubtext;
  String get availabilityStatus => profile.value.availabilityStatus;
  String get email => profile.value.email;
  String get phone => profile.value.phone;
  String get whatsapp => profile.value.whatsapp;
  String get githubUsername => profile.value.githubUsername;
  String get githubUrl => profile.value.githubUrl;

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (isLoading.value) return;

      isLoading.value = true;
      isSuccess.value = false;
      isError.value = false;
      errorMessage.value = '';

      try {
        await FirebaseFirestore.instance
            .collection(DbCollections.messagesCollection)
            .add({
          DbCollections.messageName: nameController.text.trim(),
          DbCollections.messageEmail: emailController.text.trim(),
          DbCollections.messageSubject: subjectController.text.trim(),
          DbCollections.messageContent: messageController.text.trim(),
          DbCollections.messageTimestamp: FieldValue.serverTimestamp(),
          DbCollections.messageIsRead: false,
        });

        isSuccess.value = true;

        // Clear the form on success
        nameController.clear();
        emailController.clear();
        subjectController.clear();
        messageController.clear();

        // Reset success state after a brief moment
        await Future.delayed(const Duration(seconds: 3));
        isSuccess.value = false;
      } catch (e) {
        isError.value = true;
        errorMessage.value = 'Failed to send message. Please try again.';
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
