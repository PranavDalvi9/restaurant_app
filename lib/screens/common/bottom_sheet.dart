import 'package:flutter/material.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';

class CommonBottomSheet {
  static customBottomSheet(
      {required BuildContext context, required Widget child, double? height, double? width, isDismissible = false}) async {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.black.withOpacity(0.8),
        backgroundColor: Colors.transparent,
        isDismissible: isDismissible,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.gray50),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 8,
                        color: ColorConstants.gray50,
                      )
                      //  Divider(thickness: 2, color: Colors.red),
                      ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: ColorConstants.gray50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    width: width ?? MediaQuery.of(context).size.width,
                    height: height,
                    child: child),
              ],
            ),
          );
        });
  }
}
