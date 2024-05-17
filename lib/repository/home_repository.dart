import 'package:mvvm/model/movie_model.dart';

import '../data/network/BaseAPiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class HomeRepository {

  BaseApiServices _apiServices = Networkapiservices();

  // Movie List GET Api
  Future<MovieListModel>fetchMovieList()async{

    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e;
    }

  }




}