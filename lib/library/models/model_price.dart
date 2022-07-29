class ModelPrice {
  String? label;
  String? description;
  double? price;

  ModelPrice({this.label, this.price,this.description});

  List<ModelPrice>? fromJsonToList(List? json) {
    if (json == null) return null;

    List<ModelPrice> items = [];

    for (var element in json) {
      items.add(ModelPrice.fromJson(element));
    }

    return items;
  }

  List<Map<String, dynamic>>? fromListToJson(List<ModelPrice>? prices) {
    if (prices == null) return null;

    return prices.map((e) => e.toJson()).toList();
  }

  ModelPrice.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}
