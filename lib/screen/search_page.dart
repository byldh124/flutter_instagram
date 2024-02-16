import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_insta_clone/screen/detail_post_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_page.dart';

class SearchPage extends StatefulWidget {
  final User user;

  const SearchPage({super.key, required this.user});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreatePage(
                        user: widget.user,
                      )));
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder (
        stream: FirebaseFirestore.instance.collection('post').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            var items = snapshot.data?.docs ?? [];
            return Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(context, items[index]);
                  }),
            );
          }
        }
    );
  }

  Widget _buildListItem(BuildContext context, document) {
    return Hero(
      tag: document['photoUrl'],
      child: Material(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPostPage(document: document);
            }));
          },
          child: Image.network(
            document['photoUrl'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
