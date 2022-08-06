part of 'search_page_view.dart';

mixin _Mixin on State<SearchPageView> {
  CancelableOperation<void>? _cancelableOperation;

  Future<List<ModelUser>> search(String key) async {
    _cancelableOperation?.cancel();

    _cancelableOperation =
        CancelableOperation.fromFuture(Future.delayed(cSearchDelay));

    List<ModelUser> items = [];

    await _cancelableOperation?.value.then((value) async {
      items = await FirestoreFirebase.fetchUsersByUsername(
          context: context, username: "d");
    });

    return items;
  }

  _handleOnChanded(String val) async {
    List<ModelUser> result = [];
    if (val != "") result = await search(val);
    return result;
  }
}
