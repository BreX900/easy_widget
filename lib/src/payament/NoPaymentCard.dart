import 'package:flutter/material.dart';


class NoPaymentCard extends StatelessWidget {

  const NoPaymentCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Nessuna carta inserita", style: tt.subtitle,),
          Text("Aggiungi una carta", style: tt.subtitle,),
        ],
      ),
    );
  }
}