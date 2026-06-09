import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/booth_model.dart';

class BoothService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooth(BoothModel booth) async {
    await _firestore.collection('booths').add(booth.toMap());
  }

  Stream<List<BoothModel>> getBooths(String exhibitionId) {
    return _firestore
        .collection('booths')
        .where(
          'exhibitionId',
          isEqualTo: exhibitionId,
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BoothModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }
}
