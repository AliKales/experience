import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  const WidgetImage({
    Key? key,
    this.boxFit,
  }) : super(key: key);

  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        child: Image.asset("assets/images/Rectangle 1.jpg",
            width: double.maxFinite, fit: boxFit ?? BoxFit.fill),
      ),
    );
  }
}
