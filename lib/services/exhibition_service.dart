import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/exhibition_model.dart';

class ExhibitionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExhibition(ExhibitionModel exhibition) async {
    await _firestore.collection('exhibitions').add(exhibition.toMap());
  }

  Stream<List<ExhibitionModel>> getPublishedExhibitions() {
    return _firestore
        .collection('exhibitions')
        .where('isPublished', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExhibitionModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }
}
