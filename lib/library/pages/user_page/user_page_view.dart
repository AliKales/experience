import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:experiences/library/components/custom_appbar.dart';
import 'package:experiences/library/components/custom_button.dart';
import 'package:experiences/library/components/last_widget.dart';
import 'package:experiences/library/components/no_exit_page.dart';
import 'package:experiences/library/components/widget_disable_scroll_glow.dart';
import 'package:experiences/library/components/widget_item_experience.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/pages/details_page.dart/details_page_view.dart';
import 'package:experiences/library/providers/item_experiences_provider.dart';
import 'package:experiences/library/providers/user_page_provider.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../funcs.dart';
import '../../services/firebase/storage_firebase.dart';
import '../loading_page/loading_page_view.dart';

part 'mixin.dart';

class UserPageView extends StatefulWidget {
  const UserPageView({Key? key, this.userId, this.user}) : super(key: key);

  final String? userId;
  final ModelUser? user;

  @override
  State<UserPageView> createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView>
    with _Mixin, AutomaticKeepAliveClientMixin<UserPageView> {
  _UserPageStatus _userPageStatus =
      _UserPageStatus(serviceStatus: ServiceStatus.loading);

  final _numberOfItemsFromDb = 5;
  final _textAppBar = "User";
  final _buttonTextWhenNoUser = "LOG IN";
  var textExpereinces = "Experiences";
  var textWhenNoExperience = "No Experience Yet";

  @override
  void initState() {
    super.initState();

    _handleUserInfos();
  }

  void _handleUserInfos() {
    getUserInfos(widget.userId, widget.user).then((value) {
      setState(() {
        _userPageStatus = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return NoExitPage(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIcon: Icons.account_circle,
          text: _textAppBar,
          actions: [
            if (!_isUserSent())
              IconButton(
                onPressed: _handleIconButtonMoreVert,
                icon: const Icon(Icons.more_vert_outlined),
              ),
          ],
        ),
        body: _userPageStatus.serviceStatus == ServiceStatus.empty
            ? _isUserSent()
                ? const SizedBox.shrink()
                : Padding(
                    padding: context.paddingNormal,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                            text: _buttonTextWhenNoUser,
                            onTap: () {
                              Funcs().navigatorPushReplacement(
                                context,
                                const LoadingPageView(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
            : _userPageStatus.serviceStatus == ServiceStatus.loading
                ? SimpleUIs.progressIndicator()
                : _mainBody(context),
      ),
    );
  }

  void _handleIconButtonMoreVert() {
    if (_userPageStatus.serviceStatus == ServiceStatus.done) {
      _showModalBottomSheet(
        (value) {
          if (value == 0) _changeProfilePic();
        },
      );
    }
  }

  Padding _mainBody(BuildContext context) {
    return Padding(
              padding: context.paddingNormal,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _photoNameUsername(context),
          SimpleUIs().divider(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textExpereinces,
                style: context.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                _userPageStatus.modelUser?.postIds?.length.toString() ?? "0",
                style: context.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          _howManyItems == 0
              ? Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      Center(
                        child: Text(
                          textWhenNoExperience,
                          style: context.textTheme.headline6!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              : Expanded(
                  child: WidgetDisableScrollGlow(
                    child: ListView.builder(
                      itemCount: _howManyItems,
                      itemBuilder: (context, index) {
                        if (index == _length - 1 &&
                            _length > _numberOfItemsFromDb) {
                          LastWidget(
                              onShown: _handleOnshown,
                              child: _itemExperienceWidget(index, context));
                        }
                        return _itemExperienceWidget(index, context);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  WidgetItemExperience _itemExperienceWidget(int index, BuildContext context) {
    return WidgetItemExperience(
      isStarShown: _isUserSent(),
      item: _userPageStatus.items![index],
      onTap: () async {
        await context.navigateToPage(
          DetailsPageView(
            item: _userPageStatus.items![index],
            letGoUserPage: false,
          ),
        );

        //here we refresh in case of user adding it to favorites
        setState(() {});
      },
    );
  }

  int get _length => _userPageStatus.items?.length ?? 0;

  int get _howManyItems => _userPageStatus.items?.length ?? 0;

  Row _photoNameUsername(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          height: context.dynamicWidth(0.2),
          width: context.dynamicWidth(0.2),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          imageUrl: _userPageStatus.modelUser?.photoURL ?? "",
          errorWidget: (_, __, ___) => _errorWidget(),
        ),
        SizedBox(width: context.dynamicWidth(0.03)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _userPageStatus.modelUser?.fullName ?? "",
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: context.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                _userPageStatus.modelUser?.username ?? "",
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: context.textTheme.headline6!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        if (!_isUserSent())
          IconButton(
            onPressed: () => _logOut(context),
            icon: const Icon(Icons.logout_outlined, color: Colors.red),
          ),
      ],
    );
  }

  Widget _errorWidget() {
    if (_isUserSent()) {
      return Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: cPrimaryColor),
      );
    }
    return InkWell(
      onTap: _changeProfilePic,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: cPrimaryColor,
        ),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> _changeProfilePic() async {
    SimpleUIs().showProgressIndicator(context);
    String? url = await setProfilePicture();
    Navigator.pop(context);
    if (url != null) {
      setState(() {
        _userPageStatus.modelUser!.photoURL = url;
      });
    }
  }

  bool _isUserSent() => widget.userId != null || widget.user != null;

  void _handleOnshown() async {
    int howManyItemsLoaded = _userPageStatus.items?.length ?? 0;

    List<String> postIds = _userPageStatus.modelUser?.postIds ?? [];

    if (howManyItemsLoaded + 5 >= postIds.length) {
      postIds = postIds.sublist(howManyItemsLoaded, howManyItemsLoaded + 5);
    } else {
      postIds = postIds.sublist(howManyItemsLoaded);
    }

    List<ModelItemExperience> list = _userPageStatus.items ?? [];
    list += await loadMore(postIds);

    _userPageStatus.items = list;

    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
