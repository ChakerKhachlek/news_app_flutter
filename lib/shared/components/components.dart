import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';

Widget buildArticleItem({
  required String title,
  required String? urlToImage,
  required String publishDate,
  context
}){
 return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image:  DecorationImage(
                  image: NetworkImage(urlToImage ?? 'https://s.france24.com/media/display/d1676b6c-0770-11e9-8595-005056a964fe/w:1280/p:16x9/news_1920x1080.png'),
                  fit: BoxFit.cover

              )
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(

                  child: Text(
                    title,
                    style : Theme.of(context).textTheme.bodyText1,
                    maxLines: 3 ,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  publishDate,
                  style : TextStyle(

                      color: Colors.grey
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildArticlesList({
  required List list,
  required context,
  required int screen
}){
  return list.length == 0 ? Center(child: CircularProgressIndicator()) :
RefreshIndicator(
  onRefresh: () async {
    NewsCubit cubit=NewsCubit.get(context);
      switch(screen){
        case 0 :
          cubit.businessNews=[];
          cubit.getBusinessNews();
              break;
        case 1 :
          cubit.technologiesNews=[];
          cubit.getTechnologiesNews();
          break;
        case 2 :
          cubit.gamingNews=[];
          cubit.getGamingNews();
          break;
      }
  },
  child:   ListView.separated(itemBuilder: (context,index){

  return buildArticleItem(
      title: list[index]['title'],
      urlToImage: list[index]['urlToImage'],
      publishDate: list[index]['publishedAt'],
      context: context
  );},
  
  separatorBuilder : (context,index) => SizedBox(height: 10.0,),
  
  itemCount: list.length,
  
  physics: BouncingScrollPhysics(
  
    
  
  ),),
);
}

