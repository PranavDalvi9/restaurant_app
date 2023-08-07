import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/common/constants/image_constants.dart';
import 'package:restaurant_app/screens/common/app_text.dart';

Widget menuCardWidget({
  required BuildContext context,
  required String title,
  required String description,
  required String sellingPrice,
  required String displayPrice,
  required String image,
}) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: ColorConstants.gray500),
        top: BorderSide(color: ColorConstants.gray500),
      ),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(ImageConstants.vegIcon),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.indigo100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageConstants.likeIcon),
                        const SizedBox(width: 4),
                        const AppText(
                          title: "222",
                          fontSize: 9,
                          titleColor: ColorConstants.indigo400,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppText(
                title: title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 6),
              AppText(
                title: description,
                fontSize: 10,
                titleColor: ColorConstants.gray500,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  AppText(
                    title: 'Rs $displayPrice',
                    fontSize: 10,
                  ),
                  const SizedBox(width: 8),
                  AppText(
                    title: 'Rs $sellingPrice',
                    fontSize: 10,
                    isLineThrough: true,
                  ),
                ],
              )
            ],
          ),
        ),
        Column(
          children: [
            if (image.isNotEmpty)
              SizedBox(
                width: 100,
                child: Image.network(image),
              ),
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: ColorConstants.indigo400, width: 2),
              ),
              child: const AppText(
                titleTextAlign: TextAlign.center,
                title: "Add",
                fontSize: 12,
                titleColor: ColorConstants.indigo400,
              ),
            )
          ],
        )
      ],
    ),
  );
}
