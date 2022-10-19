import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/screens/home_screen.dart';
import 'package:face_app/screens/login_screen.dart';
import 'package:face_app/shared/constat.dart';
import 'package:face_app/shared/local/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CatchHelper.init();

  Widget widget ;
    uid =CatchHelper.getData(Key: 'uid');
   if(uid !=null){
     widget=Home();
   }
   else widget = LoginScreen();

  runApp(MyApp(startWidget: widget,));



}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [

          BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts()..getAllUsers()),

        ],

        child: BlocConsumer<SocialCubit,SocialStats>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          },
        ));
  }
}


