class ModelCountry {
  String? name;
  String? dialCode;
  String? code;
  String? flag;

  ModelCountry({this.name, this.dialCode, this.code, this.flag});

  ModelCountry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dialCode = json['dial_code'];
    code = json['code'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['dial_code'] = dialCode;
    data['code'] = code;
    data['flag'] = flag;
    return data;
  }
}
