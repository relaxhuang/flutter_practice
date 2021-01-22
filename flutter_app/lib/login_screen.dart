import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/login-logo.png'),
      ),
    );

    final logoLabel = Text(
      'U-MING Digital Platform',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0, color: Colors.indigo[900]),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'relax0914@gmail.com',
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(HomeScreen.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.teal,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    return Container (

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login-main-bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold (
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 0),
            children: <Widget>[
              logo,
              SizedBox(height: 5.0),
              logoLabel,
              SizedBox(height: 150.0),
              email,
              SizedBox(height: 25.0),
              password,
              SizedBox(height: 40.0),
              loginButton,
            ],
          ),
        ),
      ),
    );
  }
}