class ModelAccommandation {
  String? type;
  List<String>? details;
  double? price;
  String? instagram;
  String? facebook;
  String? website;
  String? locationURL;

  ModelAccommandation(
      {this.type,
      this.details,
      this.price,
      this.instagram,
      this.facebook,
      this.website,
      this.locationURL});

  ModelAccommandation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    details = json['details']?.cast<String>();
    price = json['price'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    website = json['website'];
    locationURL = json['locationURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['details'] = details;
    data['price'] = price;
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['website'] = website;
    data['locationURL'] = locationURL;
    return data;
  }
}
