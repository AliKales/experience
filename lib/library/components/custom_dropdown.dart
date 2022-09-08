import 'package:experiences/library/components/custom_textfield.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomDropDown extends StatefulWidget {
  final String hintText;
  final List<String>? items;
  final String? selectedItem;
  final Function(String)? onChanged;

  const CustomDropDown({
    Key? key,
    this.hintText = 'Select an option',
    this.items,
    this.selectedItem,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState<T> extends State<CustomDropDown> {
  List items = [];
  String selectedItem = "";
  final TextEditingController _tEC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = widget.selectedItem ?? "";

    _tEC.text = selectedItem;

    items = widget.items ?? [];
    items.insert(0, "Country");
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField.outlined(
      tEC: _tEC,
      labelText: widget.hintText,
      readOnly: true,
      onTap: () async {
        String? result = await showBottomWidget();
        if (result == null) return;
        selectedItem = result;
        _tEC.text = selectedItem;
        setState(() {});
        widget.onChanged?.call(selectedItem);
      },
      suffixIcon: const Icon(
        Icons.arrow_drop_down,
        size: 30,
      ),
    );
  }

  Future<String?> showBottomWidget() async {
    FocusScope.of(context).unfocus();
    String val = "";
    bool isSelected = false;
    await showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: context.dynamicHeight(0.3),
              decoration: const BoxDecoration(
                color: cPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: context.dynamicHeight(0.03),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey))),
                  ),
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: ListWheelScrollView(
                      itemExtent: context.dynamicHeight(0.04),
                      onSelectedItemChanged: (selectedItem) {
                        val = widget.items?[selectedItem] ?? "";
                      },
                      perspective: 0.005,
                      physics: const FixedExtentScrollPhysics(),
                      children: getChildrenForListWheel(
                        context,
                        widget.items ?? [],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          isSelected = true;
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Done",
                        ),
                      ),
                    ),
                  )
                ],
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
    if (isSelected) {
      return val;
    } else {
      return selectedItem;
    }
  }

  ///* [getChildrenForListWheel] shouldn't be used from anywhere, it's a specific code for [showGeneralDialogFunc]
  List<Widget> getChildrenForListWheel(context, List list) {
    List<Widget> listForWiget = [];
    for (var i = 0; i < list.length; i++) {
      listForWiget.add(Center(
        child: Text(
          list[i].toString(),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ));
    }
    return listForWiget;
  }
}
