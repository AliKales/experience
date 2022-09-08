import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../values.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.labelText,
      this.tEC,
      this.isOutlined = false,
      this.readOnly = false,
      this.suffixIcon,
      this.onTap,
      this.onChanged,
      this.keyboardType})
      : super(key: key);
  const CustomTextField.outlined(
      {Key? key,
      this.labelText,
      this.tEC,
      this.isOutlined = true,
      this.readOnly = false,
      this.suffixIcon,
      this.onTap,
      this.onChanged,
      this.keyboardType})
      : super(key: key);

  final String? labelText;
  final TextEditingController? tEC;
  final bool? isOutlined;
  final bool? readOnly;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChanged,
        readOnly: readOnly!,
        controller: tEC,
        style: _textfieldTextStyle(context),
        // cursorColor: isOutlined! ? cTextColor : cSecondryColor,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: _outlineInputBorder(),
          focusedBorder: _outlineInputBorder(),
          border: _outlineInputBorder(),
          labelText: labelText,
          labelStyle: _textStyleSecondText(),
          floatingLabelStyle: _textStyleSecondText(),
          filled: true,
          fillColor: isOutlined! ? Colors.transparent : null,
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      // borderRadius: BorderRadius.circular(15.0),
      borderSide:
          isOutlined! ? const BorderSide() : BorderSide.none,
    );
  }

  TextStyle _textStyleSecondText() {
    return const TextStyle(
      height: 4,
    );
  }

  TextStyle _textfieldTextStyle(BuildContext context) {
    return context.textTheme.headline6!;
  }
}
