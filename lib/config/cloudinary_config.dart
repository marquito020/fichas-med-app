import 'package:cloudinary/cloudinary.dart';

import '../constants/cloudinary_constants.dart';

class CloudinaryConfig {
  static final signed = Cloudinary.signedConfig(
      apiKey: CloudinaryConstants.apiKey,
      apiSecret: CloudinaryConstants.apiSecret,
      cloudName: CloudinaryConstants.cloudName);
}
