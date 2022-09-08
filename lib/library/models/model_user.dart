class ModelUser {
  String? fullName;
  String? username;
  String? id;
  String? createdDate;
  String? photoURL;
  List<String>? postIds;

  ModelUser({
    this.fullName,
    this.username,
    this.id,
    this.createdDate,
    this.photoURL,
    this.postIds = const [],
  });

  ModelUser.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    username = json['username'];
    id = json['id'];
    createdDate = json['createdDate'];
    photoURL = json['photoURL'];
    postIds = json['postIds']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['username'] = username;
    data['id'] = id;
    data['createdDate'] = createdDate;
    data['photoURL'] = photoURL;
    data['postIds'] = postIds;
    return data;
  }
}
