import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/db_collections.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  final isError = false.obs;
  final errorMessage = ''.obs;

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
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
