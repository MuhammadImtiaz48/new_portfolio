import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/constants/db_collections.dart';
import 'package:portfolio/models/project_model.dart';

class ProjectService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ProjectModel>> streamProjects() {
    return _firestore
        .collection(DbCollections.projectsCollection)
        .snapshots()
        .map((snapshot) {
          try {
            if (snapshot.docs.isNotEmpty) {
              final projects = <ProjectModel>[];
              for (final doc in snapshot.docs) {
                try {
                  final p = ProjectModel.fromFirestore(doc);
                  final s = p.status.trim().toLowerCase();
                  if (s != 'maintenance' && s != 'staging' && s != 'under maintenance' && s != 'coming soon') {
                    projects.add(p);
                  }
                } catch (_) {}
              }
              projects.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
              if (projects.isNotEmpty) {
                return projects;
              }
            }
          } catch (_) {}
          return getDefaultProjects();
        })
        .handleError((error) {
          return getDefaultProjects();
        });
  }

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final snapshot = await _firestore
          .collection(DbCollections.projectsCollection)
          .get()
          .timeout(const Duration(seconds: 4));

      if (snapshot.docs.isNotEmpty) {
        final projects = <ProjectModel>[];
        for (final doc in snapshot.docs) {
          try {
            final p = ProjectModel.fromFirestore(doc);
            final s = p.status.trim().toLowerCase();
            if (s != 'maintenance' && s != 'staging' && s != 'under maintenance' && s != 'coming soon') {
              projects.add(p);
            }
          } catch (_) {}
        }
        projects.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        if (projects.isNotEmpty) return projects;
      }
    } catch (_) {}

    // Default curated projects from Muhammad Imtiaz's Resume
    return getDefaultProjects();
  }

  List<ProjectModel> getDefaultProjects() {
    return const [
      ProjectModel(
        id: 'ndy_chat_app',
        title: 'NDY App',
        category: 'Social Chat Platform',
        shortDescription:
            'Full-featured real-time social chat app in Flutter with one-on-one messaging, typing indicators, and message status tracking.',
        fullDescription:
            'Developed a full-featured social chat app in Flutter with real-time one-on-one messaging, typing indicators, and message status tracking (sent, delivered, seen).\n\nKey Highlights:\n• Complete authentication flow (login, registration, email verification, forgot password) with rich user profiles, skills, and social links.\n• Media support for images, documents, and voice messages.\n• Push notifications (FCM), in-app search, and a guided onboarding experience.',
        mediaUrls: [],
        techStack: ['Flutter', 'Dart', 'Provider', 'GoRouter', 'Google Fonts', 'FCM'],
        features: [
          'Real-Time 1-on-1 Messaging',
          'Typing Indicators & Seen Status',
          'Voice & Document Messages',
          'Push Notifications (FCM)',
          'Rich User Profiles & Social Links',
          'Guided Onboarding Experience',
        ],
        githubUrl: 'https://github.com/MuhammadImtiaz48',
        status: 'Live',
        featured: true,
        sortOrder: 1,
      ),
      ProjectModel(
        id: 'turame_healthcare',
        title: 'TURAME',
        category: 'Healthcare & Booking App',
        shortDescription:
            'Multi-role healthcare platform connecting clients, caregivers, and providers with Stripe payments and ZegoCloud video consultations.',
        fullDescription:
            'Built a multi-role healthcare platform in Flutter connecting clients, caregivers, and providers with dedicated dashboards for each role.\n\nKey Highlights:\n• Integrated Firebase (Auth, Firestore, Cloud Functions, FCM) for real-time data sync, secure auth, and notifications.\n• Implemented Stripe payment processing via Firebase Cloud Functions for secure bookings, invoicing, and transaction/earnings history.\n• Added real-time video/audio consultations using ZegoCloud and wearable health-device data integration for patient monitoring.',
        mediaUrls: [],
        techStack: ['Flutter', 'GetX', 'Firebase Suite', 'Stripe', 'ZegoCloud', 'Health SDK'],
        features: [
          'Multi-Role Dashboards (Client, Caregiver, Provider)',
          'Stripe Payment Gateway Integration',
          'ZegoCloud Audio/Video Consultations',
          'Wearable Device Data Monitoring',
          'Real-Time Firebase Sync & Cloud Functions',
        ],
        githubUrl: 'https://github.com/MuhammadImtiaz48',
        status: 'Live',
        featured: true,
        sortOrder: 2,
      ),
      ProjectModel(
        id: 'inhale_pilates',
        title: 'Inhale Pilates',
        category: 'Fitness Studio Booking App',
        shortDescription:
            'Fitness and pilates studio booking app enabling clients to schedule sessions and make secure payments via Mollie.',
        fullDescription:
            'Developed a Flutter-based booking app for a pilates/fitness studio, enabling clients to schedule and pay for classes.\n\nKey Highlights:\n• Integrated the Mollie payment gateway to handle secure, seamless online payments for class bookings and memberships.\n• Class calendar, pass renewals, and interactive schedule management.',
        mediaUrls: [],
        techStack: ['Flutter', 'Dart', 'Mollie Payments', 'REST APIs', 'Clean Architecture'],
        features: [
          'Class Scheduling & Booking',
          'Mollie Payment Gateway',
          'Membership Passes & Renewals',
          'Interactive Calendar',
        ],
        githubUrl: 'https://github.com/MuhammadImtiaz48',
        status: 'Live',
        featured: true,
        sortOrder: 3,
      ),
      ProjectModel(
        id: 'mechat_app',
        title: 'MeChat App',
        category: 'Messaging Platform',
        shortDescription:
            'Cross-platform messaging application in Flutter built with clean architecture, smooth animations, and intuitive UI.',
        fullDescription:
            'Built a cross-platform messaging application in Flutter with a focus on clean UI, smooth 60fps animations, and responsive user experience across Android and iOS.',
        mediaUrls: [],
        techStack: ['Flutter', 'Dart', 'Firebase', 'GetX', 'Clean Architecture'],
        features: [
          'Instant Messaging',
          'Clean Architecture',
          'Smooth 60fps UI',
          'Dark Theme Support',
        ],
        githubUrl: 'https://github.com/MuhammadImtiaz48',
        status: 'Live',
        featured: true,
        sortOrder: 4,
      ),
      ProjectModel(
        id: 'real_estate_app',
        title: 'Real Estate App',
        category: 'Property Listing App',
        shortDescription:
            'Property listing and browsing app in Flutter delivering an intuitive interface for exploring real estate listings.',
        fullDescription:
            'Developed a property listing and browsing app in Flutter, delivering an intuitive interface for exploring real estate listings with search filters and media galleries.',
        mediaUrls: [],
        techStack: ['Flutter', 'Dart', 'REST APIs', 'Provider', 'Cloudinary'],
        features: [
          'Property Listing & Browsing',
          'Advanced Search Filters',
          'High-Res Media Galleries',
          'Contact Agent Directly',
        ],
        githubUrl: 'https://github.com/MuhammadImtiaz48',
        status: 'Live',
        featured: true,
        sortOrder: 5,
      ),
    ];
  }
}
