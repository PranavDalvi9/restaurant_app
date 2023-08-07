import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/common/constants/image_constants.dart';
import 'package:restaurant_app/infrastructure/provider/provider_registration.dart';
import 'package:restaurant_app/infrastructure/response/restaurant_response_data.dart';
import 'package:restaurant_app/screens/common/app_text.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/meat_status_capsule.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/menu_type_widget.dart';

class FoodMenuBottomSheet extends ConsumerStatefulWidget {
  final List<String> meatStatusKeys;
  final List meatStatusValues;
  final List<String> categoryKeys;
  final List categoryValues;
  const FoodMenuBottomSheet({
    super.key,
    required this.meatStatusKeys,
    required this.meatStatusValues,
    required this.categoryKeys,
    required this.categoryValues,
  });

  @override
  ConsumerState<FoodMenuBottomSheet> createState() => _FoodMenuBottomSheetState();
}

class _FoodMenuBottomSheetState extends ConsumerState<FoodMenuBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // int level = 0;
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);
    return Column(
      children: [
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
        Container(
          height: 54,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12.5,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < homeProviderWatch.meatStatusKeys.length; i++)
                meatStatusCapsule(
                  context: context,
                  icon: ImageConstants.vegIcon,
                  title: widget.meatStatusKeys[i],
                  onTap: () {
                    homeProviderRead.setSelectedMeatStatus(i);
                    ref.read(homeProvider).setCategoryKey();
                  },
                  isSelected: homeProviderWatch.selectedMeatStatus == i,
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    key: Key('builder ${homeProviderWatch.selectedTile.toString()}'),
                    shrinkWrap: true,
                    itemCount: ref.watch(homeProvider).categoryKeys.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ref.read(homeProvider).setSelectedTile(index);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: homeProviderWatch.selectedTile == index ? ColorConstants.indigo100 : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Radio(
                                  value: index,
                                  groupValue: homeProviderWatch.selectedTile,
                                  onChanged: (value) {
                                    ref.read(homeProvider).setSelectedTile(value ?? 0);
                                  }),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: AppText(
                                  title: ref.watch(homeProvider).categoryKeys[index],
                                  fontSize: 12,
                                  fontWeight: homeProviderWatch.selectedTile == index ? FontWeight.w600 : FontWeight.w400,
                                  titleColor: ColorConstants.indigo400,
                                ),
                              ),
                              const Spacer(),
                              AppText(
                                title: '(${ref.watch(homeProvider).categoryValues[index].length.toString()})',
                                fontSize: 12,
                                fontWeight: homeProviderWatch.selectedTile == index ? FontWeight.w600 : FontWeight.w400,
                                titleColor: ColorConstants.indigo400,
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        )
      ],
    );
  }
}
