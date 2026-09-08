import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:portfolio/constants/cloudinary_config.dart';

class CloudinaryService {
  /// Uploads image bytes (compatible with Flutter Web, Android, iOS, Windows, macOS, Linux).
  ///
  /// [fileBytes]: Uint8List containing image data.
  /// [fileName]: Name for the file (e.g., 'project1.png').
  /// [uploadPreset]: Cloudinary Unsigned Upload Preset (defaults to [CloudinaryConfig.defaultUploadPreset]).
  /// [folder]: Optional folder path in Cloudinary (e.g., 'portfolio/projects').
  ///
  /// Returns the secure HTTPS URL of the uploaded image.
  Future<String?> uploadImageBytes({
    required Uint8List fileBytes,
    required String fileName,
    String? uploadPreset,
    String? folder,
  }) async {
    try {
      final uri = Uri.parse(CloudinaryConfig.uploadUrl);
      final request = http.MultipartRequest('POST', uri);

      // Add file
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      );
      request.files.add(multipartFile);

      // Add preset or API Key
      final preset = uploadPreset ?? CloudinaryConfig.defaultUploadPreset;
      request.fields['upload_preset'] = preset;

      if (folder != null && folder.isNotEmpty) {
        request.fields['folder'] = folder;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['secure_url'] as String?;
      } else {
        // ignore: avoid_print
        print('Cloudinary upload failed (${response.statusCode}): ${response.body}');
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Cloudinary upload error: $e');
      return null;
    }
  }

  /// Uploads an image by its web URL into Cloudinary.
  Future<String?> uploadFromUrl({
    required String imageUrl,
    String? uploadPreset,
    String? folder,
  }) async {
    try {
      final uri = Uri.parse(CloudinaryConfig.uploadUrl);
      final response = await http.post(
        uri,
        body: {
          'file': imageUrl,
          'upload_preset': uploadPreset ?? CloudinaryConfig.defaultUploadPreset,
          if (folder != null && folder.isNotEmpty) 'folder': folder,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['secure_url'] as String?;
      } else {
        // ignore: avoid_print
        print('Cloudinary URL upload failed (${response.statusCode}): ${response.body}');
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Cloudinary URL upload error: $e');
      return null;
    }
  }

  /// Generates an optimized, responsive Cloudinary delivery URL.
  String getOptimizedUrl(
    String publicIdOrUrl, {
    int? width,
    int? height,
    String crop = 'fill',
    String quality = 'auto',
    String format = 'auto',
  }) {
    return CloudinaryConfig.getTransformedUrl(
      publicIdOrUrl,
      width: width,
      height: height,
      crop: crop,
      quality: quality,
      format: format,
    );
  }
}
