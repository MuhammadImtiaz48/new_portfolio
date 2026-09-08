import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/constants/db_collections.dart';
import 'package:portfolio/models/site_profile_model.dart';

class SiteProfileService {
  final DocumentReference<Map<String, dynamic>> _docRef = FirebaseFirestore
      .instance
      .collection(DbCollections.siteProfileCollection)
      .doc(DbCollections.siteProfileDoc);

  Stream<SiteProfileModel> streamProfile() {
    return _docRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return SiteProfileModel.defaultProfile();
      }
      return SiteProfileModel.fromMap(snapshot.data()!);
    }).handleError((error) {
      return SiteProfileModel.defaultProfile();
    });
  }

  Future<SiteProfileModel> getProfile() async {
    try {
      final snapshot = await _docRef.get().timeout(const Duration(seconds: 4));
      if (!snapshot.exists || snapshot.data() == null) {
        return SiteProfileModel.defaultProfile();
      }
      return SiteProfileModel.fromMap(snapshot.data()!);
    } catch (_) {
      return SiteProfileModel.defaultProfile();
    }
  }
}
