class RAPCategory {
  int id;
  String rapCateName;
  String rapCateType;
  String rapCateUrlImage;

  RAPCategory({
    required this.id,
    required this.rapCateName,
    required this.rapCateType,
    required this.rapCateUrlImage,
  });

  RAPCategory.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        rapCateName = data["rapCateName"],
        rapCateType = data["rapCateType"],
        rapCateUrlImage = data["rapCateUrlImage"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rapCateName': rapCateName,
      'rapCateType': rapCateType,
      'rapCateUrlImage': rapCateUrlImage,
    };
  }
}
