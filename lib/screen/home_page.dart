import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'instagram clone',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Instagram 오신것을 환영합니다.',
                  style: TextStyle(fontSize: 24),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Text('사진과 동영상을 보려면 팔로우 하세요.'),
                Padding(padding: EdgeInsets.all(16)),
                SizedBox(
                  width: 260,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(4)),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              user.photoURL ?? 'https://dimg.donga.com/wps/SPORTS/IMAGE/2023/10/16/121685695.1.jpg',
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(16)),
                        Text(
                          user.email ?? "이메일",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(user.displayName ?? "사용자 이름"),
                        Padding(padding: EdgeInsets.all(16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.network(
                                'https://dimg.donga.com/wps/SPORTS/IMAGE/2023/10/16/121685695.1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1)),
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.network(
                                'https://dimg.donga.com/wps/SPORTS/IMAGE/2023/10/16/121685695.1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1)),
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.network(
                                'https://dimg.donga.com/wps/SPORTS/IMAGE/2023/10/16/121685695.1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                        Text('facebook 친구'),
                        Padding(padding: EdgeInsets.all(4)),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '팔로우',
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent)),
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
