import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/common/constants/image_constants.dart';
import 'package:restaurant_app/infrastructure/provider/provider_registration.dart';
import 'package:restaurant_app/infrastructure/response/restaurant_response_data.dart';
import 'package:restaurant_app/screens/common/app_text.dart';
import 'package:restaurant_app/screens/common/bottom_sheet.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/food_menu_bottomsheet.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/category_tile.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/meat_status_capsule.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/menu_type_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

      ref.read(homeProvider).groupedAndFilteredDataList.add(groupedAndFilteredData);
    }
    ref.read(homeProvider).setMeatStatusKey();
    inspect(ref.watch(homeProvider).groupedAndFilteredDataList);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      testttt();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);
    return restaurantResponse['code'] == 0
        ? Scaffold(
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
                            homeProviderRead.setSelectedMeatStatus(0);
                            ref.read(homeProvider).setMeatStatusKey();
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12.5,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < ref.read(homeProvider).meatStatusKeys.length; i++)
                        meatStatusCapsule(
                          context: context,
                          icon: meatStatusIcon(ref.watch(homeProvider).meatStatusKeys[i]),
                          title: ref.watch(homeProvider).meatStatusKeys[i],
                          onTap: () {
                            homeProviderRead.setSelectedMeatStatus(i);
                            ref.read(homeProvider).setCategoryKey();
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
                        ListView.builder(
                            key: Key('builder ${homeProviderWatch.selectedTile.toString()}'),
                            shrinkWrap: true,
                            itemCount: ref.watch(homeProvider).categoryKeys.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                title: ref.watch(homeProvider).categoryKeys[index],
                                subTitle: ref.watch(homeProvider).categoryValues[index].length.toString(),
                                data: ref.watch(homeProvider).categoryValues[index],
                                ind: index,
                              );
                            })
                      ],
                    ),
                  ),
                )),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    CommonBottomSheet.customBottomSheet(
                        context: context,
                        child: FoodMenuBottomSheet(
                          categoryKeys: ref.watch(homeProvider).categoryKeys,
                          categoryValues: ref.watch(homeProvider).categoryValues,
                          meatStatusKeys: ref.watch(homeProvider).meatStatusKeys,
                          meatStatusValues: ref.watch(homeProvider).meatStatusValues,
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorConstants.gray900,
                    ),
                    height: 40,
                    width: 155,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset(
                        ImageConstants.categoriesIcon,
                      ),
                      const SizedBox(width: 8),
                      const AppText(
                        title: 'View Categories',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstants.gray50,
                      )
                    ]),
                  ),
                ),
                if (homeProviderWatch.cartData.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstants.indigo400,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: 'Rs ${homeProviderWatch.totalCartPrice}',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                titleColor: ColorConstants.gray50,
                              ),
                              AppText(
                                title: '${homeProviderWatch.cartData.length} items',
                                fontSize: 9,
                                titleColor: ColorConstants.gray50,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorConstants.gray50,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  title: "View & Order",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  titleColor: ColorConstants.indigo400,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          )
        : const Center(
            child: AppText(
              title: "Something Went Wrong",
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          );
  }
}

meatStatusIcon(String status) {
  switch (status) {
    case 'VEG':
      return ImageConstants.vegIcon;
    case 'NON_VEG':
      return ImageConstants.nonVegIcon;
    case 'VEG_CONTAINS_EGG':
      return ImageConstants.eggIcon;
    case 'VEGAN':
      return ImageConstants.vegIcon;
    default:
      return ImageConstants.vegIcon;
  }
}
