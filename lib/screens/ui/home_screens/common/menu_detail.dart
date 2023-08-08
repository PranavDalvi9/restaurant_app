import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/provider/provider_registration.dart';
import 'package:restaurant_app/screens/common/app_text.dart';
import 'package:restaurant_app/screens/ui/home_screens/home_screen.dart';

class MenuDetail extends ConsumerStatefulWidget {
  const MenuDetail({super.key});

  @override
  ConsumerState<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends ConsumerState<MenuDetail> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          if (homeProviderWatch.selectedMenuData?['dish']['hasImage'])
            Container(
              height: 144,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Image.network(homeProviderWatch.selectedMenuData?['dish']['image']),
            ),
          Row(
            children: [
              SvgPicture.asset(meatStatusIcon(homeProviderWatch.selectedMenuData?['dish']['meatStatus'])),
              const SizedBox(width: 8),
              AppText(
                title: homeProviderWatch.selectedMenuData?['dish']['name'],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          const SizedBox(height: 10),
          AppText(
            title: homeProviderWatch.selectedMenuData?['dish']['description'],
            fontSize: 12,
            fontWeight: FontWeight.w400,
            titleColor: ColorConstants.gray500,
            overflow: TextOverflow.visible,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConstants.indigo400),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.indigo400,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      height: 42,
                      width: 36,
                      child: const Icon(
                        Icons.remove,
                        color: ColorConstants.gray50,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 19.5),
                      child: const AppText(
                        title: "1",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstants.indigo400,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.indigo400,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      height: 42,
                      width: 36,
                      child: const Icon(
                        Icons.add,
                        color: ColorConstants.gray50,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstants.indigo400,
                  ),
                  child: Row(
                    children: [
                      const AppText(
                        title: "Add to Cart",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstants.gray50,
                      ),
                      const Spacer(),
                      AppText(
                        title: "₹${homeProviderWatch.totalCartPrice}",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstants.gray50,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
