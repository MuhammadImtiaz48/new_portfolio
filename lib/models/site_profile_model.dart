import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/constants/db_collections.dart';
import 'package:portfolio/models/stat_item_model.dart';

class SiteProfileModel {
  final String heroEyebrow;
  final String heroTitle;
  final String heroSubtitle;
  final String heroBio;
  final List<String> heroTechTags;
  final String profileImageUrl;
  final String resumeUrl;
  final List<StatItemModel> stats;
  final String aboutHeading;
  final String aboutBioParagraph1;
  final String aboutBioParagraph2;
  final String aboutLocation;
  final String aboutExperience;
  final String aboutEducation;
  final String aboutSpeciality;
  final List<String> skills;
  final String contactSubtext;
  final String availabilityStatus;
  final String email;
  final String phone;
  final String whatsapp;
  final String githubUsername;
  final String githubUrl;
  final DateTime? updatedAt;

  const SiteProfileModel({
    required this.heroEyebrow,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroBio,
    required this.heroTechTags,
    required this.profileImageUrl,
    required this.resumeUrl,
    required this.stats,
    required this.aboutHeading,
    required this.aboutBioParagraph1,
    required this.aboutBioParagraph2,
    required this.aboutLocation,
    required this.aboutExperience,
    required this.aboutEducation,
    required this.aboutSpeciality,
    required this.skills,
    required this.contactSubtext,
    required this.availabilityStatus,
    required this.email,
    required this.phone,
    required this.whatsapp,
    required this.githubUsername,
    required this.githubUrl,
    this.updatedAt,
  });

  factory SiteProfileModel.defaultProfile() {
    return const SiteProfileModel(
      heroEyebrow: 'FLUTTER APP DEVELOPER',
      heroTitle: 'Muhammad Imtiaz',
      heroSubtitle: 'Building production-ready mobile apps.',
      heroBio:
          'Flutter Developer with 2+ years of hands-on experience building and shipping cross-platform mobile apps end to end — spanning social/chat, healthcare booking, real estate, and fitness domains with Firebase, payment gateways (Stripe, Mollie), and clean architecture.',
      heroTechTags: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST APIs',
        'GetX & Provider',
        'Stripe & Mollie',
        'Cloudinary',
        'ZegoCloud',
        'Clean Arch',
      ],
      profileImageUrl: '',
      resumeUrl: '',
      stats: [
        StatItemModel(label: 'Location', value: 'Sadiq Abad, PK'),
        StatItemModel(label: 'Experience', value: '2+ Years'),
        StatItemModel(label: 'Projects', value: '5+'),
        StatItemModel(label: 'Availability', value: 'Open'),
      ],
      aboutHeading: 'Building seamless mobile apps with clean code & precision.',
      aboutBioParagraph1:
          'I am a Flutter App Developer with 2+ years of hands-on experience building and shipping cross-platform mobile applications end to end — from UI implementation to backend integration, real-time features, and payment systems.',
      aboutBioParagraph2:
          'I have a proven track record delivering production-ready applications spanning social chat platforms (NDY App, MeChat), healthcare caregiver booking (TURAME), real estate property listing, and fitness booking systems (Inhale Pilates). Skilled in Dart, Firebase Suite, REST APIs, Provider & GetX, Payment Gateways (Stripe, Mollie), ZegoCloud real-time video/audio, and Cloudinary media handling.',
      aboutLocation: 'Sadiq Abad, PK',
      aboutExperience: '2+ Years · VertualSoft',
      aboutEducation: 'BSCS · KFUEIT (2022-26)',
      aboutSpeciality: 'Flutter · Firebase · Stripe',
      skills: [
        'Flutter',
        'Dart',
        'Firebase (Auth, Firestore, Storage)',
        'REST APIs Integration',
        'GetX & Provider State Management',
        'Stripe & Mollie Payment Gateways',
        'Cloudinary Media Handling',
        'ZegoCloud Video/Audio Calling',
        'Clean Architecture & MVVM',
        'FCM Push Notifications',
        'Git & GitHub Version Control',
        'Responsive Web & Mobile UI',
      ],
      contactSubtext:
          'Have a project in mind or just want to say hi?\nI am always open to discussing new opportunities.',
      availabilityStatus: 'Available for new projects',
      email: 'developerhouseapl@gmail.com',
      phone: '+92 341 0333820',
      whatsapp: '+92 341 0333820',
      githubUsername: 'MuhammadImtiaz48',
      githubUrl: 'https://github.com/MuhammadImtiaz48',
    );
  }

  factory SiteProfileModel.fromMap(Map<String, dynamic> map) {
    final rawStats = map[SiteProfileFields.stats];
    final List<StatItemModel> parsedStats = [];
    if (rawStats is List) {
      for (final item in rawStats) {
        if (item is Map) {
          final label = item[SiteProfileFields.statLabel]?.toString() ?? '';
          final value = item[SiteProfileFields.statValue]?.toString() ?? '';
          if (label.isNotEmpty || value.isNotEmpty) {
            parsedStats.add(StatItemModel(label: label, value: value));
          }
        }
      }
    }

    final defaults = SiteProfileModel.defaultProfile();

    return SiteProfileModel(
      heroEyebrow: map[SiteProfileFields.heroEyebrow]?.toString() ?? defaults.heroEyebrow,
      heroTitle: map[SiteProfileFields.heroTitle]?.toString() ?? defaults.heroTitle,
      heroSubtitle: map[SiteProfileFields.heroSubtitle]?.toString() ?? defaults.heroSubtitle,
      heroBio: map[SiteProfileFields.heroBio]?.toString() ?? defaults.heroBio,
      heroTechTags: map[SiteProfileFields.heroTechTags] != null
          ? List<String>.from(map[SiteProfileFields.heroTechTags])
          : defaults.heroTechTags,
      profileImageUrl:
          map[SiteProfileFields.profileImageUrl]?.toString() ?? defaults.profileImageUrl,
      resumeUrl: map[SiteProfileFields.resumeUrl]?.toString() ?? defaults.resumeUrl,
      stats: parsedStats.isNotEmpty ? parsedStats : defaults.stats,
      aboutHeading:
          map[SiteProfileFields.aboutHeading]?.toString() ?? defaults.aboutHeading,
      aboutBioParagraph1:
          map[SiteProfileFields.aboutBioParagraph1]?.toString() ?? defaults.aboutBioParagraph1,
      aboutBioParagraph2:
          map[SiteProfileFields.aboutBioParagraph2]?.toString() ?? defaults.aboutBioParagraph2,
      aboutLocation:
          map[SiteProfileFields.aboutLocation]?.toString() ?? defaults.aboutLocation,
      aboutExperience:
          map[SiteProfileFields.aboutExperience]?.toString() ?? defaults.aboutExperience,
      aboutEducation:
          map[SiteProfileFields.aboutEducation]?.toString() ?? defaults.aboutEducation,
      aboutSpeciality:
          map[SiteProfileFields.aboutSpeciality]?.toString() ?? defaults.aboutSpeciality,
      skills: map[SiteProfileFields.skills] != null
          ? List<String>.from(map[SiteProfileFields.skills])
          : defaults.skills,
      contactSubtext:
          map[SiteProfileFields.contactSubtext]?.toString() ?? defaults.contactSubtext,
      availabilityStatus:
          map[SiteProfileFields.availabilityStatus]?.toString() ?? defaults.availabilityStatus,
      email: map[SiteProfileFields.email]?.toString() ?? defaults.email,
      phone: map[SiteProfileFields.phone]?.toString() ?? defaults.phone,
      whatsapp: map[SiteProfileFields.whatsapp]?.toString() ?? defaults.whatsapp,
      githubUsername:
          map[SiteProfileFields.githubUsername]?.toString() ?? defaults.githubUsername,
      githubUrl: map[SiteProfileFields.githubUrl]?.toString() ?? defaults.githubUrl,
      updatedAt: (map[SiteProfileFields.updatedAt] as Timestamp?)?.toDate(),
    );
  }

  factory SiteProfileModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      return SiteProfileModel.defaultProfile();
    }
    return SiteProfileModel.fromMap(doc.data()!);
  }
}
