import 'package:experiences/library/componets/custom_appbar.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/pages/details_page.dart/details_page_view.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../componets/widget_item_experience.dart';
import '../../mixers/mixin_items.dart';
import '../../providers/item_experiences_provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with MixinItems, AutomaticKeepAliveClientMixin<HomePageView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<ModelItemExperience> items =
        Provider.of<MotelItemExperienceProvider>(context).homePageItems;
    return Scaffold(
      appBar: const CustomAppBar(text: "Home", leadingIcon: Icons.home_filled),
      body: Padding(
        padding: cPagePadding,
        child: Column(
          children: [
            Expanded(
              child: WidgetDisableScrollGlow(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    return SizedBox.shrink();
                    // return WidgetItemExperience(
                    //   onTap: () =>
                    //       context.navigateToPage(const DetailsPageView()),
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement isHome
  bool get isHome => true;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
