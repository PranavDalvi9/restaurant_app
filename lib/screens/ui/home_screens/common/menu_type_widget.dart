import 'package:flutter/material.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/common/constants/image_constants.dart';
import 'package:restaurant_app/screens/common/app_text.dart';

Widget menuTypeWidget({
  required BuildContext context,
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: (MediaQuery.of(context).size.width - 50) / 2,
      margin: const EdgeInsets.only(right: 8),
      height: 72,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? ColorConstants.indigo400 : Colors.transparent,
          width: 4,
        ),
        image: const DecorationImage(
          image: AssetImage(
            ImageConstants.food,
          ),
          fit: BoxFit.fill,
        ),
        color: Colors.black.withOpacity(0.42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        child: AppText(
          title: title,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          titleColor: ColorConstants.gray50,
          titleTextAlign: TextAlign.end,
        ),
      ),
    ),
  );
}
