import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:portfolio/models/site_profile_model.dart';
import 'package:portfolio/services/site_profile_service.dart';

class AboutController extends GetxController {
  final SiteProfileService _profileService = Get.put(SiteProfileService(), permanent: true);

  final Rx<SiteProfileModel> profile = SiteProfileModel.defaultProfile().obs;
  StreamSubscription<SiteProfileModel>? _subscription;

  @override
  void onInit() {
    super.onInit();
    try {
      _subscription = _profileService.streamProfile().listen(
        (p) => profile.value = p,
        onError: (e) => debugPrint('About profile stream error: $e'),
      );
    } catch (e) {
      debugPrint('Error initiating about profile stream: $e');
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  String get aboutHeading => profile.value.aboutHeading;
  String get bioParagraph1 => profile.value.aboutBioParagraph1;
  String get bioParagraph2 => profile.value.aboutBioParagraph2;
  String get location => profile.value.aboutLocation;
  String get experience => profile.value.aboutExperience;
  String get education => profile.value.aboutEducation;
  String get speciality => profile.value.aboutSpeciality;
  List<String> get skills => profile.value.skills;
  String get profileImageUrl => profile.value.profileImageUrl;
}
