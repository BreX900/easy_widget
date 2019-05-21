import 'package:easy_widget/src/gallery.dart';
import 'package:easy_widget/src/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class SimpleSwiper extends StatelessWidget {
  final int itemCount;
  final ImgBuilder imgBuilder;
  final OpenScreen openScreen;

  SimpleSwiper({Key key,  @required this.itemCount,
    @required this.imgBuilder, @required this.openScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      autoplay: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index){
        if (index+1 < itemCount)
          precacheImage(imgBuilder(index+1), context);

        return InkWell(
          onTap: () => openScreen(context, GalleryScreen(
            itemCount: itemCount,
            imgBuilder: imgBuilder,
            initialPage: index,)),
          child: Hero(
              tag: DEFAULT_HERO_TAG+index.toString(),
              child: Image(image: imgBuilder(index), fit: BoxFit.cover, )));
      },
      pagination: SwiperPagination(
        builder: SwiperPagination.fraction,
      ),
      control: SwiperController(
        iconPrevious: Icons.arrow_back_ios,
        iconNext: Icons.arrow_forward_ios,
        color: Colors.white,
        iconBuilder: (Icon icon) {
          return icon;
        }
      ),
    );
  }
}

typedef Widget IconBuilder(Icon iconData);

Widget _defaultIconBuilder(Icon icon) {
  return icon;
}

class SwiperController extends SwiperPlugin {
  ///IconData for previous
  final IconData iconPrevious;

  ///iconData fopr next
  final IconData iconNext;

  ///icon size
  final double size;

  ///Icon normal color, The theme's [ThemeData.primaryColor] by default.
  final Color color;

  ///if set loop=false on Swiper, this color will be used when swiper goto the last slide.
  ///The theme's [ThemeData.disabledColor] by default.
  final Color disableColor;

  final EdgeInsetsGeometry padding;

  final Key key;

  final IconBuilder iconBuilder;

  const SwiperController({
    this.iconPrevious: Icons.arrow_back_ios,
    this.iconNext: Icons.arrow_forward_ios,
    this.color,
    this.disableColor,
    this.key,
    this.size: 30.0,
    this.padding: const EdgeInsets.all(5.0),
    this.iconBuilder: _defaultIconBuilder,
  });

  Widget buildButton(SwiperPluginConfig config, Color color, IconData iconDaga,
      int quarterTurns, bool previous) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (previous) {
          config.controller.previous(animation: true);
        } else {
          config.controller.next(animation: true);
        }
      },
      child: Padding(
          padding: padding,
          child: RotatedBox(
              quarterTurns: quarterTurns,
              child: iconBuilder(Icon(
                iconDaga,
                semanticLabel: previous ? "Previous" : "Next",
                size: size,
                color: color,
              )))),
    );
  }

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);

    Color color = this.color ?? themeData.primaryColor;
    Color disableColor = this.disableColor ?? themeData.disabledColor;
    Color prevColor;
    Color nextColor;

    if (config.loop) {
      prevColor = nextColor = color;
    } else {
      bool next = config.activeIndex < config.itemCount - 1;
      bool prev = config.activeIndex > 0;
      prevColor = prev ? color : disableColor;
      nextColor = next ? color : disableColor;
    }

    Widget child;
    if (config.scrollDirection == Axis.horizontal) {
      child = Row(
        key: key,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton(config, prevColor, iconPrevious, 0, true),
          buildButton(config, nextColor, iconNext, 0, false)
        ],
      );
    } else {
      child = Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton(config, prevColor, iconPrevious, -3, true),
          buildButton(config, nextColor, iconNext, -3, false)
        ],
      );
    }

    return new Container(
      height: double.infinity,
      child: child,
      width: double.infinity,
    );
  }
}