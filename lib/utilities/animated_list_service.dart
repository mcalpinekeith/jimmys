import 'package:flutter/material.dart';
import 'package:jimmys/ui/theme/constants.dart';

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
  
  AnimatedListState? get animatedItems => key.currentState;

  void insert(int index, E item) {
    items.insert(index, item);

    if (animatedItems != null) {
      animatedItems!.insertItem(index, duration: duration);
    }
  }

  E removeAt(int index) {
    final E removedItem = items.removeAt(index);

    if (animatedItems != null && removedItem != null) {
      animatedItems!.removeItem(
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

  removeAll() {
    items.clear();

    if (animatedItems != null) {
      animatedItems!.removeAllItems((BuildContext context, Animation<double> animation) {
        return const SizedBox.shrink();
      });
    }
  }

  int get length => items.length;

  E operator [](int index) => items[index];

  int indexOf(E item) => items.indexOf(item);
}