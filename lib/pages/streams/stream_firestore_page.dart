import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g15/models/user_model.dart';
import 'package:firebaseconn2g15/pages/streams/contador_stream_controller_page.dart';
import 'package:firebaseconn2g15/pages/streams/temporizador_stream_page.dart';
import 'package:flutter/material.dart';

// Errores comunes al usar StreamBuider
// Si usamos StreamBuilder, ya no es necesario usar SetState para refrescar la lista, el Stream lo hace solo
// Evitar usar snapshot() dentro de build, lo mejor es definir un Steam una vez en statefullwidget
// Si hacemos un order o un where, firebase puede solicitar un índice, estar atentos al error que se genera para poder ir al enlace y generar el indice en firestore

class StreamFirestorePage extends StatelessWidget {
  final CollectionReference userReference = FirebaseFirestore.instance
      .collection("users");

  final userRefTipada = FirebaseFirestore.instance
      .collection("users")
      .withConverter(
        fromFirestore: (snapshot, options) => UserModel.fromFirestore(snapshot),
        toFirestore: (value, options) => value.toMap(),
      );

  Stream<QuerySnapshot<UserModel>> watchUsers() {
    return userRefTipada.orderBy("createdAt", descending: true).snapshots();
  }

  final settingsReference = FirebaseFirestore.instance
      .collection("settings")
      .doc("app");

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchSettings() {
    return settingsReference.snapshots();
  }

  Future<void> addUser() async {
    final user = UserModel(
      name: "Juanito",
      email: "juan@tges.com",
      age: 65,
      gender: "M",
      createdAt: DateTime.now(),
    );

    await userRefTipada.add(user);
  }

  Future<void> updateUser(String docId) async {
    await userRefTipada.doc(docId).update({"name": "Nombre actualizado"});
  }

  Future<void> deleteUser(String docId) async {
    await userRefTipada.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Usuarios en tiempo real")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: StreamBuilder(
                //esta manera trae la info en forma de Map, por lo que hay que hacer un fromMap para traducirlo a un UserModel
                // stream: userReference.snapshots(),

                // Esta forma, trae la información en forma de UserModel, ya no hay que tranformar nada
                stream: watchUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final List docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return Center(child: Text("No hay usuarios"));
                  }

                  final userList = docs.map((e) => e.data()).toList();

                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //transformamos la info porque se trae en forma de Map
                      // final UserModel u = UserModel.fromMap(userList[index]);

                      // Trabajamos con la info directamente porque ya lo trae como UserModel
                      final UserModel u = userList[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text(u.name[0])),
                          title: Text(u.name),
                          subtitle: Text(
                            "${u.email} / ${u.createdAt.toString().substring(0, 11)}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  updateUser(u.id!);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteUser(u.id!);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  //  Ejemplo con Listview Separated
                  // return ListView.separated(
                  //   separatorBuilder: (context, index) => Divider(height: 1),
                  //   itemCount: userList.length,
                  //   itemBuilder: (context, index) {
                  //     final UserModel u = UserModel.fromMap(userList[index]);
                  //     return Card(
                  //       child: ListTile(
                  //         leading: CircleAvatar(child: Text(u.name[0])),
                  //         title: Text(u.name),
                  //         subtitle: Text(
                  //           "${u.email} / ${u.createdAt.toString().substring(0, 11)}",
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: StreamBuilder(
                  stream: watchSettings(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.data!.data();
                    if (data == null) return Text("No existe el documento");

                    final enMatenimiento =
                        (data["enMantenimiento"] ?? false) as bool;

                    return Text(
                      "Modo de mantenimiento: $enMatenimiento",
                      style: TextStyle(fontSize: 25),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContadorStreamControllerPage(),
                        ),
                      );
                    },
                    child: Text("Contador Stream Page"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TemporizadorStreamPage(),
                        ),
                      );
                    },
                    child: Text("Temporizador Stream Page"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
