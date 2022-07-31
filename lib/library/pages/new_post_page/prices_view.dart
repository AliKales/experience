part of 'new_post_page_view.dart';

class _PricesView extends StatefulWidget {
  const _PricesView({Key? key, required this.onChanged}) : super(key: key);

  final Function(List<ModelPrice>) onChanged;

  @override
  State<_PricesView> createState() => __PricesViewState();
}

class __PricesViewState extends State<_PricesView> {
  double? price;
  String? label;
  String? description;

  List<ModelPrice> prices = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: prices.length,
          itemBuilder: (context, index) {
            return _priceWidget(context, prices[index]);
          },
        ),
        CustomTextField.outlined(
          labelText: "Label (Food&Drink)",
          onChanged: (String val) {},
        ),
        CustomTextField.outlined(
          labelText: "Description (Daily)",
          onChanged: (String val) {},
        ),
        CustomTextField.outlined(
          labelText: "Price (\$13.40)",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (String value) {
            price = double.tryParse(value);
          },
        ),
        CustomButton(text: "Add", onTap: _handleAdd),
        Align(
          alignment: Alignment.centerRight,
          child: smallText(
            context,
            _calculatePrice(),
          ),
        ),
      ],
    );
  }

  String _calculatePrice() {
    double money = 0;
    for (var element in prices) {
      if (element.price != null) {
        money += element.price!;
      }
    }
    return "= ${Funcs().formatMoney(money)}";
  }

  Widget _priceWidget(BuildContext context, ModelPrice modelPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: smallText(context, modelPrice.label ?? "")),
            smallText(context, Funcs().formatMoney(modelPrice.price ?? 0)),
          ],
        ),
        smallerText(context, "(${modelPrice.description})"),
      ],
    );
  }

  Text smallText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text smallerText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.subtitle1!.copyWith(),
    );
  }

  void _handleAdd() {
    if (label == null || label?.trim() == "") return;
    if (price == null) return;

    setState(() {
      prices.add(
        ModelPrice(label: label, price: price, description: description),
      );
    });
  }
}
