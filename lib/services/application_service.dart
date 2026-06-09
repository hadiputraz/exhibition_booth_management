import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/application_model.dart';

class ApplicationService {

  final FirebaseFirestore
  _firestore =
      FirebaseFirestore
          .instance;

  Future<void> submitApplication(
      ApplicationModel application,
      ) async {

    await _firestore

        .collection(
      'applications',
    )

        .add(
      application.toMap(),
    );
  }

  Stream<List<ApplicationModel>>
  getApplications() {

    return _firestore

        .collection(
      'applications',
    )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map(
            (doc) {

          return ApplicationModel
              .fromMap(

            doc.id,

            doc.data(),
          );
        },
      ).toList();
    });
  }

  Stream<List<ApplicationModel>>
  getOrganizerApplications(
      String organizerId,
      ) {

    return _firestore

        .collection(
      'applications',
    )

        .where(

      'organizerId',

      isEqualTo:
      organizerId,
    )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map(
            (doc) {

          return ApplicationModel
              .fromMap(

            doc.id,

            doc.data(),
          );
        },
      ).toList();
    });
  }

  Stream<List<ApplicationModel>>
  getMyApplications(
      String userId,
      ) {

    return _firestore

        .collection(
      'applications',
    )

        .where(

      'userId',

      isEqualTo:
      userId,
    )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map(
            (doc) {

          return ApplicationModel
              .fromMap(

            doc.id,

            doc.data(),
          );
        },
      ).toList();
    });
  }

  Future<void>
  updateApplicationStatus({

    required String
    applicationId,

    required String status,

  }) async {

    await _firestore

        .collection(
      'applications',
    )

        .doc(applicationId)

        .update({

      'status': status,
    });
  }

  Future<void>
  updateApplicationStatusWithReason({

    required String
    applicationId,

    required String status,

    required String reason,

  }) async {

    await _firestore

        .collection(
      'applications',
    )

        .doc(applicationId)

        .update({

      'status': status,

      'reason': reason,
    });
  }

  Future<void>
  updateApplicationDetails({

    required String
    applicationId,

    required String
    companyDescription,

    required String
    exhibitDescription,

    required List<String>
    addOns,

  }) async {

    await _firestore

        .collection(
      'applications',
    )

        .doc(applicationId)

        .update({

      'companyDescription':
      companyDescription,

      'exhibitDescription':
      exhibitDescription,

      'addOns': addOns,
    });
  }

  Future<void> deleteApplication(
      String applicationId,
      ) async {

    await _firestore

        .collection(
      'applications',
    )

        .doc(applicationId)

        .delete();
  }
}