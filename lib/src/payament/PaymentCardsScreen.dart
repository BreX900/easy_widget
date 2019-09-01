import 'package:easy_widget/easy_widget.dart';
import 'package:easy_widget/src/payament/NoPaymentCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentCardsScreen extends StatelessWidget {
  final VoidCallback onAddPaymentCard;
  final Widget title, subTitle, listPaymentCards;

  const PaymentCardsScreen({
    Key key,
    this.onAddPaymentCard,
    this.title: const Text("Portafoglio"),
    this.subTitle: const Text("Le tue carte"),
    @required this.listPaymentCards,
  })  : assert(title != null),
        assert(subTitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: tt.headline,
              child: subTitle,
            ),
          ),
          listPaymentCards,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPaymentCard,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListPaymentCards extends StatelessWidget {
  final int childCount;
  final VoidCallback onAddPaymentCard;
  final IndexedWidgetBuilder builder;

  const ListPaymentCards({
    Key key,
    @required this.childCount,
    this.onAddPaymentCard,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (childCount == null) return const CircularProgressIndicator();

    if (childCount < 1) return InkWell(onTap: onAddPaymentCard, child: const NoPaymentCard());

    return Expanded(
      child: ListView.custom(
        padding: const EdgeInsets.all(16.0),
        childrenDelegate: SliverLayoutDelegate.childrenBuilder(
          childCount: childCount,
          surround: true,
          separator: const Divider(),
          builder: builder,
        ),
      ),
    );
  }
}
