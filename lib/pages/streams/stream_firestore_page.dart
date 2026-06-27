import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g15/models/user_model.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Usuarios en tiempo real")),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: userReference.snapshots(),
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
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final UserModel u = UserModel.fromMap(userList[index]);
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text(u.name[0])),
                          title: Text(u.name),
                          subtitle: Text(
                            "${u.email} / ${u.createdAt.toString().substring(0, 11)}",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
