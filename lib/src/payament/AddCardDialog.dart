import 'package:flutter/material.dart';


class AddCardDialog extends StatelessWidget {
  final Widget number, secretNumber;

  const AddCardDialog({Key key, this.number, this.secretNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Aggiungi una carta"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          number,
          Row(
            children: <Widget>[
              secretNumber,
            ],
          ),
        ],
      ),
    );
  }
}
