part of 'new_post_page_view.dart';

class _PhotosView extends StatefulWidget {
  const _PhotosView(
      {Key? key, required this.onPhotoAdd, required this.onPhotoDelete})
      : super(key: key);

  final Function(Uint8List) onPhotoAdd;
  final Function(int) onPhotoDelete;

  @override
  State<_PhotosView> createState() => __PhotosViewState();
}

class __PhotosViewState extends State<_PhotosView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  List<Uint8List> photos = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bigText(context, "Photos"),
        if (_tabController != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  photos.removeAt(_tabController!.index);
                  _handleTabControllerLength();

                  setState(() {});
                  widget.onPhotoDelete.call(_tabController!.index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              TabPageSelector(
                controller: _tabController,
              ),
            ],
          ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        if (_tabController != null)
          SizedBox(
            width: double.maxFinite,
            height: context.dynamicHeight(0.3),
            child: PageView.builder(
              itemCount: photos.length,
              onPageChanged: (val) {
                _tabController?.animateTo(val);
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: _image(
                  photos[index],
                ),
              ),
            ),
          ),
        CustomButton.outlined(
          text: "Add Photo",
          onTap: _handleAddPhoto,
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

  ClipRRect _image(Uint8List bytes) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(cRadius),
      ),
      child: Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: double.maxFinite,
        height: context.dynamicHeight(0.3),
      ),
    );
  }

  void _handleAddPhoto() async {
    if (photos.length == 4) {
      SimpleUIs().showSnackBar(context, "Max 4 Photos!");
      return;
    }

    Uint8List? image = await Funcs().getImage(context,false,1080,1080);

    if (image == null) return;

    _handleTabControllerLength();

    setState(() {
      photos.add(image);
    });
    widget.onPhotoAdd.call(image);
  }

  void _handleTabControllerLength() {
    _tabController?.dispose();
    _tabController = TabController(length: photos.length + 1, vsync: this);
  }
}
