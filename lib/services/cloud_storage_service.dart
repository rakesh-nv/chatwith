import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CloudStorageService {
  static final CloudStorageService instance = CloudStorageService();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  late final Reference _baseRef = _storage.ref();

  final String _profileImages = "profile_images";

  Future<TaskSnapshot?> uploadUserImage(String uid, File image) async {
    try {
      Reference userImageRef = _baseRef.child(_profileImages).child(uid);
      UploadTask uploadTask = userImageRef.putFile(image);
      return await uploadTask;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}
