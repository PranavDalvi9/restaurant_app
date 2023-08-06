import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/screens/common/app_text.dart';

Widget meatStatusCapsule({
  required BuildContext context,
  required String title,
  required String icon,
  required VoidCallback onTap,
  required bool isSelected,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.indigo100 : Colors.transparent,
        border: Border.all(
          color: ColorConstants.gray700,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 4),
          AppText(
            title: title,
            fontSize: 10,
            titleColor: ColorConstants.gray900,
          ),
        ],
      ),
    ),
  );
}
