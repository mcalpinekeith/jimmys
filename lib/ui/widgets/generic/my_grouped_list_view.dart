import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class MyGroupedListView extends StatefulWidget {
  const MyGroupedListView({
    super.key,
    required this.data,
    required this.idField,
    this.topTextField,
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
    final theme = Theme.of(context);

    _data = widget.data
      .map((_) => MyGroupedListItem.fromMap(
        _,
        widget.idField,
        widget.topTextField,
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
        indexBarOptions: _indexBarOptions(theme),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = _data[index];
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      children: [
        Offstage(
          offstage: !item.isShowSuspension,
          child: Container(
            height: spacingLarge,
            alignment: Alignment.centerLeft,
            child: Text(item.getSuspensionTag(),
              style: headlineLargePrimary(theme)
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
                icon(item.icon, theme),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topText(item, theme, width),
                    _middleText(item, theme, width),
                    _bottomText(item, theme, width),
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
  Widget _topText(MyGroupedListItem item, ThemeData theme, double width) {
    if (item.topText.isNullOrEmpty) return const SizedBox.shrink();

    width -= item.icon.isNullOrEmpty ? spacingSmall * 2 : spacingSmall * 5;

    return SizedBox(
      width: width - (spacingSmall * 10),
      child: Text(item.topText!,
        style: titleMediumSecondary(theme),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _middleText(MyGroupedListItem item, ThemeData theme, double width) {
    width -= item.icon.isNullOrEmpty ? spacingSmall * 2 : spacingSmall * 5;

    return SizedBox(
      width: width - (spacingSmall * 10),
      child: Text(item.middleText,
        style: theme.textTheme.titleLarge,
        softWrap: true,
      ),
    );
  }

  Widget _bottomText(MyGroupedListItem item, ThemeData theme, double width) {
    if (item.bottomText.isNullOrEmpty) return const SizedBox.shrink();

    width -= item.icon.isNullOrEmpty ? spacingSmall * 2 : spacingSmall * 5;

    return SizedBox(
      width: width - (spacingSmall * 10),
      child: Text(item.bottomText!,
        style: titleMediumSecondary(theme),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
  //endregion

  Widget _indexHintBuilder(BuildContext context, String tag) {
    final theme = Theme.of(context);

    return Container(
      width: 40, /// FAB size
      height: 40, /// FAB size
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primary,
      ),
      child: Text(tag,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontSize: 20,
        ),
      ),
    );
  }

  IndexBarOptions _indexBarOptions(ThemeData theme) {
    return IndexBarOptions(
      needRebuild: true,
      indexHintAlignment: Alignment.centerRight,
      indexHintOffset: const Offset(-spacingMedium, 0),
      selectTextStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
      ),
      selectItemDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class MyGroupedListItem extends ISuspensionBean {
  MyGroupedListItem({
    required this.id,
    this.topText,
    this.icon,
    required this.middleText,
    this.bottomText,
    required this.tag,
  });

  final String id;
  final String? topText;
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
    String? iconField,
    String middleTextField,
    String? bottomTextField,
  ) : this(
    id: map[idField]! as String,
    topText: map.value(topTextField, null),
    icon: map.value(iconField, null),
    middleText: map[middleTextField]! as String,
    bottomText: map.value(bottomTextField, null),
    tag: (map.value(middleTextField, '#'))[0].toUpperCase(),
  );

  Map<String, Object?> toMap() => {};
}
