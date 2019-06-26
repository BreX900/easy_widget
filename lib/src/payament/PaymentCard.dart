import 'package:flutter/material.dart';


enum BrandOfPaymentCard {
  American_Express, Diners_Club, Discover, JCB, Mastercard,
  UnionPay, /// TODO: AGGIUNGERE IMMAGINE
  Visa, Unknown
}


const STRING_OF_PAYMENT_CARD = <BrandOfPaymentCard, String> {
  BrandOfPaymentCard.American_Express: "American Express",
  BrandOfPaymentCard.Diners_Club: "Diners Club",
  BrandOfPaymentCard.Discover: "Discover",
  BrandOfPaymentCard.JCB: "JCB",
  BrandOfPaymentCard.Mastercard: "Mastercard",
  BrandOfPaymentCard.UnionPay: "UnionPay",
  BrandOfPaymentCard.Visa: "Visa",
  BrandOfPaymentCard.Unknown: "Unknown",
}, PAYMENT_CARD_OF_STRING = <String, BrandOfPaymentCard> {
  "American Express": BrandOfPaymentCard.American_Express,
  "Diners Club": BrandOfPaymentCard.Diners_Club,
  "Discover": BrandOfPaymentCard.Discover,
  "JCB": BrandOfPaymentCard.JCB,
  "Mastercard": BrandOfPaymentCard.Mastercard,
  "UnionPay": BrandOfPaymentCard.UnionPay,
  "Visa": BrandOfPaymentCard.Visa,
  "Unknown": BrandOfPaymentCard.Unknown,
};


class PaymentCard extends StatelessWidget {
  final String imgsPath;
  final BrandOfPaymentCard type;
  final String last4;

  const PaymentCard({Key key,
    @required this.imgsPath, @required this.type, @required this.last4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    final title = STRING_OF_PAYMENT_CARD[type];

    return Row(
      children: <Widget>[
        Image.asset('$imgsPath$title.png', width: 64,),
        SizedBox(width: 16.0,),
        Text(title, style: tt.subtitle,),
        SizedBox(width: 8.0,),
        Text('XXXX XXXX XXXX $last4'),
      ],
    );
  }
}
