import 'package:experiences/library/componets/custom_textfield.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SimpleUIs {
  Widget divider(BuildContext context) {
    return Column(children: [
      SizedBox(height: context.dynamicHeight(0.02)),
      const Divider(),
      SizedBox(height: context.dynamicHeight(0.02)),
    ]);
  }

  void showSnackBar(context, String text) {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            text,
            style: const TextStyle(color: cTextColor),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cRadius),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 20, 20)),
    );
  }

  Future showProgressIndicator(context) async {
    FocusScope.of(context).unfocus();
    if (ModalRoute.of(context)?.isCurrent ?? true) {
      await showGeneralDialog(
          barrierLabel: "Barrier",
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 500),
          context: context,
          pageBuilder: (_, __, ___) {
            return WillPopScope(
              onWillPop: () async => false,
              child: progressIndicator(),
            );
          });
    }
  }

  static Widget progressIndicator() {
    return const Center(child: CircularProgressIndicator.adaptive());
  }

  static void showCustomModalBottomSheet({
    required context,
    required Widget child,
  }) {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: cBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(cRadius))),
      builder: (_) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            builder: (context, controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 173, 173, 173),
                        borderRadius: BorderRadius.all(
                          Radius.circular(cRadius),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: child,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Widget showDropdownButton({
    required context,
    required List<String> list,
    required Function(Object?) onChanged,
    required var dropdownValue,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton(
          dropdownColor: cBackgroundColor,
          value: dropdownValue,
          hint: const CustomTextField.outlined(labelText: "Search"),
          items: List.generate(list.length,
              (index) => _widgetDropDownMenuItem(value: list[index])),
          onChanged: (value) {
            setState(() {
              dropdownValue = value;
            });
            onChanged.call(value);
          },
        );
      },
    );
  }

  static DropdownMenuItem<String> _widgetDropDownMenuItem(
      {required String value}) {
    return DropdownMenuItem(
      value: value,
      child: Text(value.toUpperCase()),
    );
  }
}
