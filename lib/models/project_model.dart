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
    final data = doc.data() as Map<String, dynamic>;
    return ProjectModel(
      id: doc.id,
      title: data[DbCollections.projectTitle] ?? '',
      category: data[DbCollections.projectCategory] ?? '',
      shortDescription: data[DbCollections.projectShortDescription] ?? '',
      fullDescription: data[DbCollections.projectFullDescription] ?? '',
      mediaUrls: List<String>.from(data[DbCollections.projectMediaUrls] ?? []),
      techStack: List<String>.from(data[DbCollections.projectTechStack] ?? []),
      features: data.containsKey('features') ? List<String>.from(data['features']) : [],
      playStoreUrl: data[DbCollections.projectPlayStoreUrl],
      appStoreUrl: data[DbCollections.projectAppStoreUrl],
      githubUrl: data[DbCollections.projectGithubUrl],
      liveDemoUrl: data[DbCollections.projectLiveDemoUrl],
      status: data[DbCollections.projectStatus] ?? '',
      featured: data[DbCollections.projectFeatured] ?? false,
      sortOrder: data[DbCollections.projectSortOrder] ?? 0,
      createdAt: (data[DbCollections.projectCreatedAt] as Timestamp?)?.toDate(),
    );
  }
}
