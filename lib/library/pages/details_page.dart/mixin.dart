part of 'details_page_view.dart';

mixin _Mixin {
  List<String> uploadedPhotos = [];
  List<int> notUploadedPhotos = [];

  late String path;
  late ModelItemExperience itemExperience;

  void init(
    ModelItemExperience i,
  ) {
    path = Funcs().getIdByTime();
    itemExperience = i;
  }

  void _handleShare(BuildContext context, List<Uint8List> photos) async {
    SimpleUIs().showProgressIndicator(context);

    for (var i = 0; i < photos.length; i++) {
      Uint8List element = photos[i];

      String? pathImage = await StorageFirebase.uploadExperienceImage(
          context: context, data: element, path: path);

      if (pathImage != null) {
        uploadedPhotos.add(pathImage);
      } else {
        notUploadedPhotos.add(i);
      }
    }

    itemExperience.photos = List.generate(
      uploadedPhotos.length,
      (index) => uploadedPhotos[index],
    ).toList();

    itemExperience.id = path;

    itemExperience.createdDate = Funcs().getGMTDateTimeNow().toIso8601String();

    await FirestoreFirebase.addExperienceToUser(
        context: context, elements: [path]);

    await FirestoreFirebase.shareExperience(
        context: context, experience: itemExperience, path: path);

    Navigator.pop(context);
    Navigator.pop(context);

    SimpleUIs().showSnackBar(context, "Done!");
  }

  void _handleTextClick(context, String url) {
    Funcs().launchLink(url, context, true);
  }
}
