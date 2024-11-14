// File: lib/screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('profile/dapa ganteng.jpg'), // Path ke gambar Anda
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Nama'),
                      subtitle: Text('Daffa Faris Abqari Ramdhani'),
                      leading: Icon(Icons.person),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('NIM'),
                      subtitle: Text('152022196'),
                      leading: Icon(Icons.numbers),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
