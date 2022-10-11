import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DbFirestore {
  DbFirestore();

  static final DbFirestore instance = DbFirestore();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return DbFirestore.instance.firestore;
  }
}
