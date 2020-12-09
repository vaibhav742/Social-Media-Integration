import 'package:flutter/material.dart';
import 'package:socialmediaintegration/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;

  const HomePage({Key key, @required this.auth}) : super(key: key);

  Future<void> _signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () {
          _signOut();
        },
        child: Container(
          height: size.height * 0.08,
          decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(35.0)),
          child: Center(
              child: Text(
            'LogOut',
            style: TextStyle(fontSize: 23.0, color: Colors.white),
          )),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 23.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/images/pic.jpg'),
            ),
            SizedBox(height: size.height * 0.05),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 50.0,
                color: Colors.black,
              ),
              title: Material(
                elevation: 2.0,
                child: Container(
                  height: 40.0,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'Vaibhav Bhatt',
                    style: TextStyle(fontSize: 23.0),
                  )),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ListTile(
              leading: Icon(
                Icons.email,
                size: 50.0,
                color: Colors.black,
              ),
              title: Material(
                elevation: 2.0,
                child: Container(
                  height: 40.0,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'vbrocks6@gmail.com',
                    style: TextStyle(fontSize: 23.0),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
