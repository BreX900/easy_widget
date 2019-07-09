import 'package:easy_widget/easy_widget.dart';
import 'package:flutter/material.dart';


class FlagView extends StatelessWidget {
  static const ASSET_FOLDER = "packages/easy_widget/assets/imgs/flags/";

  final Locale locale;
  final String assetFolder;
  final double size;
  final EdgeInsets padding;
  final Widget child;

  const FlagView({Key key,
    @required this.locale, this.assetFolder: ASSET_FOLDER,
    this.size: 24, this.padding: const EdgeInsets.all(8.0), @required this.child,
  }) :
    assert(child != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetFile = AssetHandler().getFolder(assetFolder).getFileByLocale(locale);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: size, height: size,
          child: Center(
            child: Material(
              elevation: 10.0,
              color: Colors.transparent,
              child: Ink.image(
                width: size, height: size,
                fit: BoxFit.contain,
                image: assetFile == null ? const Icon(Icons.flag) : AssetImage(assetFile.path),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}