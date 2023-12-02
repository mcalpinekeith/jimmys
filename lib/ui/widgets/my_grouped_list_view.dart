import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/utilities/functions.dart';

class MyGroupedListView extends StatefulWidget {
  const MyGroupedListView({
    Key? key,
    required this.data,
    required this.idField,
    this.pretextField,
    this.iconField,
    required this.textField,
    this.posttextField,
    this.padding = const EdgeInsets.symmetric(vertical: spacingMicro, horizontal: spacingMedium),
    required this.onSelected,
  }) : super(key: key);

  final List<Map<String, dynamic>> data;
  final String idField;
  final String? iconField;
  final String? pretextField;
  final String textField;
  final String? posttextField;
  final EdgeInsetsGeometry padding;
  final Function onSelected;

  @override
  State<MyGroupedListView> createState() => _MyGroupedListViewState();
}

class _MyGroupedListViewState extends State<MyGroupedListView> {
  late List<MyGroupedListItem> _data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    _data = widget.data
      .map((_) => MyGroupedListItem.fromMap(
        _,
        widget.idField,
        widget.pretextField,
        widget.iconField,
        widget.textField,
        widget.posttextField,
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
        itemBuilder: (context, index) {
          final item = _data[index];
          final tag = item.getSuspensionTag();
          final offstage = !item.isShowSuspension;

          return Column(
            children: <Widget>[
              Offstage(
                offstage: offstage,
                child: Container(
                  height: spacingLarge,
                  alignment: Alignment.centerLeft,
                  child: Text(tag, style: getHeadlineLargePrimary(theme)),
                ),
              ),
              _createListTile(item, theme, width),
            ],
          );
        },
        indexHintBuilder: (context, tag) => Container(
          width: 40,
          // FAB size
          height: 40,
          // FAB size
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary,
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 20,
            ),
          ),
        ),
        indexBarItemHeight: spacingMedium,
        hapticFeedback: true,
        indexBarMargin: const EdgeInsets.all(spacingSmall),
        indexBarOptions: IndexBarOptions(
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
        ),
      ),
    );
  }

  Widget _createListTile(MyGroupedListItem item, ThemeData theme, double width) {
    return GestureDetector(
      onTap: () => widget.onSelected(item),
      child: Container(
        padding: const EdgeInsets.fromLTRB(spacingSmall, spacingSmall, spacingSmall * 5, spacingSmall),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            createIconWithPadding(item.icon, theme),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _createPretext(item, theme, width),
                _createText(item, theme, width),
                _createPosttext(item, theme, width),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createPretext(MyGroupedListItem item, ThemeData theme, double width) {
    if (item.pretext == null) return const SizedBox.shrink();

    width -= item.icon == null ? spacingSmall * 2 : spacingSmall * 5;

    return SizedBox(
      width: width - (spacingSmall * 10),
      child: Text(
        item.pretext!,
        style: getTitleMediumSecondary(theme),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _createText(MyGroupedListItem item, ThemeData theme, double width) {
    width -= item.icon == null ? spacingSmall * 2 : spacingSmall * 5;

    return SizedBox(
      width: width - (spacingSmall * 10),
      child: Text(
        item.text,
        style: theme.textTheme.titleLarge,
        softWrap: true,
      ),
    );
  }

  Widget _createPosttext(MyGroupedListItem item, ThemeData theme, double width) {
    if (item.posttext == null) return const SizedBox.shrink();

    width -= item.icon == null ? spacingSmall * 2 : spacingSmall * 5;

    return SizedBox(
      width: width - (spacingSmall * 10),
      child: Text(
        item.posttext!,
        style: getTitleMediumSecondary(theme),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class MyGroupedListItem extends ISuspensionBean {
  MyGroupedListItem({
    required this.id,
    this.pretext,
    this.icon,
    required this.text,
    this.posttext,
    required this.tag,
  });

  final String id;
  final String? pretext;
  final String? icon;
  final String text;
  final String? posttext;
  final String tag;

  @override
  String getSuspensionTag() => tag;

  MyGroupedListItem.fromMap(
    Map<String, dynamic> map,
    String idField,
    String? pretextField,
    String? iconField,
    String textField,
    String? posttextField,
  ) : this(
    id: map[idField]! as String,
    pretext: pretextField == null || !map.containsKey(pretextField) || map[pretextField] == null ? null : map[pretextField]! as String,
    icon: iconField == null || !map.containsKey(iconField) || map[iconField] == null ? null : map[iconField]! as String,
    text: map[textField]! as String,
    posttext: posttextField == null || !map.containsKey(posttextField) || map[posttextField] == null ? null : map[posttextField]! as String,
    tag: (map[textField]! as String)[0].toUpperCase(),
  );

  Map<String, Object?> toMap() {
    return {};
  }
}
