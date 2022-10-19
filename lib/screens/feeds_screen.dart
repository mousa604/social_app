import 'dart:ffi';

import 'package:face_app/cubit/cubit/cubit.dart';
import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/models/postModel.dart';
import 'package:face_app/styles/icons_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){},
      builder: (context,state){
        return Conditional.single(
          context: context,
          widgetBuilder:(context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),

            child: Column(
              children: [
                Card(
                  elevation: 10,
                  margin: EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(image:
                      NetworkImage('https://img.freepik.com/free-photo/satisfied-student-posing-against-pink-wall_273609-20219.jpg?t=st=1656973940~exp=1656974540~hmac=2fbc7d0d3f480493000133a274b95c5ec46df590cdc5043f56dc06510eba3a8b&w=996'),
                        height: 160,
                        width: double.infinity,

                        fit: BoxFit.cover,
                      ),
                      Text('communication with frindes',style: GoogleFonts.lato(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.white ),)

                    ],
                  )


                  ,),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=>SizedBox(height: 10,),
                    itemCount: SocialCubit.get(context).posts.length
                ),


              ],
            ),
          ),
          conditionBuilder: (context)=>SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).model !=null ,
          fallbackBuilder:(context)=> Center(child: CircularProgressIndicator()),
        );
    },
    );
  }
  Widget buildPostItem(PostModel model,  context,index)=>Card(

    elevation: 10,
    margin: EdgeInsets.symmetric(horizontal: 8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child:Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(

            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:NetworkImage('${model.image}',),

              ),
              SizedBox(width: 10,),
              Expanded(
                child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${model.name}',style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle,color: Colors.blue,size: 13,)
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text('${model.dateTime}',style: GoogleFonts.lato(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.bold),),

                    ]),
              ),
              SizedBox(width: 10,),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,size: 20,))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text('${model.text}'
            ,style: GoogleFonts.lato(fontWeight: FontWeight.bold,height: 1.1),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 10,top: 5),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        onPressed: (){},

                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text('#mosalah',style: GoogleFonts.lato(color: Colors.blue,fontWeight: FontWeight.bold),),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(model.postImage!='')
             Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(image:
              NetworkImage('${model.postImage}'),


                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,size: 20,color: Colors.red,),
                          SizedBox(width: 2,),
                          Text('${SocialCubit.get(context).likes[index]}',style: GoogleFonts.lato(fontSize: 12),)

                        ],),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,size: 20,color: Colors.amber,),
                          SizedBox(width: 2,),
                          Text('0',style: GoogleFonts.lato(fontSize: 12),)

                        ],),
                    ),
                    onTap: (){},
                  ),
                ),

              ],),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(

                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:NetworkImage('${SocialCubit.get(context).model!.image}',),

                        ),
                        SizedBox(width: 8,),
                        Text('write a comment ....',style: GoogleFonts.lato(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.bold),),



                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(IconBroken.Heart,size: 17,color: Colors.red,),
                      SizedBox(width: 2,),
                      Text('like',style: GoogleFonts.lato(fontSize: 12),)

                    ],),
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ),


        ],
      ),
    )


    ,);
}
