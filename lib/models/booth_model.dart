class BoothModel {

  final String id;

  final String organizerId;

  final String exhibitionId;

  final String exhibitionTitle;

  final String boothNumber;

  final String boothType;

  final double price;

  final bool isBooked;

  BoothModel({

    required this.id,

    required this.organizerId,

    required this.exhibitionId,

    required this.exhibitionTitle,

    required this.boothNumber,

    required this.boothType,

    required this.price,

    required this.isBooked,
  });

  factory BoothModel.fromMap(

      String id,

      Map<String, dynamic> data,

      ) {

    return BoothModel(

      id: id,

      organizerId:
      data['organizerId'] ?? '',

      exhibitionId:
      data['exhibitionId'] ?? '',

      exhibitionTitle:
      data['exhibitionTitle'] ?? '',

      boothNumber:
      data['boothNumber'] ?? '',

      boothType:
      data['boothType'] ?? '',

      price:
      (data['price'] ?? 0)
          .toDouble(),

      isBooked:
      data['isBooked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {

    return {

      'organizerId':
      organizerId,

      'exhibitionId':
      exhibitionId,

      'exhibitionTitle':
      exhibitionTitle,

      'boothNumber':
      boothNumber,

      'boothType':
      boothType,

      'price':
      price,

      'isBooked':
      isBooked,
    };
  }
}