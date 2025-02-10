import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = MediaService();
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImageFromLibraray() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }
}
