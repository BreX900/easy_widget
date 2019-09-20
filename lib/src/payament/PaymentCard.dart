import 'package:easy_widget/easy_widget.dart';
import 'package:flutter/material.dart';

enum BrandOfPaymentCard {
  amex,
  diners,
  discover,
  jcb,
  mastercard,
  unionpay,

  /// TODO: AGGIUNGERE IMMAGINE
  visa,
}

//    PAYMENT_CARD_OF_STRING = <String, BrandOfPaymentCard>{
//  "American Express": BrandOfPaymentCard.americanExpress,
//  "Diners Club": BrandOfPaymentCard.dinersClub,
//  "Discover": BrandOfPaymentCard.discover,
//  "JCB": BrandOfPaymentCard.JCB,
//  "MasterCard": BrandOfPaymentCard.mastercard,
//  "UnionPay": BrandOfPaymentCard.unionpay,
//  "Visa": BrandOfPaymentCard.visa,
//};

class PaymentCard extends StatelessWidget {
  static const PAINT_SIZE = 64.0;
  static const ASSET_FOLDER = "packages/easy_widget/assets/imgs/payment_card/";

  final String assetFolder;
  final BrandOfPaymentCard type;
  final String last4;
  final bool isDense;

  PaymentCard({
    Key key,
    this.assetFolder: ASSET_FOLDER,
    @required this.type,
    @required this.last4,
    this.isDense: false,
  }) : super(key: key);

  static String getPathImage(String path, String title) {
    return '$path/$title.png';
  }

  static const getTitlePaymentCard = <BrandOfPaymentCard, String>{
    BrandOfPaymentCard.amex: "American Express",
    BrandOfPaymentCard.diners: "Diners Club",
    BrandOfPaymentCard.discover: "Discover",
    BrandOfPaymentCard.jcb: "JCB",
    BrandOfPaymentCard.mastercard: "Mastercard",
    BrandOfPaymentCard.unionpay: "UnionPay",
    BrandOfPaymentCard.visa: "Visa",
  };

//  static Iterable<String> getPathImages(String path) {
//    return PAYMENT_CARD_OF_STRING.keys.map((title) {
//      return getPathImage(path, title);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    final assetFile =
        type == null ? null : AssetHandler().getFolder(assetFolder).getFileByEnum(type);

    return Row(
      children: <Widget>[
        assetFile == null
            ? const Icon(
                Icons.credit_card,
                size: PAINT_SIZE,
              )
            : Image.asset(
                assetFile.path,
                width: PAINT_SIZE,
                height: PAINT_SIZE,
                fit: BoxFit.contain,
              ),
        SizedBox(
          width: 16.0,
        ),
        Text(
          type == null ? "Unknow" : getTitlePaymentCard[type],
          style: tt.subtitle,
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(isDense == true ? '... $last4' : 'XXXX XXXX XXXX $last4'),
      ],
    );
  }
}
