import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaintegration/pages/home_page.dart';
import 'package:socialmediaintegration/pages/sign_in_page.dart';
import 'package:socialmediaintegration/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  const LandingPage({Key key,@required this.auth}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

 

 
 @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: widget.auth.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          final User user=snapshot.data;
          if(user==null){
      return SignInPage(
        auth: widget.auth,
      );
    }
    return HomePage(
              auth: widget.auth,

    );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ),
        );
      },

    );
    
  }
}