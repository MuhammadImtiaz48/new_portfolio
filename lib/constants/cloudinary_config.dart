class CloudinaryConfig {
  CloudinaryConfig._();

  // Cloudinary credentials extracted from CLOUDINARY_URL
  static const String cloudName = 'jypxqv0i';
  static const String apiKey = '881251835973521';
  // Replace with your Cloudinary API Secret if needed for signed operations:
  static const String apiSecret = '**********';

  // Base endpoints
  static const String uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
  static const String deliveryBaseUrl = 'https://res.cloudinary.com/$cloudName/image/upload';

  // Default Upload Preset (recommended for client-side uploads from Flutter Web/Mobile)
  static const String defaultUploadPreset = 'portfolio_preset';

  /// Helper method to build an optimized delivery URL for public IDs or existing URLs.
  /// Example: auto format, auto quality, optional width/height and crop.
  static String getTransformedUrl(
    String publicIdOrUrl, {
    int? width,
    int? height,
    String crop = 'fill',
    String quality = 'auto',
    String format = 'auto',
  }) {
    // If it's already a full Cloudinary URL with transformations or external URL
    if (publicIdOrUrl.startsWith('http://') || publicIdOrUrl.startsWith('https://')) {
      if (!publicIdOrUrl.contains('res.cloudinary.com/$cloudName/image/upload/')) {
        return publicIdOrUrl;
      }
      // Extract publicId after /image/upload/(optional transforms/)
      final split = publicIdOrUrl.split('/image/upload/');
      if (split.length > 1) {
        final pathAfterUpload = split[1];
        // If there's an existing transformation prefix like v12345/ or c_scale,.../
        final parts = pathAfterUpload.split('/');
        final id = parts.last;
        return _buildUrlWithTransform(id, width, height, crop, quality, format);
      }
      return publicIdOrUrl;
    }

    return _buildUrlWithTransform(publicIdOrUrl, width, height, crop, quality, format);
  }

  static String _buildUrlWithTransform(
    String publicId,
    int? width,
    int? height,
    String crop,
    String quality,
    String format,
  ) {
    final List<String> transforms = [];

    if (format.isNotEmpty) transforms.add('f_$format');
    if (quality.isNotEmpty) transforms.add('q_$quality');
    if (width != null && width > 0) transforms.add('w_$width');
    if (height != null && height > 0) transforms.add('h_$height');
    if ((width != null || height != null) && crop.isNotEmpty) {
      transforms.add('c_$crop');
    }

    final transformString = transforms.isNotEmpty ? '${transforms.join(',')}/' : '';
    return '$deliveryBaseUrl/$transformString$publicId';
  }
}
