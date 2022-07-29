import 'package:experiences/library/pages/follows_page/follows_page_view.dart';
import 'package:experiences/library/pages/home_page/home_page_view.dart';
import 'package:experiences/library/pages/search_page/search_page_view.dart';
import 'package:experiences/library/pages/user_page/user_page_view.dart';
import 'package:flutter/material.dart';

class MainPagePageView extends StatefulWidget {
  const MainPagePageView({Key? key, required this.selectedPage})
      : super(key: key);

  final int selectedPage;

  @override
  State<MainPagePageView> createState() => _MainPagePageViewState();
}

class _MainPagePageViewState extends State<MainPagePageView> {
  PageController pageController = PageController();

  @override
  void didUpdateWidget(covariant MainPagePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedPage == widget.selectedPage) return;

    pageController.jumpToPage(widget.selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        HomePageView(),
        FollowsPageView(),
        SearchPageView(),
        UserPageView(),
      ],
    );
  }
}
