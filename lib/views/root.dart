import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/home.dart';
import 'package:graduation_thesis_project/utils/session.dart';
import 'package:graduation_thesis_project/views/setting_screen/login.dart';

enum AuthStatus{
  signIn,
  notSignIn
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SessionManager().getAuthToken().then((value){
      print(value);
      setState(() {
        value == null ? _authStatus = AuthStatus.notSignIn : _authStatus = AuthStatus.signIn;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.signIn :
        return const Home();
      case AuthStatus.notSignIn :
        return Login();
    }

  }
}
