import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_observer.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBool(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessNews()..switchAppMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener : (context,state){

        },
        builder: (context,builder){
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600

                    ) ,
                    bodyText2: TextStyle(
                        color: Colors.black
                    )

                ),

                primarySwatch: Colors.pink,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.pink
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backwardsCompatibility: false,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),

                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    elevation: 20.0,
                    selectedItemColor: Colors.pink
                )
            ),

            darkTheme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600

                    ) ,
                    bodyText2: TextStyle(
                        color: Colors.white
                    )

                ),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  backgroundColor: Colors.black ,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black12,
                    statusBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: Colors.black,
                  ),

                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.black26,
                    elevation: 20.0,
                    selectedItemColor: Colors.pink,
                    unselectedItemColor: Colors.white
                ),
                bottomAppBarColor: Colors.black,
                scaffoldBackgroundColor: Colors.black26
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout( ),
          );
        },
      ),
    );
  }
}


