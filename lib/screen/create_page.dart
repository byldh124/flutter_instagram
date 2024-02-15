import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePage extends StatefulWidget {
  final User user;

  const CreatePage({super.key, required this.user});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var textEditingController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [IconButton(onPressed: send, icon: const Icon(Icons.send))],
    );
  }

  Future<void> send() async {
    if (_image != null) {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('post')
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      var task = await firebaseStorageRef.putFile(
          _image!, SettableMetadata(contentType: 'image/png'));

      final uri = await task.ref.getDownloadURL();

      final doc = FirebaseFirestore.instance.collection('post').doc();

      await doc.set({
        'id': doc.id,
        'photoUrl': uri.toString(),
        'contents': textEditingController.text,
        'email': widget.user.email,
        'displayName': widget.user.displayName,
        'userPhotoUrl': widget.user.photoURL,
      }).then((_) {
        Navigator.pop(context);
      });
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _image == null ? const Text('No Image') : Image.file(_image!),
          TextField(
            decoration: const InputDecoration(hintText: '내용을 입력하세요.'),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
