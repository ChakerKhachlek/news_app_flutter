import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/technologies/technologies_screen.dart';

import 'package:news_app/modules/videogames/videogames_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{


  NewsCubit() : super(NewsInitialState());

  static NewsCubit get (context) => BlocProvider.of(context);



  List pages=[
    BusinessScreen(),
    TechnologiesScreen(),
    VideoGamesScreen(),

  ];


List <BottomNavigationBarItem> bottomItem=[
  BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
  BottomNavigationBarItem(icon: Icon(Icons.biotech),label: 'Technologies'),
  BottomNavigationBarItem(icon: Icon(Icons.videogame_asset),label: 'Video Games'),

];

  int currentIndex=0;

  void NavBarPageChanged(index){
    currentIndex=index;
    emit(NewsBottomNavState());
    switch(index)
    {
      case 1 :
        getTechnologiesNews();
        break;
      case 2 :
        getGamingNews();
        break;
      case 3 :
        break;

    }

}

List<dynamic> businessNews=[];
List<dynamic> technologiesNews=[];
List<dynamic> gamingNews=[];


  void getBusinessNews(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'apiKey':'35fb7a9a4c734b29ba6fe28b4cb96ebf',
          'category':'business',
         'language':'en'
        }).then((value) {

          businessNews=value.data['articles'] ;
          print(businessNews.length);
          emit(NewsGetBusinessSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getTechnologiesNews(){
    if(technologiesNews.length ==0){
      emit(NewsGetTechnologiesLoadingState());
      DioHelper.getData(
          url: '/v2/everything',
          query: {
            'apiKey':'35fb7a9a4c734b29ba6fe28b4cb96ebf',
            'q':'technologies',
            'language':'en'
          }).then((value) {

        technologiesNews=value.data['articles'] ;
        print(technologiesNews.length);
        emit(NewsGetTechnologiesSuccessState());
      }).catchError((error){

        print(error.toString());
        emit(NewsGetGamingErrorState(error.toString()));
      });
    }else{
      emit(NewsGetTechnologiesSuccessState());
    }

  }

  void getGamingNews(){
    if(gamingNews.length ==0){
      emit(NewsGetGamingLoadingState());
      DioHelper.getData(
          url: '/v2/everything',
          query: {
            'apiKey':'35fb7a9a4c734b29ba6fe28b4cb96ebf',
            'q':'gaming',
            'language':'en'
          }).then((value) {

        gamingNews=value.data['articles'] ;
        print(gamingNews.length);
        emit(NewsGetGamingSuccessState());
      }).catchError((error){

        print(error.toString());
        emit(NewsGetGamingErrorState(error.toString()));
      });
    }else{
      emit(NewsGetGamingSuccessState());
    }
    }

  bool isDark = false;

   void switchAppMode({bool? fromShared}){
     if(fromShared != null){
       isDark=fromShared;
       emit(NewsChangeThemeModeState());
     }else
       {
         isDark= !isDark;
         CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
           emit(NewsChangeThemeModeState());
         });
       }



   }

}