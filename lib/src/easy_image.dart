import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class EasyImage extends StatefulWidget {
  final ImageProvider image;

  final double width;
  final double height;
  final Color color;
  final FilterQuality filterQuality;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final String semanticLabel;
  final bool excludeFromSemantics;

  const EasyImage(this.image, {Key key,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  }) : super(key: key);

  EasyImage.network(String img, {
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  }) : this.image = NetworkImage(img);

  @override
  _EasyImageState createState() => _EasyImageState();
}

class _EasyImageState extends State<EasyImage> {
  ImageStatus _status = ImageStatus.LOADING;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loading();
  }

  void loading() {
    precacheImage(widget.image, context, onError: _error).then(_complete);
  }

  void _complete(_) {
    setState(() {
      _status = ImageStatus.COMPLETE;
    });
  }

  void _error(_, error) {
    setState(() {
      _status = ImageStatus.ERROR;
    });
  }

  void _reloading() {
    loading();
    setState(() {
      _status = ImageStatus.LOADING;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case ImageStatus.COMPLETE:
        return Image(
          image: widget.image,
          semanticLabel: widget.semanticLabel,
          excludeFromSemantics: widget.excludeFromSemantics,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          fit: widget.fit,
          alignment: widget.alignment,
          repeat: widget.repeat,
          centerSlice: widget.centerSlice,
          matchTextDirection: widget.matchTextDirection,
          gaplessPlayback: widget.gaplessPlayback,
          filterQuality: widget.filterQuality,
        );
        break;
      case ImageStatus.LOADING:
        return Center(child: CircularProgressIndicator(),
        );
        break;
      case ImageStatus.ERROR:
        return Center(
          child: IconButton(
            onPressed: _reloading,
            icon: const Icon(Icons.broken_image),
          ),
        );
        break;
    }
  }
}


enum ImageStatus {
  LOADING, COMPLETE, ERROR,
}