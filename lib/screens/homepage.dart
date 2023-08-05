import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    List<String> docID = [];

    // get docId's
    Future getDocsId() async {
      await FirebaseFirestore.instance.collection('user').get().then(
            (snapshot) => snapshot.docs.forEach(
              (document) {
                print(document.reference);
                docID.add(document.reference.id);
              },
            ),
          );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Signed in as: ${user.email!}',
              style: const TextStyle(color: Colors.black),
            ),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.blue[200],
              child: const Text('Sign Out'),
            ),
            Expanded(
              child: FutureBuilder(
                future: getDocsId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docID.length,
                    itemBuilder: (context, index) => 
                    ListTile(
                      title: Text(docID[index]),
                    ),
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
