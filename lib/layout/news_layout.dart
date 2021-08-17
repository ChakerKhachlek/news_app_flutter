import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, Object? state) {

        },
        builder: (BuildContext context, NewsStates state) {
          NewsCubit cubit = NewsCubit.get(context);
          return
           Scaffold(
            appBar: AppBar(
              title: Text('News app'),
              actions: [

                IconButton(onPressed: (){
                },
                icon: Icon(Icons.search)
                ),
                IconButton(onPressed: (){
                  cubit.switchAppMode();
                },
                    icon: Icon(
                        cubit.isDark ? Icons.brightness_4_outlined : Icons.brightness_6_outlined)
                ),

              ],
            ),
            body: cubit.pages[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.NavBarPageChanged(index);
              },
              items: cubit.bottomItem,
            ),
          );
        });
  }
}
