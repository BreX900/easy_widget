import 'package:flutter/material.dart';

typedef Widget _SizeBuilder(BuildContext context, Size size);

class Sizer extends StatelessWidget {
  final double aspectRatio;
  final EdgeInsets padding;
  final _SizeBuilder builder;

  const Sizer({
    Key key,
    @required this.aspectRatio,
    this.padding,
    @required this.builder,
  })  : assert(aspectRatio != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_context, box) {
        if (padding != null) box = box.deflate(padding);

        double width = box.maxWidth;
        double height;

        if (width.isFinite) {
          height = width / aspectRatio;
        } else {
          height = box.maxHeight;
          width = height * aspectRatio;
        }
        if (width > box.maxWidth) {
          width = box.maxWidth;
          height = width / aspectRatio;
        }
        if (height > box.maxHeight) {
          height = box.maxHeight;
          width = height * aspectRatio;
        }
        if (width < box.minWidth) {
          width = box.minWidth;
          height = width / aspectRatio;
        }
        if (height < box.minHeight) {
          height = box.minHeight;
          width = height * aspectRatio;
        }

        return builder(_context, Size(width, height));
      },
    );
  }
}
