import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/constants.dart';
import 'package:jimmys/services/animated_list_service.dart';
import 'package:jimmys/services/icon_service.dart';
import 'package:jimmys/types.dart';
import 'package:jimmys/widgets/my_card.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({
    Key? key,
    this.initialValue,
    required this.gridKey,
    required this.gridList,
    this.padding = const EdgeInsets.symmetric(vertical: spacingMicro, horizontal: spacingMedium),
    required this.onSelected,
  }) : super(key: key);

  final String? initialValue;
  final GlobalKey<AnimatedListState> gridKey;
  final AnimatedListService<IconItem> gridList;
  final EdgeInsetsGeometry padding;
  final StringToVoidFunc onSelected;

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> with TickerProviderStateMixin {
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue == null && _selectedIndex == -1) _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    final crossAxisCount = width ~/ 50;

    return Padding(
      padding: widget.padding,
      child: AnimatedGrid(
        key: widget.gridKey,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          //mainAxisSpacing: spacingMedium,
          //crossAxisSpacing: spacingMedium,
        ),
        initialItemCount: widget.gridList.length,
        itemBuilder: (BuildContext context, int index, Animation<double> animation) {
          final item = widget.gridList[index];

          return MyCard(
            animation: animation,
            child: FaIcon(item.icon!,
              color: item.isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.secondary,
              size: iconMedium,
            ),
          );
        },
      ),
    );
  }
}

/*
  ChoiceChip _createChoiceChip(Widget label, int index, ThemeData theme) {
    return ChoiceChip(
      //avatar:
      label: label,
      //labelStyle:
      //labelPadding:
      selected: _selectedIndex == index,
      onSelected: (bool selected) {
        setState(() {
          _selectedIndex = selected ? index : 0;
        });
        
        //widget.onSelected(_children.keys.elementAt(index));
      },
      selectedColor: theme.colorScheme.primary,
      disabledColor: theme.colorScheme.shadow,
      side: BorderSide(color: theme.colorScheme.primary),
      //shape:
      //padding:
      elevation: theme.popupMenuTheme.elevation,
      //iconTheme: 
      showCheckmark: false,
    );
  }
*/
