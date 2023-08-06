import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/common/constants/image_constants.dart';
import 'package:restaurant_app/infrastructure/provider/provider_registration.dart';
import 'package:restaurant_app/infrastructure/response/restaurant_response_data.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/category_tile.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/meat_status_capsule.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/menu_type_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Map<String, Map<String, List<Map<String, dynamic>>>>> groupedAndFilteredDataList = [];
  List<String> meatStatusKeys = [];
  List meatStatusValues = [];
  List<String> categoryKeys = [];
  List categoryValues = [];

  testttt() {
    for (var menu in restaurantResponse['description']["menus"]) {
      Map<String, Map<String, List<Map<String, dynamic>>>> groupedAndFilteredData = {};

      for (var entry in menu["entries"]) {
        var meatStatus = entry["dish"]["meatStatus"];
        var category = entry["category"];

        if (!groupedAndFilteredData.containsKey(meatStatus)) {
          groupedAndFilteredData[meatStatus] = {};
        }

        if (!groupedAndFilteredData[meatStatus]!.containsKey(category)) {
          groupedAndFilteredData[meatStatus]![category] = [];
        }

        groupedAndFilteredData[meatStatus]![category]!.add(entry);
      }

      groupedAndFilteredDataList.add(groupedAndFilteredData);
    }
    setMeatStatusKey();
    inspect(groupedAndFilteredDataList);
  }

  setMeatStatusKey() {
    meatStatusKeys = groupedAndFilteredDataList[ref.watch(homeProvider).selectedFoodMenu].keys.toList();
    meatStatusValues = groupedAndFilteredDataList[ref.watch(homeProvider).selectedFoodMenu].values.toList();
    setCategoryKey();
  }

  setCategoryKey() {
    categoryKeys = meatStatusValues[ref.watch(homeProvider).selectedMeatStatus].keys.toList();
    categoryValues = meatStatusValues[ref.watch(homeProvider).selectedMeatStatus].values.toList();
  }

  @override
  Widget build(BuildContext context) {
    testttt();
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: SvgPicture.asset(
              ImageConstants.explorexLogo,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                for (int i = 0; i < restaurantResponse['description']["menus"].length; i++)
                  menuTypeWidget(
                    context: context,
                    title: restaurantResponse['description']["menus"][i]['name'],
                    isSelected: homeProviderWatch.selectedFoodMenu == i ? true : false,
                    onTap: () {
                      homeProviderRead.setSelectedFoodMenu(i);
                      setMeatStatusKey();
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12.5,
            ),
            child: Row(
              children: [
                for (int i = 0; i < meatStatusKeys.length; i++)
                  meatStatusCapsule(
                    context: context,
                    icon: ImageConstants.vegIcon,
                    title: meatStatusKeys[i],
                    onTap: () {
                      homeProviderRead.setSelectedMeatStatus(i);
                      setCategoryKey();
                    },
                    isSelected: homeProviderWatch.selectedMeatStatus == i,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: ColorConstants.gray300,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  for (int i = 0; i < categoryKeys.length; i++)
                    categoryTile(
                      title: categoryKeys[i],
                      subTitle: categoryValues[i].length.toString(),
                      context: context,
                      data: categoryValues[i],
                    )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
