import 'package:experiences/library/componets/custom_button.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PercentIndicator extends StatefulWidget {
  const PercentIndicator({Key? key}) : super(key: key);

  @override
  State<PercentIndicator> createState() => _PercentIndicatorState();
}

class _PercentIndicatorState extends State<PercentIndicator> {
  bool isShown = false;
  int reccomendation = 1;
  int reccomandationCounter = 0;
  int counterToDelete = 4;
  Duration duration = const Duration(milliseconds: 700);

  _show() async {
    setState(() {
      isShown = true;
    });
    await Future.delayed(duration);

    for (var i = 0; i < reccomendation; i++) {
      setState(() {
        reccomandationCounter++;
      });

      await Future.delayed(duration);
    }

    for (var i = 0; i < 3 - reccomendation; i++) {
      setState(() {
        counterToDelete--;
      });
      await Future.delayed(duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = context.dynamicHeight(0.04);

    if (!isShown) {
      return CustomButton.text(
        text: "See",
        onTap: _show,
        color: Colors.blue,
      );
    }
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              AnimatedContainer(
                duration: duration,
                decoration: BoxDecoration(
                  color: _getColor(1),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(cRadius),
                  ),
                ),
                height: height,
              ),
              _text(context, 1, "Low"),
            ],
          ),
        ),
        SizedBox(width: context.dynamicWidth(0.02)),
        Expanded(
          child: Column(
            children: [
              AnimatedContainer(
                duration: duration,
                height: height,
                color: _getColor(2),
              ),
              _text(context, 2, "Medium"),
            ],
          ),
        ),
        SizedBox(width: context.dynamicWidth(0.02)),
        Expanded(
          child: Column(
            children: [
              AnimatedContainer(
                duration: duration,
                height: height,
                decoration: BoxDecoration(
                  color: _getColor(3),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(cRadius),
                  ),
                ),
              ),
              _text(context, 3, "High"),
            ],
          ),
        ),
      ],
    );
  }

  Color _getColor(int index, [bool isText = false]) {
    return counterToDelete <= index
        ? Colors.transparent
        : reccomandationCounter >= index
            ? isText
                ? cTextColor
                : cButtonColor
            : cSecondryColor;
  }

  Text _text(BuildContext context, int index, String text) {
    return Text(
      text,
      style: context.textTheme.headline6!.copyWith(
        color: _getColor(index, true),
      ),
    );
  }
}
