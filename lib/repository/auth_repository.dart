
import 'package:mvvm/data/network/BaseAPiServices.dart';
import 'package:mvvm/data/network/NetworkApiServices.dart';
import 'package:mvvm/res/app_url.dart';

class AuthRepository{

  BaseApiServices _apiServices = Networkapiservices();

  // Login  POST Api
  Future<dynamic>loginApi(dynamic data)async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrlEndPoint, data);
      return response;

    }catch(e){
      throw e;
    }

  }

  //SignUp POST Api
  Future<dynamic>signUpApi(dynamic data)async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerUrlEndPoint, data);
      return response;

    }catch(e){
      throw e;
    }

  }

}