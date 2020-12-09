import 'package:flutter/material.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialmediaintegration/components/background.dart';
import 'package:socialmediaintegration/pages/home_page.dart';
// import 'package:socialmediaintegration/constants.dart';
import 'package:socialmediaintegration/services/auth.dart';




class SignInPage extends StatefulWidget {
  final AuthBase auth;

  const SignInPage({Key key, @required this.auth}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {



  
  Future<void> _signInWithFacebook() async {
    try {
      await widget.auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

   final String clientID='78gyl02nt1iwjj';
  final String clientSecret='aDB4OhBdMS7K4sDt';
  final String redirectUrl='https://www.linkedin.com/in/vaibhav-bhatt-b361001a5/';

  @override
  void initState() {
    super.initState();
    LinkedInLogin.initialize(context,
      clientId: clientID,
      clientSecret: clientSecret,
      redirectUri: redirectUrl);
  }



getAccessToken(){
  LinkedInLogin.loginForAccessToken(
        destroySession: true,
        appBar: AppBar(
          title: Text('Profile'),
        ))
    .then((accessToken) => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(auth: widget.auth,)))
)
    .catchError((error) {
  print(error.errorDescription);
});
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Social Media Integration",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: RaisedButton(
                  onPressed: () {
                    getAccessToken();

                  },
                  color: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Text(
                    'Sign In With LinkedIn',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),

              // Container(
              //   height: 50.0,
              //   width: size.width - 30,
              //   decoration: BoxDecoration(
              //     color: Colors.grey[300],
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: AssetImage('assets/images/link.png')),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.05),

              

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: RaisedButton(
                  onPressed: () {
                    _signInWithFacebook();
                  },
                  color: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Text(
                    'Sign In With Facebook',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     _signInWithFacebook();
              //   },

              //   child: Container(
              //     height: 50.0,
              //     width: size.width - 30,
              //     decoration: BoxDecoration(
              //       color: Colors.grey[300],
              //       image: DecorationImage(
              //           fit: BoxFit.cover,
              //           image: AssetImage('assets/images/fb.png')),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}




