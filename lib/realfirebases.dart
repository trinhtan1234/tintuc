import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DuLieuThuc extends StatelessWidget {
  DuLieuThuc({super.key});

  final DatabaseReference ref = FirebaseDatabase.instance.ref('features');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReltimeData'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return ListTile(
                  title: Text(snapshot.child('geometry').value.toString()),
                  subtitle: Text(snapshot.child('type').value.toString()),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              ref.child('10').update({
                'geometry': {
                  'latitude': 10.289789899,
                  'longitude': 106.928,
                },
                'type': 'Point100',
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
