import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/constants/db_collections.dart';

class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final List<String> mediaUrls;
  final List<String> techStack;
  final List<String> features;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String status;
  final bool featured;
  final int sortOrder;
  final DateTime? createdAt;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.mediaUrls,
    required this.techStack,
    required this.features,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
    this.liveDemoUrl,
    required this.status,
    required this.featured,
    required this.sortOrder,
    this.createdAt,
  });

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final rawData = doc.data();
    final data = (rawData is Map<String, dynamic>) ? rawData : <String, dynamic>{};

    int parseSortOrder(dynamic val) {
      if (val is int) return val;
      if (val is num) return val.toInt();
      if (val is String) return int.tryParse(val) ?? 0;
      return 0;
    }

    DateTime? parseDateTime(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is DateTime) return val;
      if (val is String) return DateTime.tryParse(val);
      return null;
    }

    List<String> parseStringList(dynamic val) {
      if (val is List) {
        return val.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
      }
      return [];
    }

    return ProjectModel(
      id: doc.id,
      title: data[DbCollections.projectTitle]?.toString() ?? '',
      category: data[DbCollections.projectCategory]?.toString() ?? '',
      shortDescription: data[DbCollections.projectShortDescription]?.toString() ?? '',
      fullDescription: data[DbCollections.projectFullDescription]?.toString() ?? '',
      mediaUrls: parseStringList(data[DbCollections.projectMediaUrls]),
      techStack: parseStringList(data[DbCollections.projectTechStack]),
      features: parseStringList(data['features'] ?? data['featureList']),
      playStoreUrl: data[DbCollections.projectPlayStoreUrl]?.toString(),
      appStoreUrl: data[DbCollections.projectAppStoreUrl]?.toString(),
      githubUrl: data[DbCollections.projectGithubUrl]?.toString(),
      liveDemoUrl: data[DbCollections.projectLiveDemoUrl]?.toString(),
      status: data[DbCollections.projectStatus]?.toString() ?? '',
      featured: data[DbCollections.projectFeatured] == true || data[DbCollections.projectFeatured]?.toString() == 'true',
      sortOrder: parseSortOrder(data[DbCollections.projectSortOrder]),
      createdAt: parseDateTime(data[DbCollections.projectCreatedAt]),
    );
  }
}
