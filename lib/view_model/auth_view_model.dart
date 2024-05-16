
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utlis/general_utils.dart';
import 'package:mvvm/utlis/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();

  bool _logInLoading = false;
  bool get logInLoading => _logInLoading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;






  setLoadingForLogIn(bool value){
    _logInLoading = value;
    notifyListeners();
  }

  setLoadingForSignUp(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  //Handel view Model For LogIn Screen
  Future<void> loginApi(dynamic data, BuildContext context)async{

    //Show Loading Circular
    setLoadingForLogIn(true);
    
    _myRepo.loginApi(data).then((value){

      setLoadingForLogIn(false);


      //Go To Next Screen After Login Successful.
      Navigator.pushNamed(context, RoutesName.home);
      Utils.flushBarErrorMessage('Login Successfully', context);

      if (kDebugMode) {

        print(value.toString());
      }

    }).onError((error, stackTrace){

      setLoadingForLogIn(false);
      Utils.flushBarErrorMessage(error.toString(), context);

      if (kDebugMode) {
        print(error.toString());
      }
    });

  }


  Future<void> signUpApi(dynamic data, BuildContext context)async{

    //Show Loading Circular
    setLoadingForSignUp(true);

    _myRepo.signUpApi(data).then((value){

      setLoadingForSignUp(false);


      //Go To Next Screen After SignUp Successful.
      Navigator.pushNamed(context, RoutesName.home);
      Utils.flushBarErrorMessage('Sign Up Successfully', context);

      if (kDebugMode) {

        print(value.toString());
      }

    }).onError((error, stackTrace){

      setLoadingForSignUp(false);
      Utils.flushBarErrorMessage(error.toString(), context);

      if (kDebugMode) {
        print(error.toString());
      }
    });

  }


}