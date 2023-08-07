import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<HomeProvider> ref;
  HomeProvider(this.ref);

  int selectedFoodMenu = 0;

  int selectedMeatStatus = 0;

  int? selectedTile;

  List<Map<String, Map<String, List<Map<String, dynamic>>>>> groupedAndFilteredDataList = [];
  List<String> meatStatusKeys = [];
  List meatStatusValues = [];
  List<String> categoryKeys = [];
  List categoryValues = [];

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

  setMeatStatusKey() {
    meatStatusKeys = groupedAndFilteredDataList[selectedFoodMenu].keys.toList();
    meatStatusValues = groupedAndFilteredDataList[selectedFoodMenu].values.toList();
    setCategoryKey();
    notifyListeners();
  }

  setCategoryKey() {
    categoryKeys = meatStatusValues[selectedMeatStatus].keys.toList();
    categoryValues = meatStatusValues[selectedMeatStatus].values.toList();
    notifyListeners();
  }
}
