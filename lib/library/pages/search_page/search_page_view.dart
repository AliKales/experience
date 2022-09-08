import 'package:async/async.dart';
import 'package:experiences/library/components/custom_textfield.dart';
import 'package:experiences/library/components/no_exit_page.dart';
import 'package:experiences/library/components/widget_disable_scroll_glow.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/pages/user_page/user_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../components/custom_appbar.dart';
import 'componets/widget_user_search.dart';

part 'mixin.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> with _Mixin {
  List<ModelUser> searchUsers = [];

  bool isSearching = false;

  final _textAppBar = "Search";
  final _textTextField = "Search";

  @override
  Widget build(BuildContext context) {
    return NoExitPage(
      child: Scaffold(
        appBar: CustomAppBar(text: _textAppBar, leadingIcon: Icons.search),
        body: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              CustomTextField(
                labelText: _textTextField,
                onChanged: _handleOnChanged,
              ),
              if (isSearching)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SimpleUIs.progressIndicator(),
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
      ),
    );
  }

  void _handleOnChanged(val) async {
    if (val.trim() != "") {
      setState(() {
        isSearching = true;
      });
    }
    searchUsers = await _handleOnChanded(val.trim());
    setState(() {
      isSearching = false;
    });
  }
}
