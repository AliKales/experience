import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../providers/bottom_navbar_provider.dart';

class CNavigationBar extends StatefulWidget {
  const CNavigationBar({super.key, required this.selectedPage});

  final int selectedPage;

  @override
  State<CNavigationBar> createState() => _CNavigationBarState();
}

class _CNavigationBarState extends State<CNavigationBar> {
  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 4;
    return Container(
      color: cPrimaryColor,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: Colors.grey,
                width: (widget.selectedPage * itemWidth),
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: cSecondoryColor,
                  borderRadius: context.lowBorderRadius,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 3,
                width: itemWidth,
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: List.generate(
                4,
                (index) => _item(index, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _item(int index, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => _onTap(index, context),
        child: SizedBox(
          height: context.dynamicHeight(0.1),
          child: Icon(
            _getIcon(index),
            size: 30,
          ),
        ),
      ),
    );
  }

  IconData? _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_filled;
      case 1:
        return Icons.search;
      case 2:
        return Icons.add_box_outlined;
      case 3:
        return Icons.account_circle;
      default:
        Icons.home_filled;
    }
    return null;
  }

  void _onTap(int index, context) {
    Provider.of<BottomNavigationBarProvider>(context, listen: false)
        .changePage(index);
  }
}
