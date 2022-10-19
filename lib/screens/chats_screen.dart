import 'package:face_app/cubit/cubit/cubit.dart';
import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){},
      builder: (context,state){
        return Conditional.single(
          context: context,
          widgetBuilder:(context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users![index],context),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(height: 1,width: double.infinity,color: Colors.grey,),
              ),
              itemCount: SocialCubit.get(context).users!.length),
          conditionBuilder: (context)=>SocialCubit.get(context).users!.length>0  ,
          fallbackBuilder:(context)=> Center(child: CircularProgressIndicator()),
        );
      },



    ) ;
  }

Widget buildChatItem(UserModel model,context)=>InkWell(
  onTap: (){
    SocialCubit.get(context).getMassages(receiverId: model.uid!);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ChatDetailsScreen(model)),
    );
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child:   Row(
      children: [
       CircleAvatar(
          radius: 25,
          backgroundImage:NetworkImage('${model.image}',),
        ),
        SizedBox(width: 10,),
        Text('${model.name}',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 20),),
      ],
    ),

  ),
);
}

