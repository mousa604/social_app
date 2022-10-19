import 'package:face_app/cubit/cubit/cubit.dart';
import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/models/massageModel.dart';
import 'package:face_app/models/userModel.dart';
import 'package:face_app/styles/icons_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatDetailsScreen(this.model);


  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){},
      builder: (context,state){


        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme:IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,

            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage:NetworkImage('${model.image}',),
                ),
                SizedBox(width: 15,),
                Text('${model.name}',style: GoogleFonts.lato(color: Colors.black),),
              ],
            ),
          ),
          body:Conditional.single(
            context: context,
            widgetBuilder:(context)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index){
                          var massage=SocialCubit.get(context).massages[index];
                          if(SocialCubit.get(context).model!.uid == massage.senderId){
                            return buildMyMassage(massage);
                          }
                          else return buildMassage(massage);
                        },
                        separatorBuilder: (context,index)=>SizedBox(height: 15,),
                        itemCount: SocialCubit.get(context).massages.length
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: EdgeInsetsDirectional.only(start: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color:Colors.grey[300]! ,width: 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your text here...'
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: (){
                              SocialCubit.get(context).sendMassage(
                                  dateTime: DateTime.now().toString(),
                                  receiverUid: model.uid!,
                                  text: textController.text);
                            },
                            minWidth: 1,
                            child: Icon(IconBroken.Send,size: 16,color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            conditionBuilder: (context)=>SocialCubit.get(context).massages.length>0 ,
            fallbackBuilder:(context)=> Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
  Widget buildMassage(MassageModel massage)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),

      ),
      child: Text(massage.text!,style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
    ),
  );
  Widget buildMyMassage(MassageModel massage)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),

      ),
      child: Text(massage.text!,style: GoogleFonts.lato(fontWeight: FontWeight.bold),),

    ),
  );
}

