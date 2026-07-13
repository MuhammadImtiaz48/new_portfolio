import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/constants/db_collections.dart';
import 'package:portfolio/models/project_model.dart';

class ProjectService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final snapshot = await _firestore
          .collection(DbCollections.projectsCollection)
          .orderBy(DbCollections.projectSortOrder)
          .get();

      return snapshot.docs
          .map((doc) => ProjectModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      // Fallback: fetch without ordering by sortOrder if the index doesn't exist yet
      try {
        final snapshot = await _firestore
            .collection(DbCollections.projectsCollection)
            .orderBy(DbCollections.projectCreatedAt)
            .get();

        return snapshot.docs
            .map((doc) => ProjectModel.fromFirestore(doc))
            .toList();
      } catch (e2) {
        // Fallback to basic get if sorting fails
        final snapshot = await _firestore
            .collection(DbCollections.projectsCollection)
            .get();

        final projects = snapshot.docs
            .map((doc) => ProjectModel.fromFirestore(doc))
            .toList();
        
        projects.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        return projects;
      }
    }
  }
}
