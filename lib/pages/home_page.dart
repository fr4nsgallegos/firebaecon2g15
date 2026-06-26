import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g15/models/user_model.dart';
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
                  // docs.forEach((user) {
                  //   print(user.data());
                  // });
                  List<UserModel> userModelList = docs.map((doc) {
                    return UserModel.fromMap(
                      doc.data() as Map<String, dynamic>,
                    );
                  }).toList();

                  userModelList.forEach((userModel) {
                    print("*****************");
                    print(userModel.name);
                    print(userModel.createdAt);
                    print(userModel.email);
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
            ElevatedButton(
              onPressed: () async {
                userReference
                    .where("age", isLessThan: 45)
                    .where("gender", isEqualTo: "F")
                    .get()
                    .then((value) {
                      List<QueryDocumentSnapshot> docs = value.docs;
                      List<UserModel> userModelList = docs.map((element) {
                        return UserModel.fromMap(
                          element.data() as Map<String, dynamic>,
                        );
                      }).toList();

                      userModelList.forEach((usuario) {
                        print("******************");
                        print(usuario.name);
                        print(usuario.email);
                        print(usuario.age);
                        print(usuario.gender);
                        print(usuario.createdAt);
                      });
                    });
              },
              child: Text("Obtener información filtrada"),
            ),
          ],
        ),
      ),
    );
  }
}
