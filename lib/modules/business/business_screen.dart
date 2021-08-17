import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){

        },
      builder: (context,state) {
         NewsCubit cubit=NewsCubit.get(context);
         var list =  cubit.businessNews ;
       return buildArticlesList(list: list,context : context,screen:0);
      },
        );


  }
}
