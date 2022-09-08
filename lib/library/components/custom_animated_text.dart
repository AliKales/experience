import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomAnimatedKit extends StatefulWidget {
  const CustomAnimatedKit(
      {Key? key, this.repeatForever = true, this.values = const []})
      : super(key: key);

  final bool repeatForever;
  final List<String> values;

  @override
  State<CustomAnimatedKit> createState() => _CustomAnimatedKitState();
}

class _CustomAnimatedKitState extends State<CustomAnimatedKit> {
  final GlobalKey key = GlobalKey();

  Duration duration = const Duration(milliseconds: 1000);

  double? height;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(afterBuild);
  }

  afterBuild(timeStamp) {
    setState(() {
      height = key.currentContext?.size?.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      height: height,
      child: AnimatedTextKit(
        pause: duration,
        repeatForever: widget.repeatForever,
        animatedTexts: List.generate(
          widget.values.length,
          (index) => _item(context, index),
        ),
      ),
    );
  }

  RotateAnimatedText _item(BuildContext context, int index) {
    return RotateAnimatedText(
      widget.values[index],
      textStyle: _animatedTextStyle(context),
    );
  }

  _animatedTextStyle(context) {
    return Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(fontFamily: "Taviraj");
  }
}
