class ModelStay {
  String? type;
  List<String>? include;
  String? instagram;
  String? facebook;
  String? website;
  String? latlng;
  double? lat;
  double? lng;
  double? price;

  ModelStay(
      {this.type,
      this.include,
      this.instagram,
      this.facebook,
      this.website,
      this.latlng,
      this.lat,
      this.lng,
      this.price});

  ModelStay.fromJson(Map<String, dynamic>? json) {
    type = json?['type'];
    include = json?['include']?.cast<String>();
    instagram = json?['instagram'];
    facebook = json?['facebook'];
    website = json?['website'];
    latlng = json?['latlng'];
    lat = json?['lat'];
    lng = json?['lng'];
    price = json?['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['include'] = this.include;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['website'] = this.website;
    data['latlng'] = this.latlng;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['price'] = this.price;
    return data;
  }
}
