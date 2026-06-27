import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g15/models/user_model.dart';
import 'package:firebaseconn2g15/pages/streams/stream_firestore_page.dart';
import 'package:firebaseconn2g15/pages/streams/temporizador_stream_page.dart';
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
                    .where("age", isLessThan: 24)
                    .where("gender", isEqualTo: "M")
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
            ElevatedButton(
              onPressed: () {
                // AGREGAR UN USUARIO DESDE UN MAP
                // userReference
                //     .add({
                //       "name": "Lucas",
                //       "email": "luqui@gmail.com",
                //       "gender": "M",
                //       "age": 22,
                //       "createdAt": Timestamp.now(),
                //     })
                //     .then((value) {
                //       print("Usuario agregado correcamente");
                //       print(value);
                //       print(value.id);
                //     })
                //     .catchError((error) {
                //       print("Error al agregar el usuario: $error");
                //     });

                // AGREGAR USUARIO DESDE UN USERMODEL
                UserModel newUser = UserModel(
                  name: "Carlos",
                  email: "cARLITOS@gmail.com",
                  age: 15,
                  gender: "M",
                  createdAt: DateTime.now(),
                );

                userReference
                    .add(newUser.toMap())
                    .then((value) {
                      print("Usuario agregado correcamente");
                      print(value);
                      print(value.id);
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
              },
              child: Text("Agregar un usuario"),
            ),

            ElevatedButton(
              onPressed: () {
                UserModel newUser = UserModel(
                  name: "Melisa Losa",
                  email: "Meli@gmail.com",
                  age: 35,
                  gender: "F",
                  createdAt: DateTime.now(),
                );
                userReference
                    .doc("uid0010")
                    // .set({"nacionality": "Peruana"}) //chanca la info si encuentra el id
                    .set(newUser.toMap())
                    .then((value) {
                      print("Usuario agregado con el id específico");
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
                ;
              },
              child: Text("Agregando usuario con id específico"),
            ),

            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("user002")
                    .update({"email": "peruana@gfmaol.com"})
                    .then((value) {
                      print("Usuario actualizado correctamente");
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
              },
              child: Text("Actualizar un usuario"),
            ),

            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("GlvfVZcPuD3eZZ7rK6OL")
                    .delete()
                    .then((value) {
                      print("Usuario eliminado correctamente");
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
                ;
              },
              child: Text("Eliminar un usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamFirestorePage(),
                  ),
                );
              },
              child: Text("Streams Page"),
            ),
          ],
        ),
      ),
    );
  }
}
