part of 'user_page_view.dart';

class _UserPageStatus {
  ModelUser? modelUser;
  ServiceStatus? serviceStatus;
  List<ModelItemExperience>? items;

  _UserPageStatus({this.serviceStatus, this.modelUser, this.items});
}

mixin _Mixin<T extends StatefulWidget> on State<T> {
  Future<_UserPageStatus> getUserInfos() async {
    await Future.delayed(const Duration(seconds: 1));

    var resultUser = await FirestoreFirebase.getUser(
        context: context, id: AuthFirebase().getUid);

    if (resultUser == null) {
      return _UserPageStatus(serviceStatus: ServiceStatus.empty);
    }

    List<ModelItemExperience> items =
        await FirestoreFirebase.getItemsExperiencesForProfile(
                resultUser.postIds?.reversed.toList().sublist(0, 5) ?? []) ??
            [];

    return _UserPageStatus(
        serviceStatus: ServiceStatus.done, modelUser: resultUser, items: items);
  }

  void _showModalBottomSheet(Function(int) onClicked) {
    SimpleUIs.showCustomModalBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                onClicked.call(0);
              },
              child: Row(
                children: [
                  const Icon(Icons.photo_camera),
                  SizedBox(width: context.dynamicWidth(0.02)),
                  Text("Change Profile Picture",
                      style: context.textTheme.headline6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logOut(context) async {
    await AuthFirebase().logOut(context);
    Funcs().navigatorPushReplacement(context, const LoadingPageView());
  }

  Future<String?> setProfilePicture() async {
    var data = await Funcs().getImage(context);
    if (data == null) return null;

    var link =
        await StorageFirebase.uploadProfilePhoto(context: context, data: data);
    if (link == null) return null;

    var result =
        await FirestoreFirebase.setProfilePicture(context: context, url: link);
    if (!result) return null;

    return link;
  }
}
