
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/utlis/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';

import '../../model/user_model.dart';

class SplashServices{

  Future<UserModel> getUserDate() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async{

    getUserDate().then((value)async{

      if(value.token == 'null' || value.token == ''){

        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);

      }else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);

      }


    }).onError((error, stackTrack){

      if(kDebugMode){
        print(error.toString());
      }

    });

  }



}