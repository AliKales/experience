import 'package:async/async.dart';
import 'package:experiences/library/componets/custom_textfield.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/pages/user_page/user_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../componets/custom_appbar.dart';

part 'mixin.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> with _Mixin {
  List<ModelUser> searchUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Search", leadingIcon: Icons.search),
      body: Padding(
        padding: cPagePadding,
        child: Column(
          children: [
            CustomTextField(
              labelText: "Search",
              onChanged: (val) async {
                searchUsers = await _handleOnChanded(val.trim());
                setState(() {});
              },
            ),
            Expanded(
              child: WidgetDisableScrollGlow(
                child: ListView.builder(
                  itemCount: searchUsers.length,
                  itemBuilder: (context, index) {
                    ModelUser modelUser = searchUsers[index];
                    if (modelUser.id == AuthFirebase().getUid) {
                      return const SizedBox.shrink();
                    }
                    return WidgetUserSearch(
                      user: modelUser,
                      onTap: () {
                        context.navigateToPage(
                          UserPageView(
                            user: modelUser,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetUserSearch extends StatelessWidget {
  const WidgetUserSearch({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  final ModelUser user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double padding = 10;
    const double marginVertical = 10;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(padding),
        margin: const EdgeInsets.symmetric(vertical: marginVertical),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: cSecondryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(cRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName ?? "",
                    style: context.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text("@${user.username}",
                    style: context.textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
