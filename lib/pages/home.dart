import 'package:flutter/material.dart';
import 'package:jimmys/functions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(theme, 'Jimmy\'s Gym'),
      body: const SafeArea(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
