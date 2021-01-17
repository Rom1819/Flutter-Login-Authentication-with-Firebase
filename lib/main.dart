import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'screen/signup_screen.dart';
import 'models/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Authentication()),
      ],
      child: MaterialApp(
        title: 'Login App',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        home: LoginScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignupScreen.routeName : (ctx) => SignupScreen(),
          HomeScreen.routeName : (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
