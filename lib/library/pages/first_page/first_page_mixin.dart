part of 'first_page_view.dart';

mixin _Mixin on State<FirstPageView> {
  static void onButtonTap(BuildContext context,Widget page) {
    context.navigateToPage(page);
  }
}
