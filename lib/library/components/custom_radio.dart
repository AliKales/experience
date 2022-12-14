import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key, required this.onChanged}) : super(key: key);
  final Function(int) onChanged;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  int _value = 0;

  List<String> recommendations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recommendations = Recommendations.getAsList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 1; i <= recommendations.length; i++)
          ListTile(
            title: Text(recommendations[i - 1].toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1!),
            leading: Radio(
              value: i,
              groupValue: _value,
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                return cPrimaryColor;
              }),
              onChanged: (int? value) {
                if (value == null) return;
                setState(() {
                  _value = value;
                });
                widget.onChanged.call(_value);
              },
            ),
          ),
      ],
    );
  }
}
