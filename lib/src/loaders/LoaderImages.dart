import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';


class AssetHandler {
  static AssetHandler _instance;

  final BuildContext context;
  final List<AssetFolder> assetContent;

  @protected
  AssetHandler.internal({@required this.context, @required this.assetContent}) :
        assert(context != null), assert(assetContent != null);

  static Future<List<AssetFolder>> loadAssetContent(BuildContext context) async {
    assert(context != null);
    final raw = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final assetContent = (json.decode(raw) as Map<String, dynamic>);
    final folders = List<AssetFolder>();

    assetContent.forEach((path, dataPath) {
      final startFile = path.lastIndexOf("/")+1;
      final folderPath = path.substring(0, startFile);

      final folder = folders.firstWhere((directory) => directory.path == folderPath, orElse: () {
        final tmpFolder = AssetFolder(
          path: folderPath,
          files: [],
        );
        folders.add(tmpFolder);
        return tmpFolder;
      });
      folder._files.add(AssetFile(
        folderPath: folderPath,
        name: path.substring(startFile),
        files: (dataPath as List).cast<String>().map((file) => file.replaceAll("%20", " ")).toList(),
      ));
    });
    return folders;
  }

  factory AssetHandler() {
    assert(_instance != null);
    return _instance;
  }

  static Future<AssetHandler> init(BuildContext context) async {
    if (_instance == null) {
      assert(context != null);
      _instance = AssetHandler.internal(
        context: context, assetContent: await loadAssetContent(context),
      );
    }
    return _instance;
  }

  Future<void> cacheImage(String assetName) async {
    assert(assetName != null);
    await precacheImage(AssetImage(assetName), context);
  }

  Future<void> cacheImages(Iterable<String> assetNames) async {
    assert(assetNames != null);
    return await Future.forEach(assetNames, cacheImage);
  }

  AssetFolder getFolder(String path) {
    assert(path != null);
    return assetContent.firstWhere((folder) => folder.path == path, orElse: () => null);
  }

  Future<void> resolve(String assetDirectory, Iterable<String> imgs, {String type: 'jpg'}) async {
    await Future.forEach(imgs, (img) async {
      await cacheImage('$assetDirectory/$img.$type');
    });
  }
}


class AssetFolder extends ListBase<AssetFile> {
  final String path;
  final List<AssetFile> _files;

  AssetFolder({
    @required this.path, List<AssetFile> files,
  }) : assert(path != null), assert(files != null),
  this._files = files;

  AssetFile getFileByTitle(String titleFile) {
    return _files.firstWhere((file) => file.title == titleFile, orElse: () => null);
  }
  AssetFile getFileByEnum(Object enumObject) {
    assert(enumObject != null);
    return getFileByTitle(enumObject.toString().split(".").last);
  }
  AssetFile getFileByLocale(Locale locale) {
    return getFileByTitle(locale.languageCode)??getFileByTitle('en');
  }

  Future<void> cacheImages() async {
    await Future.forEach<AssetFile>(_files, (file) => AssetHandler._instance.cacheImage(file.path));
  }

  @override
  int get hashCode => hash(path);
  @override
  bool operator ==(other) {
    return other is AssetFolder && path == other.path;
  }

  @override
  String toString() {
    return "AssetFolder(path: $path, files: $_files)";
  }

  @override
  int get length => _files.length;

  @override
  AssetFile operator [](int index) => _files[index];

  @override
  void operator []=(int index, AssetFile value) => throw "Not Usable";

  @override
  set length(int newLength) => throw "Not Usable";
}


class AssetFile {
  final String folderPath;
  final String name;
  final List<String> files;

  AssetFile({@required this.folderPath, @required this.name, @required this.files});

  String get path => folderPath+name;
  String get title => name.split(".").first;

  @override
  String toString() => path;
}


/*static const PAYMENT_CARD = {
    ""
  };

  LoaderCacheManager _cacheManager = LoaderCacheManager("LoaderImages");

  final Map<String, File> _urls = {};

  Future<void> load(Iterable<String> urls) async {
    await Future.forEach(urls, (url) async {
      final file = _urls[url];
      if (file == null)
        _urls[url] = await _cacheManager.getSingleFile(url);
    });
  }

  File getImage(String url) {
    return _urls[url];
  }

  Future<File> saveImage(String url) async {

    final file = await getImageFromNetwork(url);

    _cacheManager.putFile(url, file.readAsBytesSync())

    //retrieve local path for device
    var path = await _localPath;
    Image image = decodeImage();

    Image thumbnail = copyResize(image, 120);

    // Save the thumbnail as a PNG.
    return new Io.File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(thumbnail));
  }*/