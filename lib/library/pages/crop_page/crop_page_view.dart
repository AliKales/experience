import 'dart:typed_data';

import 'package:experiences/library/componets/custom_appbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CropPageView extends StatefulWidget {
  const CropPageView({Key? key, required this.bytes, this.isProfilePic})
      : super(key: key);

  final Uint8List bytes;
  final bool? isProfilePic;

  @override
  State<CropPageView> createState() => _CropPageViewState();
}

class _CropPageViewState extends State<CropPageView> {
  GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Crop",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, editorKey.currentState!.rawImageData);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          children: [
            _widgetBottomIcon(() => onTap(0), Icons.refresh, "Resert"),
            _widgetBottomIcon(() => onTap(1), Icons.flip, "Flip"),
            _widgetBottomIcon(() => onTap(2), Icons.rotate_left, "Rotate L"),
            _widgetBottomIcon(() => onTap(3), Icons.rotate_right, "Rotate R"),
          ],
        ),
      ),
      body: ExtendedImage.memory(
        widget.bytes,
        cacheRawData: true,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editorKey,
        initEditorConfigHandler: (state) {
          return EditorConfig(
            cropRectPadding: const EdgeInsets.all(20.0),
            cropAspectRatio:
                widget.isProfilePic ?? false ? CropAspectRatios.ratio1_1 : null,
          );
        },
      ),
    );
  }

  Widget _widgetBottomIcon(
      VoidCallback onTap, IconData iconData, String label) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  void onTap(int value) {
    if (value == 0) editorKey.currentState!.reset();
    if (value == 1) editorKey.currentState!.flip();
    if (value == 2) editorKey.currentState!.rotate(right: false);
    if (value == 3) editorKey.currentState!.rotate(right: true);
  }
}
