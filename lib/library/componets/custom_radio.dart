import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key, required this.onChanged}) : super(key: key);
  final Function(int) onChanged;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  int _value = -1;

  List<String> recommendations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recommendations = Recommendations.values.map((e) => e.name).toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i <= recommendations.length - 1; i++)
          ListTile(
            title: Text(
              recommendations[i].toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: cTextColor),
            ),
            leading: Radio(
              value: i,
              groupValue: _value,
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                return cTextColor;
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
