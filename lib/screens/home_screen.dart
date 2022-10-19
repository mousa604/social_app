import 'package:face_app/cubit/cubit/cubit.dart';
import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/screens/add_new_post_screen.dart';
import 'package:face_app/styles/icons_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){
        if(state is NewPostState){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  NewPost()),
          );
        }
      },
      builder: (context,state){
        var cubit =SocialCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification),color: Colors.black,),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search),color: Colors.black,),
            ],
            title: Text(cubit.titels[cubit.currentIndex],style: GoogleFonts.lato(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.white,
            elevation: 0,
          ),

          bottomNavigationBar:  BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            items: cubit.items,
            onTap: (index){
              cubit.changeBouttomBar(index);
            },
            currentIndex: cubit.currentIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,

          ),
          body: cubit.screens[cubit.currentIndex],
        );
    },
    );
  }
}
