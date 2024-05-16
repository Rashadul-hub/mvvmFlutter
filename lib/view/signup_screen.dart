import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utlis/general_utils.dart';
import '../utlis/routes/routes_name.dart';
import '../view_model/auth_view_model.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

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

    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sing Up'),
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
                  hintText: 'Enter your E-mail',
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
                      hintText: 'Set Your Password',
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
                title: 'Create Account',
                loading: authViewModel.signUpLoading,

                onPress: (){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please Enter Email', context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please Enter Password', context);
                  }else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Password Should be Minimum 6 digit', context);
                  }else{

                    Map data ={
                      //This 'email' & 'password' name should be same as from api
                      'email' : _emailController.text.toString(),
                      'password' : _passwordController.text.toString(),
                    };

                    authViewModel.signUpApi(data, context);
                    print('Api Hit');
                  }

                }
            ),

            SizedBox(height: height* .02,),

            InkWell(onTap: (){
              Navigator.pushNamed(context, RoutesName.login);
            },child: Text("Already have an account? Click for Login",style:TextStyle(decoration: TextDecoration.underline),)),
          ],
        ),
      ),
    );
  }
}
