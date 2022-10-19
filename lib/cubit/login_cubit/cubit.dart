import 'package:bloc/bloc.dart';
import 'package:face_app/cubit/login_cubit/states.dart';
import 'package:face_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginStats>{
  LoginCubit() : super(LoginInitialStats());

  static LoginCubit get(context)=>BlocProvider.of(context);


void userLogin({

 required String email,
  required String password,
  required context,
}){
  emit(LoginLoadinglStats());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value){
          print(value.user!.email);
          print(value.user!.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          emit(LoginSuccessStats(value.user!.uid));
    })
        .catchError((error){
          emit(LoginErrorlStats());
    });
}
 bool isShowePassword =true;
IconData icon =Icons.visibility;
void showePassword(){
  isShowePassword=!isShowePassword;
  icon=isShowePassword?Icons.visibility:Icons.visibility_off;
  emit(LoginShowePasswordlStats());
}


}