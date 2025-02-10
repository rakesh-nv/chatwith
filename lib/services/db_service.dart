
import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  String _userCollection = "Users";

  static DBService instance = DBService();

  Future<void> createUserInDB(
      String _uid, String _name, String _email, String _imageURL) async {
    try {
      await FirebaseFirestore.instance.collection(_userCollection).doc(_uid)
          .set(
        {
          "name": _name,
          "email": _email,
          "image": _imageURL,
          "lastSeen": DateTime.now().toUtc(),
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
