import 'package:flutter/cupertino.dart';

import '../models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedModels> viewedItem = {};

  Map<String, ViewedModels> get getViewedItem {
    return viewedItem;
  }

  void addProductToHistory({
    required String productId,
  }) {
    viewedItem.putIfAbsent(productId, () {
      return ViewedModels(
        id: DateTime.now().toString(),
        productId: productId,
      );
    });

    notifyListeners();
  }

  void clearHistoryProduct() {
    viewedItem.clear();
    notifyListeners();
  }
}
