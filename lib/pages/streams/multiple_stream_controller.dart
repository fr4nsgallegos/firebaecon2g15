import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MultipleStreamController extends StatefulWidget {
  @override
  State<MultipleStreamController> createState() =>
      _MultipleStreamControllerState();
}

class _MultipleStreamControllerState extends State<MultipleStreamController> {
  StreamController<int> streamController1 = StreamController<int>();

  StreamController<int> streamController2 = StreamController<int>();

  StreamController<int> streamController3 = StreamController<int>.broadcast();

  int _counter1 = 0;

  int _counter2 = 0;

  int _counter3 = 0;

  void _incrementCounter1() {
    _counter1++;
    streamController1.sink.add(_counter1);
  }

  void _incrementCounter2() {
    _counter2++;
    streamController2.sink.add(_counter2);
  }

  void _incrementCounter3() {
    _counter3++;
    streamController3.sink.add(_counter3);
  }

  @override
  void dispose() {
    streamController1.close();
    streamController2.close();
    streamController3.close();
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
              stream: streamController1.stream,
              initialData: _counter1,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: Text(
                    "Stream 1: ${snapshot.data}",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter1();
              },
              child: Text("Incrementar Stream 1"),
            ),
            StreamBuilder(
              stream: streamController2.stream,
              initialData: _counter2,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: Text(
                    "Stream 2: ${snapshot.data}",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter2();
              },
              child: Text("Incrementar Stream 2"),
            ),
            StreamBuilder(
              stream: streamController3.stream,
              initialData: _counter3,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: Text(
                    "Stream 3: ${snapshot.data}",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter3();
              },
              child: Text("Incrementar Stream 3"),
            ),

            Divider(),

            StreamBuilder(
              stream: streamController3.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: LinearProgressIndicator(
                    value: (snapshot.data ?? 0) / 10,
                  ),
                );
              },
            ),

            StreamBuilder(
              stream: streamController3.stream,
              builder: (context, snapshot) {
                if ((snapshot.data ?? 0) >= 10) {
                  return Text("Stream 3 llego a 10!!!");
                }
                return Text("Progreso: ${snapshot.data ?? 0}/10");
              },
            ),
          ],
        ),
      ),
    );
  }
}
