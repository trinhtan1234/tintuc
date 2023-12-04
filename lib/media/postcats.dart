import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Postcats extends StatefulWidget {
  const Postcats({super.key});

  @override
  State<Postcats> createState() => _PostcatsState();
}

class _PostcatsState extends State<Postcats> {
  final CollectionReference dataMedia =
      FirebaseFirestore.instance.collection('dataMedia');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> addMedia() async {
    try {
      await dataMedia.add({
        'id': _nameController.text,
        'mota': _nameController.text,
        'tieude': _nameController.text,
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'id'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'mota'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: addMedia,
            child: const Text('Add Media'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: dataMedia.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Text(document['id']),
                      subtitle: Text('Mota: ${document['mota']}'),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
