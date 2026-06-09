class ApplicationModel {

  final String id;

  final String userId;

  final String organizerId;

  final String exhibitionId;

  final List<String> boothIds;

  final String companyName;

  final String companyDescription;

  final String exhibitDescription;

  final String startDate;

  final String endDate;

  final List<String> addOns;

  final String status;

  final String? reason;

  ApplicationModel({

    required this.id,

    required this.userId,

    required this.organizerId,

    required this.exhibitionId,

    required this.boothIds,

    required this.companyName,

    required this.companyDescription,

    required this.exhibitDescription,

    required this.startDate,

    required this.endDate,

    required this.addOns,

    required this.status,

    required this.reason,
  });

  factory ApplicationModel.fromMap(

      String id,

      Map<String, dynamic> data,

      ) {

    return ApplicationModel(

      id: id,

      userId:
      data['userId'] ?? '',

      organizerId:
      data['organizerId'] ?? '',

      exhibitionId:
      data['exhibitionId'] ?? '',

      boothIds:
      List<String>.from(
        data['boothIds'] ?? [],
      ),

      companyName:
      data['companyName'] ?? '',

      companyDescription:
      data['companyDescription'] ?? '',

      exhibitDescription:
      data['exhibitDescription'] ?? '',

      startDate:
      data['startDate'] ?? '',

      endDate:
      data['endDate'] ?? '',

      addOns:
      List<String>.from(
        data['addOns'] ?? [],
      ),

      status:
      data['status'] ?? '',

      reason:
      data['reason'],
    );
  }

  Map<String, dynamic> toMap() {

    return {

      'userId':
      userId,

      'organizerId':
      organizerId,

      'exhibitionId':
      exhibitionId,

      'boothIds':
      boothIds,

      'companyName':
      companyName,

      'companyDescription':
      companyDescription,

      'exhibitDescription':
      exhibitDescription,

      'startDate':
      startDate,

      'endDate':
      endDate,

      'addOns':
      addOns,

      'status':
      status,

      'reason':
      reason,
    };
  }
}