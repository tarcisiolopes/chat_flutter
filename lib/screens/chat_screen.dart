import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Sair'),
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (item) {
                  if (item == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                }),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, i) => Container(
              padding: EdgeInsets.all(10),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('chat').add({
            'text': 'Adicionado Manualmente!',
          });
        },
      ),
    );
  }
}
