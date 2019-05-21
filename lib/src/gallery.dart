import 'package:easy_widget/src/utility.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

const String DEFAULT_HERO_TAG = "Simple";


class GalleryScreen extends StatelessWidget {
  final int itemCount;
  final ImgBuilder imgBuilder;
  final int initialPage;

  GalleryScreen({Key key, @required this.itemCount, @required this.imgBuilder, this.initialPage: 0,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          GalleryPage(itemCount: itemCount, imgBuilder: imgBuilder, initialPage: initialPage),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.close, color: Colors.white,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  final int itemCount;
  final ImgBuilder imgBuilder;
  final int initialPage;

  GalleryPage({Key key, @required this.imgBuilder, this.initialPage: 0, @required this.itemCount}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PhotoViewGallery.builder(
          pageController: _pageController,
          itemCount: widget.itemCount,
          builder: (context, index) {
            if (index+1 < widget.itemCount)
              precacheImage(widget.imgBuilder(index+1), context);

            return PhotoViewGalleryPageOptions(
              imageProvider: widget.imgBuilder(index),
              heroTag: DEFAULT_HERO_TAG + index.toString(),
              minScale: PhotoViewComputedScale.contained,
              maxScale: 4.0,
            );
          },
          backgroundDecoration: BoxDecoration(color: Colors.black87),
        ),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,),
              ),
              IconButton(
                onPressed: () => _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear),
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30,),
              ),
            ],
          ),
        )
      ],
    );
  }
}