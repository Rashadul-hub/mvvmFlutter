import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utlis/routes/routes_name.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_screen.dart';
import 'package:mvvm/view/signup_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
