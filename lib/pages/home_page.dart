import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // final db = FirebaseFirestore.instance;
  // CollectionReference userReference = db.collection("users");

  CollectionReference userReference = FirebaseFirestore.instance.collection(
    "users",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Consulta de todos los documentos
                await userReference.get().then((value) {
                  List<QueryDocumentSnapshot> docs = value.docs;
                  docs.forEach((user) {
                    print(user.data());
                  });
                });

                print("-------------------");

                // Consulta de un documento en específico
                await userReference.doc("user002").get().then((value) {
                  print(value.data());
                });
              },
              child: Text("Get data"),
            ),
          ],
        ),
      ),
    );
  }
}
