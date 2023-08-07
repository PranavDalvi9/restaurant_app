import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/infrastructure/common/constants/color_constants.dart';
import 'package:restaurant_app/infrastructure/provider/provider_registration.dart';
import 'package:restaurant_app/screens/common/app_text.dart';
import 'package:restaurant_app/screens/ui/home_screens/common/menu_card.dart';

class CategoryTile extends ConsumerStatefulWidget {
  final String title;
  final String subTitle;
  final List data;
  final int ind;
  const CategoryTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.data,
    required this.ind,
  });

  @override
  ConsumerState<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends ConsumerState<CategoryTile> {
  @override
  Widget build(BuildContext context1) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 16),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: Key(widget.ind.toString()),
          onExpansionChanged: (value) {
            if (value) {
              ref.read(homeProvider).setSelectedTile(widget.ind);
            } else {
              ref.read(homeProvider).setSelectedTile(-1);
            }
          },
          initiallyExpanded: ref.watch(homeProvider).selectedTile == widget.ind,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          collapsedBackgroundColor: ColorConstants.gray50,
          backgroundColor: ColorConstants.gray50,
          title: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 180),
                child: AppText(
                  title: widget.title,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              AppText(
                title: '${widget.subTitle} items',
                fontSize: 12,
                titleColor: ColorConstants.gray500,
              ),
            ],
          ),
          children: [
            for (int i = 0; i < widget.data.length; i++)
              menuCardWidget(
                context: context,
                title: widget.data[i]['dish']['name'],
                description: widget.data[i]['dish']['description'],
                displayPrice: widget.data[i]['displayPrice'].toString(),
                sellingPrice: widget.data[i]['sellingPrice'].toString(),
                image: widget.data[i]['dish']['hasImage'] ? widget.data[i]['dish']['image'] : "",
              ),
          ],
        ),
      ),
    );
  }
}
