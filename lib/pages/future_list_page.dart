import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g15/models/user_model.dart';
import 'package:flutter/material.dart';

class FutureListPage extends StatelessWidget {
  CollectionReference userReference = FirebaseFirestore.instance.collection(
    "users",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: userReference.get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> docs = querySnapshot.docs;
                List<UserModel> userModelList = docs.map((doc) {
                  return UserModel.fromMap(doc.data() as Map<String, dynamic>);
                }).toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: userModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text(userModelList[index].name),
                          subtitle: Text(userModelList[index].age.toString()),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
