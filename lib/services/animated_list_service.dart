import 'package:flutter/material.dart';
import 'package:jimmys/constants.dart';

typedef RemovedItemBuilder<T> = Widget Function(BuildContext context, Animation<double> animation, T item);

class AnimatedListService<E> {
  AnimatedListService(
    this.key,
    this.removedItemBuilder,
    initialItems,
  ) : items = List<E>.from(initialItems ?? <E>[]);
  
  final GlobalKey<AnimatedListState> key;
  final RemovedItemBuilder<E>? removedItemBuilder;
  final List<E> items;
  
  AnimatedListState? get _animatedList => key.currentState;

  void insert(int index, E item) {
    items.insert(index, item);
    _animatedList!.insertItem(index, duration: duration);
  }

  E removeAt(int index) {
    final E removedItem = items.removeAt(index);

    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          if (removedItemBuilder == null) return const SizedBox.shrink();

          return removedItemBuilder!(context, animation, removedItem);
        },
        duration: duration,
      );
    }

    return removedItem;
  }

  int get length => items.length;

  E operator [](int index) => items[index];

  int indexOf(E item) => items.indexOf(item);
}