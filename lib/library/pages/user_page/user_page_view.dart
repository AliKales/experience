import 'package:cached_network_image/cached_network_image.dart';
import 'package:experiences/library/componets/custom_appbar.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/componets/widget_item_experience.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../funcs.dart';
import '../loading_page/loading_page_view.dart';

part 'mixin.dart';

class UserPageView extends StatefulWidget {
  const UserPageView({Key? key}) : super(key: key);

  @override
  State<UserPageView> createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView>
    with _Mixin, AutomaticKeepAliveClientMixin<UserPageView> {
  _UserPageStatus _userPageStatus =
      _UserPageStatus(serviceStatus: ServiceStatus.loading);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfos().then((value) {
      setState(() {
        _userPageStatus = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.account_circle,
        text: "User",
        actions: [
          IconButton(
            onPressed: () {
              if (_userPageStatus.serviceStatus == ServiceStatus.done) {
                _showModalBottomSheet();
              }
            },
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: _userPageStatus.serviceStatus == ServiceStatus.loading
          ? SimpleUIs.progressIndicator()
          : _mainBody(context),
    );
  }

  Padding _mainBody(BuildContext context) {
    return Padding(
      padding: cPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _photoNameUsername(context),
          SimpleUIs().divider(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Experiences",
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
                          "No Experience Yet",
                          style: context.textTheme.headline6!.copyWith(
                              color: cSecondryColor,
                              fontWeight: FontWeight.bold),
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
                        return WidgetItemExperience(
                          isStarShown: false,
                          item: _userPageStatus.items![index],
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

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
          imageUrl: "",
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
        IconButton(
          onPressed: () => _logOut(context),
          icon: const Icon(Icons.logout_outlined, color: Colors.red),
        ),
      ],
    );
  }

  Container _errorWidget() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: cSecondryColor,
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _userPageStatus.modelUser?.username?[0].toUpperCase() ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
