part of 'new_post_page_view.dart';

class _PhotosView extends StatefulWidget {
  const _PhotosView({Key? key}) : super(key: key);

  @override
  State<_PhotosView> createState() => __PhotosViewState();
}

class __PhotosViewState extends State<_PhotosView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bigText(context, "Photos"),
        Align(
          alignment: Alignment.centerRight,
          child: TabPageSelector(
            selectedColor: cTextColor,
            controller: _tabController,
          ),
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        SizedBox(
          width: double.maxFinite,
          height: context.dynamicHeight(0.3),
          child: PageView.builder(
            itemCount: 3,
            onPageChanged: (val) {
              _tabController.animateTo(val);
            },
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _image(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget bigText(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: context.textTheme.headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
      ],
    );
  }

  ClipRRect _image(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(cRadius),
      ),
      child: Image.asset(
        "assets/images/walk.jpg",
        fit: BoxFit.cover,
        width: double.maxFinite,
        height: context.dynamicHeight(0.3),
      ),
    );
  }
}
