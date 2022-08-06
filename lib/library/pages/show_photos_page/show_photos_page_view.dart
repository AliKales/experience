import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowPhotosPageView extends StatelessWidget {
  const ShowPhotosPageView({Key? key, this.photosUrl, this.photosMemory})
      : super(key: key);

  final List<String>? photosUrl;
  final List<Uint8List>? photosMemory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          height: context.height,
          child: PhotoViewGallery.builder(
            itemCount: getLength,
            builder: (_, index) {
              return _image(index);
            },
          ),
        ),
      ),
    );
  }

  _image(int index) {
    if (photosMemory.isNullOrEmpty && photosUrl.isNullOrEmpty) {
      return const SizedBox.shrink();
    }
    if (photosMemory.isNotNullOrEmpty) {
      return PhotoViewGalleryPageOptions(
          minScale: 0.45, imageProvider: MemoryImage(photosMemory![index]));
    }
    return PhotoViewGalleryPageOptions(
        minScale: 0.45,
        imageProvider: CachedNetworkImageProvider(photosUrl![index]));
  }

  int get getLength => photosUrl?.length ?? photosMemory?.length ?? 0;
}
