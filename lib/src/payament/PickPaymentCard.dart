import 'package:flutter/material.dart';

class PickPaymentCardDialog extends StatelessWidget {
  final VoidCallback onAddPaymentCard;
  final Widget listPaymentCards;

  const PickPaymentCardDialog({
    Key key,
    @required this.onAddPaymentCard,
    @required this.listPaymentCards,
  }) : super(key: key);

  void _onCancelButton(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: AspectRatio(
        aspectRatio: 1,
        child: listPaymentCards,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => _onCancelButton(context),
          child: Text("Anulla"),
        ),
        FlatButton(
          onPressed: onAddPaymentCard,
          child: Text("Crea Nuova Carta"),
        ),
      ],
    );
  }
}
