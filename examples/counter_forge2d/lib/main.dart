import 'package:counter_forge2d/game/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _CounterApp());
}

class _CounterApp extends StatelessWidget {
  const _CounterApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _CounterPage(),
    );
  }
}

class _CounterPage extends StatelessWidget {
  const _CounterPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: GameWidget.controlled(
        gameFactory: () => CounterGame(
          backgroundColor: theme.backgroundColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
