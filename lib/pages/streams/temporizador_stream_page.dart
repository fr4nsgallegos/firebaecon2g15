import 'package:flutter/material.dart';

class TemporizadorStreamPage extends StatelessWidget {
  Stream<int> temportizador() async* {
    int segundos = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield ++segundos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: temportizador(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "Segundos: ${snapshot.data}",
                    style: TextStyle(fontSize: 30),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
