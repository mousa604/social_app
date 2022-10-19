import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/styles/icons_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/cubit/cubit.dart';

class NewPost extends StatelessWidget {
  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Create Post',style: GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.bold),),
            iconTheme:IconThemeData(color: Colors.black) ,
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    var now =DateTime.now();
                    if(SocialCubit.get(context).postImage==null){
                      SocialCubit.get(context).createPost(dateTime: now.toString(), text: textController.text, );
                      SocialCubit.get(context).getPosts();
                    }
                    else{
                      SocialCubit.get(context).upLodePostImage(text: textController.text, dateTime: now.toString());
                      SocialCubit.get(context).getPosts();
                    }
                  },
                  child: Text('post',style: GoogleFonts.lato(fontSize: 18),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(

              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:NetworkImage('${SocialCubit.get(context).model!.image}',),

                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child:
                      Text('${SocialCubit.get(context).model!.name}',style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration:InputDecoration(
                        hintText:'what is on your mind' ,
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImage!=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      clipBehavior:Clip.antiAliasWithSaveLayer ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child:Image(image:
                      FileImage(SocialCubit.get(context).postImage!),
                        height: 140,
                        width: double.infinity,

                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                          radius: 15,
                          child: IconButton(onPressed: (){
                            SocialCubit.get(context).removePostImage();
                          }, icon: Icon(Icons.close),iconSize: 15,)),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5,),
                            Text('Add Photo',)

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text('# Tags',),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
    },
    );
  }
}
