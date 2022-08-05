part of 'new_post_page_view.dart';

class _PricesView extends StatefulWidget {
  const _PricesView({Key? key, required this.onChanged}) : super(key: key);

  final Function(List<ModelPrice>) onChanged;

  @override
  State<_PricesView> createState() => __PricesViewState();
}

class __PricesViewState extends State<_PricesView> {
  List<TextEditingController> tECS =
      List.generate(3, (index) => TextEditingController());

  List<ModelPrice> prices = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: prices.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: _priceWidget(context, prices[index]),
            );
          },
        ),
        CustomTextField.outlined(
          labelText: "Label (Food&Drink)",
          tEC: tECS.first,
        ),
        CustomTextField.outlined(
          labelText: "Description (Daily)",
          tEC: tECS[1],
        ),
        CustomTextField.outlined(
          labelText: "Price (\$13.40)",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          tEC: tECS[2],
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
        Row(
          children: [
            Expanded(
                child: smallerText(context, "(${modelPrice.description})")),
            IconButton(
              onPressed: () {
                prices.remove(modelPrice);
                setState(() {});
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
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
    if (tECS.first.text.trim() == "") return;
    String price = tECS[2].text.trim();
    if (price == "") return;

    if (!RegExp(r'^[0-9\.]+$').hasMatch(price) || price.split(".").length > 2) {
      SimpleUIs().showSnackBar(context, "Wrong price input!");

      return;
    }

    prices.add(
      ModelPrice(
          label: tECS.first.text.trim(),
          price: double.tryParse(tECS[2].text.trim()),
          description: tECS[1].text.trim()),
    );
    setState(() {
      for (var element in tECS) {
        element.clear();
      }
    });

    widget.onChanged.call(prices);
  }
}
