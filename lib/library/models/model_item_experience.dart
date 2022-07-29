import 'package:experiences/library/models/model_item_stay.dart';
import 'package:experiences/library/models/model_price.dart';

class ModelItemExperience {
  String? id;
  String? userId;
  String? createdDate;
  String? title;
  String? description;
  String? city;
  String? country;
  String? countryCode;
  String? latlng;
  double? lat;
  double? lng;
  double? recommendation;
  List<String>? photos;
  ModelStay? modelStay;
  List<ModelPrice>? prices;

  ModelItemExperience({
    this.id,
    this.userId,
    this.createdDate,
    this.title,
    this.description,
    this.city,
    this.country,
    this.countryCode,
    this.latlng,
    this.lat,
    this.lng,
    this.recommendation,
    this.photos,
    this.modelStay,
    this.prices,
  });

  ModelItemExperience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdDate = json['createdDate'];
    title = json['title'];
    description = json['description'];
    city = json['city'];
    country = json['country'];
    countryCode = json['countryCode'];
    latlng = json['latlng'];
    lat = json['lat'];
    lng = json['lng'];
    recommendation = json['recommendation'];
    photos = json['photos']?.cast<String>();
    modelStay = ModelStay.fromJson(json['modelStay']);
    prices = ModelPrice().fromJsonToList(json['prices']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['createdDate'] = createdDate;
    data['title'] = title;
    data['description'] = description;
    data['city'] = city;
    data['country'] = country;
    data['countryCode'] = countryCode;
    data['latlng'] = latlng;
    data['lat'] = lat;
    data['lng'] = lng;
    data['recommendation'] = recommendation;
    data['photos'] = photos;
    data['modelStay'] = modelStay?.toJson();
    data['prices'] = ModelPrice().fromListToJson(prices);
    return data;
  }
}
