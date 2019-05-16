import 'dart:async';

import 'package:flutter/material.dart';


typedef Future<void> MagicLoader(int numPage);

typedef Widget MagicScrollBuilder<M>(_MagicModelsBuilder magicManager);

typedef Widget MagicItemBuilder<M>(BuildContext context, List<M> models, int index);

class _MagicModelsBuilder<M> {
  List<M> _models;
  final int _itemsInPage;
  int _currentPage = 1;//, _lastLengthModels = -1;
  bool _isPerformMoreModels = false, _existMoreModels = true;
  final MagicItemBuilder<M> _itemBuilder;
  final MagicLoader _magicLoader;

  _MagicModelsBuilder(int itemInPage, MagicItemBuilder<M> itemBuilder, MagicLoader magicLoader) :
        this._itemsInPage = itemInPage, this._itemBuilder = itemBuilder, this._magicLoader = magicLoader;

  void _update(List<M> models) {
    _existMoreModels = (_models?.length??-1) != models.length;
    _models = models;
    _isPerformMoreModels = false;
  }

  Future<void> _modelsLoader() async {
    if (!_isPerformMoreModels) {
      _isPerformMoreModels = true;
      _magicLoader(++_currentPage);
    }
  }

  bool get hasData => _models != null;

  Widget itemBuilder(BuildContext context, int index) {
    if (_models == null)
      return index == 0 ? Center(child: CircularProgressIndicator(),) : null;
    if (_models.length > index) {
      if (index > ((_currentPage*_itemsInPage)-(_itemsInPage/2))) {
        _modelsLoader();
      }
      return _itemBuilder(context, _models, index);
    }
    if (_models.length == index && _existMoreModels) {
      return Center(child: Padding(padding: EdgeInsets.all(5), child: CircularProgressIndicator()),);
    }
    return null;
  }
}

class MagicScrollView<M> extends StatefulWidget {
  final Stream<List<M>> stream;
  final MagicScrollBuilder<M> widgetBuilder;
  final int itemsInPage;
  final MagicItemBuilder<M> itemBuilder;
  final MagicLoader magicLoader;


  MagicScrollView({Key key, @required this.stream, @required this.widgetBuilder,
    @required this.itemsInPage, @required this.itemBuilder, @required this.magicLoader}) :
        super(key: key);

  @override
  _MagicScrollViewState createState() => _MagicScrollViewState<M>();
}

class _MagicScrollViewState<M> extends State<MagicScrollView<M>> {
  StreamSubscription _subscription;
  _MagicModelsBuilder<M> _magicManager;

  @override
  void initState() {
    super.initState();
    _magicManager = _MagicModelsBuilder<M>(widget.itemsInPage, widget.itemBuilder, widget.magicLoader);
    _subscription = widget.stream.listen(_updateModels);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  _updateModels(List<M> models) {
    setState(() {
      _magicManager._update(models);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.widgetBuilder(_magicManager);
  }
}
