import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:jimmys/core/extensions/build_context.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/domain/enums/base_enum.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class MyGroupedListView extends StatefulWidget {
  const MyGroupedListView({
    super.key,
    required this.data,
    required this.idField,
    this.topTextField,
    this.topEnumField,
    this.iconField,
    required this.middleTextField,
    this.bottomTextField,
    this.padding = const EdgeInsets.symmetric(vertical: spacingMicro, horizontal: spacingMedium),
    required this.onSelected,
  });

  final List<Map<String, dynamic>> data;
  final String idField;
  final String? iconField;
  final String? topTextField;
  final BaseEnum? topEnumField;
  final String middleTextField;
  final String? bottomTextField;
  final EdgeInsetsGeometry padding;
  final Function onSelected;

  @override
  State<MyGroupedListView> createState() => _MyGroupedListViewState();
}

class _MyGroupedListViewState extends State<MyGroupedListView> with WidgetsMixin {
  late List<MyGroupedListItem> _data;

  @override
  Widget build(BuildContext context) {
    _data = widget.data
      .map((_) => MyGroupedListItem.fromMap(
        _,
        widget.idField,
        widget.topTextField,
        widget.topEnumField,
        widget.iconField,
        widget.middleTextField,
        widget.bottomTextField,
      ))
      .toList();

    widget.data.clear();

    SuspensionUtil.sortListBySuspensionTag(_data);
    SuspensionUtil.setShowSuspensionStatus(_data);

    return Padding(
      padding: widget.padding,
      child: AzListView(
        data: _data,
        itemCount: _data.length,
        itemBuilder: _itemBuilder,
        indexHintBuilder: _indexHintBuilder,
        indexBarItemHeight: spacingMedium,
        hapticFeedback: true,
        indexBarMargin: const EdgeInsets.all(spacingSmall),
        indexBarOptions: _indexBarOptions(),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = _data[index];

    return Column(
      children: [
        Offstage(
          offstage: !item.isShowSuspension,
          child: Container(
            height: spacingLarge,
            alignment: Alignment.centerLeft,
            child: Text(item.getSuspensionTag(),
              style: headlineLargePrimary(context)
            ),
          ),
        ),
        GestureDetector(
          onTap: () => widget.onSelected(item),
          child: Container(
            padding: const EdgeInsets.fromLTRB(spacingSmall, spacingSmall, spacingSmall * 5, spacingSmall),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                icon(item.icon),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topText(item),
                    _middleText(item),
                    _bottomText(item),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //region _itemBuilder helpers
  Widget _topText(MyGroupedListItem item) {
    if (item.topText.isNullOrEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: _textWidth(item.icon.isNotNullNorEmpty),
      child: Text(item.topText!,
        style: titleMediumSecondary(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _middleText(MyGroupedListItem item) {
    return SizedBox(
      width: _textWidth(item.icon.isNotNullNorEmpty),
      child: Text(item.middleText,
        style: context.text.titleLarge,
        softWrap: true,
      ),
    );
  }

  Widget _bottomText(MyGroupedListItem item) {
    if (item.bottomText.isNullOrEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: _textWidth(item.icon.isNotNullNorEmpty),
      child: Text(item.bottomText!,
        style: titleMediumSecondary(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  double _textWidth(bool hasIcon) => context.media.size.width - (hasIcon ? spacingSmall * 5 : spacingSmall * 2) - (spacingSmall * 10);
  //endregion

  Widget _indexHintBuilder(BuildContext context, String tag) {
    return Container(
      width: 40, /// FAB size
      height: 40, /// FAB size
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.color.primary,
      ),
      child: Text(tag,
        style: TextStyle(
          color: context.color.onPrimary,
          fontSize: 20,
        ),
      ),
    );
  }

  IndexBarOptions _indexBarOptions() {
    return IndexBarOptions(
      needRebuild: true,
      indexHintAlignment: Alignment.centerRight,
      indexHintOffset: const Offset(-spacingMedium, 0),
      selectTextStyle: TextStyle(
        color: context.color.onPrimary,
      ),
      selectItemDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.color.primary,
      ),
    );
  }
}

class MyGroupedListItem extends ISuspensionBean {
  MyGroupedListItem({
    required this.id,
    this.topText,
    this.topEnum,
    this.icon,
    required this.middleText,
    this.bottomText,
    required this.tag,
  });

  final String id;
  final String? topText;
  final BaseEnum? topEnum;
  final String? icon;
  final String middleText;
  final String? bottomText;
  final String tag;

  @override
  String getSuspensionTag() => tag;

  MyGroupedListItem.fromMap(
    Map<String, dynamic> map,
    String idField,
    String? topTextField,
    BaseEnum? topEnumField,
    String? iconField,
    String middleTextField,
    String? bottomTextField,
  ) : this(
    id: map[idField]! as String,
    topText: map.valueOrNull(topTextField, enumerable: topEnumField),
    topEnum: topEnumField,
    icon: map.valueOrNull(iconField),
    middleText: map[middleTextField]! as String,
    bottomText: map.valueOrNull(bottomTextField),
    tag: (map.value(middleTextField, defaultValue: '#'))[0].toUpperCase(),
  );

  Map<String, Object?> toMap() => {};
}
