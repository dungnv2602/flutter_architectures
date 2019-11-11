import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider_arc/provider/base_notifier.dart';

const String mockLoadingIndicator = '^';

class MockPostsNotifier extends BaseNotifier {
  static const int itemRequestThreshold = 15;

  int _currentPage = 0;

  List<String> _items = [];

  UnmodifiableListView<String> get items => UnmodifiableListView(_items);

  MockPostsNotifier() {
    _addRandomItems();
  }

  Future handleItemCreated(int index) async {
    var itemPos = index + 1;
    var requestMoreData = itemPos % itemRequestThreshold == 0 && itemPos != 0;
    // ~/: divide and truncate
    final pageToRequest = itemPos ~/ itemRequestThreshold;
    if (requestMoreData && pageToRequest > _currentPage) {
      debugPrint('pageToRequest: $pageToRequest');
      _currentPage = pageToRequest;
      _showLoadingIndicator();
      await Future.delayed(const Duration(seconds: 2));
      _addRandomItems();
      _hideLoadingIndicator();
    }
  }

  void reload() {
    _currentPage = 0;
    _items.clear();
    _addRandomItems();
  }

  void _addRandomItems() {
    final list = List<String>.generate(itemRequestThreshold, (index) => 'Page $_currentPage Item $index');
    _items.addAll(list);
  }



  void _showLoadingIndicator() {
    _items.add(mockLoadingIndicator);
    notifyListeners();
  }

  void _hideLoadingIndicator() {
    _items.remove(mockLoadingIndicator);
    notifyListeners();
  }
}
