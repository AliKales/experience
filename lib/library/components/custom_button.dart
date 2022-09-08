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
    if (_buttonType == _ButtonType.outlined) {
      return OutlinedButton(
          onPressed: onTap, child: Center(child: Text(text ?? "")));
    }
    if (_buttonType == _ButtonType.text) {
      return TextButton(onPressed: onTap, child: Text(text ?? ""));
    }
    return ElevatedButton(
      style: const ButtonStyle(
        elevation: null,
      ),
      onPressed: onTap,
      child: Center(child: Text(text ?? "")),
    );
  }
}
