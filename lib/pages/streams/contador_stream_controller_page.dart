import 'dart:async';

import 'package:flutter/material.dart';

class ContadorStreamControllerPage extends StatefulWidget {
  @override
  State<ContadorStreamControllerPage> createState() =>
      _ContadorStreamControllerPageState();
}

class _ContadorStreamControllerPageState
    extends State<ContadorStreamControllerPage> {
  final StreamController<int> _streamController = StreamController<int>();

  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    _streamController.sink.add(_counter);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: _streamController.stream,
              initialData: _counter,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(
                  "Valor: ${snapshot.data ?? 0}",
                  style: TextStyle(fontSize: 35),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter();
              },
              child: Text("Incrementar contador"),
            ),
          ],
        ),
      ),
    );
  }
}
