import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../values.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, this.labelText, this.tEC}) : super(key: key);

  final String? labelText;
  final TextEditingController? tEC;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: tEC,
        style: _textfieldTextStyle(context),
        cursorColor: cSecondryColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          labelText: labelText,
          floatingLabelStyle: const TextStyle(
            height: 4,
            color: cSecondryColor,
          ),
          filled: true,
          fillColor: cTextFieldColor,
        ),
      ),
    );
  }

  TextStyle _textfieldTextStyle(BuildContext context) {
    return context.textTheme.headline6!.copyWith(
      color: cSecondryColor,
    );
  }
}
