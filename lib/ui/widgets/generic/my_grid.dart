import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/core/extensions/build_context.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/utilities/animated_list_service.dart';
import 'package:jimmys/utilities/icon_service.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({
    super.key,
    required this.gridKey,
    required this.gridList,
    this.padding = const EdgeInsets.symmetric(vertical: spacingMicro, horizontal: spacingMedium),
    required this.controller,
    required this.onSelected,
  });

  final GlobalKey<AnimatedListState> gridKey;
  final AnimatedListService<IconItem> gridList;
  final EdgeInsetsGeometry padding;
  final AutoScrollController controller;
  final Function(String) onSelected;

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width ~/ 50;

    return Padding(
      padding: widget.padding,
      child: AnimatedGrid(
        controller: widget.controller,
        key: widget.gridKey,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacingMicro,
          crossAxisSpacing: spacingMicro,
        ),
        initialItemCount: widget.gridList.length,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    final item = widget.gridList[index];

    return AutoScrollTag(
      key: ValueKey(index),
      controller: widget.controller,
      index: index,
      child: SizeTransition(
        sizeFactor: animation,
        child: IconButton(
          iconSize: iconMedium,
          color: item.isSelected ? context.colorScheme.primary : context.colorScheme.secondary,
          icon: FaIcon(item.icon!),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            side: BorderSide(
              color: item.isSelected ? context.colorScheme.primary : Colors.transparent,
            )
          ),
          onPressed: () => _iconOnPressed(index, item),
        ),
      ),
    );
  }

  void _iconOnPressed(int index, IconItem item) {
    setState(() {
      for (var i = 0; i < widget.gridList.items.length; i++) {
        widget.gridList[i].isSelected = i == index ? !widget.gridList[i].isSelected : false;
      }
    });

    widget.onSelected(IconService.getIconUnicode(item.icon!));
  }
}

/*
  ChoiceChip _choiceChip(Widget label, int index, ThemeData theme) {
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
