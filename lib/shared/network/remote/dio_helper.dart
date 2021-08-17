import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio ;

  static init ()
  {
    dio  = Dio(
        BaseOptions
        (
          baseUrl:'https://newsapi.org',
          receiveDataWhenStatusError: true,
        )
              ); //Dio

  }

  //Get Data from with Dio
 static Future<Response> getData({
  required String url,
  required Map<String,dynamic> query,
  })async{
   return await dio!.get(
       url,
       queryParameters: query,);
  }


}