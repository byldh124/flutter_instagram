import 'package:flutter/material.dart';

import 'create_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildListItem(context, index);
          }),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Image.network(
      'https://dimg.donga.com/wps/SPORTS/IMAGE/2023/10/16/121685695.1.jpg',
      fit: BoxFit.cover,
    );
  }
}
