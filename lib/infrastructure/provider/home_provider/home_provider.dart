import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<HomeProvider> ref;
  HomeProvider(this.ref);

  int selectedFoodMenu = 0;

  int selectedMeatStatus = 0;

  int? selectedTile;

  setSelectedTile(int value) {
    selectedTile = value;
    notifyListeners();
  }

  setSelectedFoodMenu(int value) {
    selectedFoodMenu = value;
    notifyListeners();
  }

  setSelectedMeatStatus(int value) {
    selectedMeatStatus = value;
    notifyListeners();
  }
}
