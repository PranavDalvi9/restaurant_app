import 'package:flutter/material.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';

class AppText extends StatelessWidget {
  const AppText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textDecoration,
      this.textScaleFactor,
      required this.fontSize,
      this.lineHeight,
      this.isLineThrough = false,
      this.fontFamily,
      this.overflow,
      this.letterSpacing})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final bool? softWrap;
  final TextDecoration? textDecoration;
  final double? textScaleFactor;
  final bool? isLineThrough;
  final double? lineHeight;
  final double? letterSpacing;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaleFactor: 1,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: titleColor ?? ColorConstants.gray900,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: isLineThrough == true ? TextDecoration.lineThrough : textDecoration,
          fontFamily: fontFamily ?? 'Poppins',
          letterSpacing: letterSpacing ?? 0,
          overflow: TextOverflow.ellipsis,
          height: lineHeight ?? 1.5,
          fontSize: fontSize ?? 16),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
