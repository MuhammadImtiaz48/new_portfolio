import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/constants/colors.dart';

enum AppMediaType {
  image,
  video,
  document,
  unknown,
}

class MediaHelper {
  MediaHelper._();

  static const List<String> supportedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
    'gif',
    'svg',
    'bmp',
    'ico',
    'tiff',
  ];

  static const List<String> supportedVideoExtensions = [
    'mp4',
    'mov',
    'avi',
    'mkv',
    'webm',
    'flv',
    'wmv',
    'm4v',
  ];

  static const List<String> supportedDocumentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'csv',
    'zip',
    'rar',
    'json',
    'xml',
    'md',
  ];

  static List<String> get allSupportedExtensions => [
        ...supportedImageExtensions,
        ...supportedVideoExtensions,
        ...supportedDocumentExtensions,
      ];

  /// Extract file extension from filename or URL (lowercase, without dot)
  static String getFileExtension(String pathOrUrl) {
    if (pathOrUrl.isEmpty) return '';
    try {
      final cleanUrl = pathOrUrl.split('?').first.split('#').first;
      final segments = cleanUrl.split('/');
      final filename = segments.isNotEmpty ? segments.last : cleanUrl;
      final dotIndex = filename.lastIndexOf('.');
      if (dotIndex != -1 && dotIndex < filename.length - 1) {
        return filename.substring(dotIndex + 1).toLowerCase();
      }
    } catch (_) {}
    return '';
  }

  /// Extract filename from path or URL
  static String getFileName(String pathOrUrl) {
    if (pathOrUrl.isEmpty) return 'File';
    try {
      final cleanUrl = pathOrUrl.split('?').first.split('#').first;
      final segments = cleanUrl.split('/');
      if (segments.isNotEmpty && segments.last.isNotEmpty) {
        return Uri.decodeComponent(segments.last);
      }
    } catch (_) {}
    return pathOrUrl;
  }

  /// Detect media type from filename, URL, or extension
  static AppMediaType getMediaType(String pathOrUrl) {
    final ext = getFileExtension(pathOrUrl);
    if (supportedImageExtensions.contains(ext)) {
      return AppMediaType.image;
    }
    if (supportedVideoExtensions.contains(ext)) {
      return AppMediaType.video;
    }
    if (supportedDocumentExtensions.contains(ext)) {
      return AppMediaType.document;
    }

    // Secondary check if Cloudinary URL path contains /image/, /video/, /raw/
    final lower = pathOrUrl.toLowerCase();
    if (lower.contains('/image/upload/')) return AppMediaType.image;
    if (lower.contains('/video/upload/')) return AppMediaType.video;
    if (lower.contains('/raw/upload/')) return AppMediaType.document;

    return AppMediaType.unknown;
  }

  /// Format bytes to human readable format (e.g. "2.4 MB", "540 KB")
  static String formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Returns appropriate icon for document extension
  static IconData getDocumentIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      case 'txt':
      case 'md':
      case 'json':
      case 'xml':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

  /// Returns theme color for document extension
  static Color getDocumentColor(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return const Color(0xFFFF5252);
      case 'doc':
      case 'docx':
        return const Color(0xFF42A5F5);
      case 'xls':
      case 'xlsx':
      case 'csv':
        return const Color(0xFF66BB6A);
      case 'ppt':
      case 'pptx':
        return const Color(0xFFFFA726);
      case 'zip':
      case 'rar':
        return const Color(0xFFAB47BC);
      case 'txt':
      case 'md':
        return const Color(0xFF90A4AE);
      default:
        return WebColors.greenPrimary;
    }
  }

  /// Cloudinary video thumbnail generation: replace extension with .jpg
  static String? getVideoThumbnail(String url) {
    if (url.isEmpty) return null;
    final lower = url.toLowerCase();
    if (lower.contains('/video/upload/')) {
      try {
        final cleanUrl = url.split('?').first.split('#').first;
        final extensionIndex = cleanUrl.lastIndexOf('.');
        if (extensionIndex != -1) {
          final baseUrl = cleanUrl.substring(0, extensionIndex);
          return '$baseUrl.jpg';
        }
      } catch (_) {}
    }
    return null;
  }

  /// Open/Download document or URL in external browser / viewer
  static Future<bool> openUrl(String url) async {
    if (url.trim().isEmpty) return false;
    try {
      final uri = Uri.parse(url.trim());
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
    return false;
  }
}
