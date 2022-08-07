part of 'user_page_view.dart';

class _UserPageStatus {
  ModelUser? modelUser;
  ServiceStatus? serviceStatus;
  List<ModelItemExperience>? items;

  _UserPageStatus({this.serviceStatus, this.modelUser, this.items});
}

class _ItemToAddLater {
  ModelItemExperience? item;
  int? index;

  _ItemToAddLater(this.item, this.index);
}

mixin _Mixin<T extends StatefulWidget> on State<T> {
  Future<List<ModelItemExperience>> loadMore(List<String> postIds) async {
    return await FirestoreFirebase.getItemsExperiencesForProfile(postIds) ?? [];
  }

  Future<_UserPageStatus> getUserInfos(
      [String? userId, ModelUser? user]) async {
    if (!AuthFirebase().isSignedIn && userId.isNullOrEmpty && user == null) {
      return _UserPageStatus(serviceStatus: ServiceStatus.empty);
    }

    ModelUser? resultUser =
        Provider.of<UserPageProvider>(context, listen: false).getUser;

    if (user == null) {
      resultUser = await Provider.of<UserPageProvider>(context, listen: false)
          .setUserFromDB(context, userId);

      if (resultUser == null) {
        return _UserPageStatus(serviceStatus: ServiceStatus.empty);
      }
    } else {
      resultUser = user;
    }

    List<ModelItemExperience> items = [];

    List<String> postIds = getPostIds(resultUser);

    List<_ItemToAddLater> itemsToAddLater = [];

    //Here we check if we already got ItemExpreiences so we dont send more request to Firebase
    //if we alredy got the ItemExperience we get to from Provider
    for (var i = 0; i < postIds.length; i++) {
      ModelItemExperience? item =
          Provider.of<MotelItemExperienceProvider>(context, listen: false)
              .getModelItemEXperience(postIds[i]);

      if (item != null) {
        itemsToAddLater.add(_ItemToAddLater(item, i));
      }
    }

    for (var i in itemsToAddLater) {
      postIds.removeWhere((element) => element == i.item!.id);
    }

    if (resultUser.postIds.isNotNullOrEmpty) {
      items =
          await FirestoreFirebase.getItemsExperiencesForProfile(postIds) ?? [];
    }

    for (var element in itemsToAddLater) {
      items.insert(element.index!, element.item!);
    }

    print(items);

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
    Provider.of<UserPageProvider>(context).resetUser();
    Funcs().navigatorPushReplacement(context, const LoadingPageView());
  }

  Future<String?> setProfilePicture() async {
    var data = await Funcs().getImage(context, true, 150, 150);
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

List<String> getPostIds(ModelUser resultUser) {
  if (resultUser.postIds == null) return [];

  if (resultUser.postIds!.length >= 5) {
    return resultUser.postIds?.reversed.toList().sublist(0, 5) ?? [];
  } else {
    return resultUser.postIds?.reversed.toList() ?? [];
  }
}
