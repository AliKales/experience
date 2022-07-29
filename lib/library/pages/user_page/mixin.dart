part of 'user_page_view.dart';

class _UserPageStatus {
  ModelUser? modelUser;
  ServiceStatus? serviceStatus;
  List<ModelItemExperience>? items;

  _UserPageStatus({this.serviceStatus, this.modelUser, this.items});
}

mixin _Mixin<T extends StatefulWidget> on State<T> {
  Future<_UserPageStatus> getUserInfos() async {
    await Future.delayed(const Duration(seconds: 4));

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

  void _showModalBottomSheet() {
    SimpleUIs.showCustomModalBottomSheet(
      context: context,
      child: Column(
        children: const [],
      ),
    );
  }

  void _logOut(context) async {
    await AuthFirebase().logOut(context);
    Funcs().navigatorPushReplacement(context, const LoadingPageView());
  }
}
