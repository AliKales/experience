part of 'new_post_page_view.dart';

mixin _Mixin<T extends StatefulWidget> on State<T> {
  countryPicker() {
    SimpleUIs.showDropdownButton(
        context: context,
        list: ['a','b','c'],
        onChanged: (val){},
        dropdownValue: "a");
  }
}
