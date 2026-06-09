class ExhibitionModel {

  final String id;

  final String organizerId;

  final String title;

  final String description;

  final String location;

  final String startDate;

  final String endDate;

  final bool isPublished;

  ExhibitionModel({

    required this.id,

    required this.organizerId,

    required this.title,

    required this.description,

    required this.location,

    required this.startDate,

    required this.endDate,

    required this.isPublished,
  });

  factory ExhibitionModel.fromMap(

      String id,

      Map<String, dynamic> data,

      ) {

    return ExhibitionModel(

      id: id,

      organizerId:
      data['organizerId'] ?? '',

      title:
      data['title'] ?? '',

      description:
      data['description'] ?? '',

      location:
      data['location'] ?? '',

      startDate:
      data['startDate'] ?? '',

      endDate:
      data['endDate'] ?? '',

      isPublished:
      data['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {

    return {

      'organizerId':
      organizerId,

      'title':
      title,

      'description':
      description,

      'location':
      location,

      'startDate':
      startDate,

      'endDate':
      endDate,

      'isPublished':
      isPublished,
    };
  }
}