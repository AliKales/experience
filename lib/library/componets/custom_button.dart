import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';

enum _ButtonType {
  filled,
  outlined,
  text,
}

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.text, this.onTap})
      : _buttonType = _ButtonType.filled,
        super(key: key);
  CustomButton.outlined({Key? key, this.text, this.onTap})
      : _buttonType = _ButtonType.outlined,
        super(key: key);
  CustomButton.text({Key? key, this.text, this.onTap, this.color})
      : _buttonType = _ButtonType.text,
        super(key: key);

  final String? text;
  final VoidCallback? onTap;
  final _ButtonType _buttonType;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _buttonType == _ButtonType.filled ? cButtonColor : null,
          border: _buttonType == _ButtonType.outlined
              ? Border.all(color: cButtonColor, width: 2)
              : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(cRadius),
          ),
        ),
        child: Center(
          child: Text(
            text?.trim().toUpperCase() ?? "",
            style: _buttonTextStyle(context),
          ),
        ),
      ),
    );
  }

  TextStyle _buttonTextStyle(context) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
          color: color ?? cButtonTextColor,
          fontWeight: FontWeight.bold,
        );
  }
}
