import 'package:flutter/material.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/screens/common/app_text.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/menu_card.dart';

Widget categoryTile({
  required BuildContext context,
  required String title,
  required String subTitle,
  required List data,
}) {
  return ExpansionTile(
    collapsedBackgroundColor: ColorConstants.gray50,
    backgroundColor: ColorConstants.gray50,
    title: Row(
      children: [
        SizedBox(
          width: 200,
          child: AppText(
            title: title,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        AppText(
          title: '$subTitle items',
          fontSize: 12,
          titleColor: ColorConstants.gray500,
        ),
      ],
    ),
    children: [
      for (int i = 0; i < data.length; i++)
        menuCardWidget(
            context: context,
            title: data[i]['dish']['name'],
            description: data[i]['dish']['description'],
            displayPrice: data[i]['displayPrice'].toString(),
            sellingPrice: data[i]['sellingPrice'].toString()),
    ],
  );
}
