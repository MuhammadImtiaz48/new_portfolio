import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

void downloadFile(String path, String fileName) async {
  try {
    final uri = Uri.parse(path);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    debugPrint('Error launching url: $e');
  }
}
