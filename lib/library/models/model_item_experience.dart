import 'package:experiences/library/models/model_accommandation.dart';
import 'package:experiences/library/models/model_item_stay.dart';
import 'package:experiences/library/models/model_price.dart';

class ModelItemExperience {
  String? id;
  String? userId;
  String? createdDate;
  String? title;
  String? description;
  String? username;
  String? country;
  String? countryCode;
  String? locationURL;
  int? recommendation;
  List<String>? photos;
  ModelStay? modelStay;
  List<ModelPrice>? prices;
  ModelAccommandation? accommandation;

  ModelItemExperience({
    this.id,
    this.userId,
    this.createdDate,
    this.title,
    this.description,
    this.username,
    this.country,
    this.countryCode,
    this.locationURL,
    this.recommendation,
    this.photos,
    this.modelStay,
    this.prices,
    this.accommandation,
  });

  ModelItemExperience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdDate = json['createdDate'];
    title = json['title'];
    description = json['description'];
    username = json['username'];
    country = json['country'];
    countryCode = json['countryCode'];
    locationURL = json['locationURL'];
    recommendation = json['recommendation'];
    photos = json['photos']?.cast<String>();
    modelStay = ModelStay.fromJson(json['modelStay']);
    accommandation = ModelAccommandation.fromJson(json['accommandation']);
    prices = ModelPrice().fromJsonToList(json['prices']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['createdDate'] = createdDate;
    data['title'] = title;
    data['description'] = description;
    data['username'] = username;
    data['country'] = country;
    data['countryCode'] = countryCode;
    data['locationURL'] = locationURL;
    data['recommendation'] = recommendation;
    data['photos'] = photos;
    data['modelStay'] = modelStay?.toJson();
    data['accommandation'] = accommandation?.toJson();
    data['prices'] = ModelPrice().fromListToJson(prices);
    return data;
  }
}
