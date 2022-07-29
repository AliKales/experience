import 'package:experiences/library/models/model_item_experience.dart';

void main() {
  var model = {
    "description": "asad",
    "prices": [
      {'label': "name", "price": 12.3}
    ]
  };

  print(ModelItemExperience.fromJson(model).prices);
}
