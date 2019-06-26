import 'package:easy_widget/easy_widget.dart';
import 'package:easy_widget/src/payament/NoPaymentCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PaymentCardsScreen extends StatelessWidget {
  final Stream<List<Widget>> outCards;
  final VoidCallback onAddPaymentCard;
  final Widget title, subTitle;

  const PaymentCardsScreen({Key key,
    @required this.outCards,
    this.title: const Text("Portafoglio"), this.subTitle,
    this.onAddPaymentCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: subTitle??Text("Le tue carte", style: tt.headline,),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: StreamBuilder<List<Widget>>(
              stream: outCards,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const SliverToBoxAdapter(
                    child: const CircularProgressIndicator(),
                  );
                final cards = snapshot.data;
                if (cards.length < 1)
                  return SliverToBoxAdapter(
                    child: InkWell(
                      onTap: onAddPaymentCard,
                      child: const NoPaymentCard(),
                    ),
                  );

                return SliverList(
                  delegate: SliverListSeparatorDelegate.childrenBuilder(
                    startWithDivider: true,
                    separator: const Divider(height: 24.0,),
                    builder: (_, index) => cards[index],
                    childCount: cards.length,
                  ),
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPaymentCard,
        child: const Icon(Icons.add),
      ),
    );
  }
}
