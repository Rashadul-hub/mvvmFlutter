import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utlis/general_utils.dart';
import 'package:mvvm/utlis/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Text Controller for Store users Strings
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Focus Node for Keyboard
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  //For show / hide the user password
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);


  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obscurePassword.dispose();
  }


  //"email": "eve.holt@reqres.in",
  //"password": "cityslicka"

  @override
  Widget build(BuildContext context) {

    //Provider State
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Login'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //Email Text Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
              decoration: const InputDecoration(
                  hintText: 'E-mail',
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined)),
            ),

            //Password Text Field
            ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: passwordFocusNode,
                    obscureText: _obscurePassword.value,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_outlined),
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                        child: Icon(_obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                  );
                }),


            SizedBox(height: height* .08,),

            //Reusable Component Button
            RoundButton(
                title: 'Login',
                loading: authViewModel.logInLoading,

                onPress: (){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please Enter Email', context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please Enter Password', context);
                  }else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Password Should be Minimum 6 digit', context);
                  }else{

                    //Main Code
                    // Map data ={
                    //   //This 'email' & 'password' name should be same as from api
                    //   'email' : _emailController.text.toString(),
                    //   'password' : _passwordController.text.toString(),
                    // };

                    Map data ={
                       'email' : 'eve.holt@reqres.in',
                      'password' : 'cityslicka',
                    };

                    authViewModel.loginApi(data,context);
                    print('Api Hit');
                  }

                }
            ),

            SizedBox(height: height* .02,),

            InkWell(onTap: (){
              Navigator.pushNamed(context, RoutesName.signUp);
            },child: Text("Don't have an account? Click here for Sign Up",style:TextStyle(decoration: TextDecoration.underline),)),
          ],
        ),
      ),
    );
  }
}
