import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utlis/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Provider State
    final userPreference = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RoundButton(
                title: "Logout",
                onPress: () {
                  userPreference.remove().then((value){
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
