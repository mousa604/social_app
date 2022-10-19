import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_app/cubit/register_cubit/states.dart';
import 'package:face_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/login_screen.dart';


class RegisterCubit extends Cubit<RegisterStats>{
  RegisterCubit() : super(RegisterInitialStats());

  static RegisterCubit get(context)=>BlocProvider.of(context);



  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required context
  }){
    emit(RegisterLoadinglStats());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
          print(value.user!.email);
          print(value.user!.uid);
          createUser(uid: value.user!.uid,phone: phone,name: name,email: email,context: context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          emit(RegisterSuccessStats());
    }).catchError((error){
      emit(RegisterErrorlStats());
    });

  }
  bool isShowePassword =true;
  IconData icon =Icons.visibility;
  void showePassword(){
    isShowePassword=!isShowePassword;
    icon=isShowePassword?Icons.visibility:Icons.visibility_off;
    emit(RegisterShowePasswordlStats());
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uid,
    required context
  }){
    UserModel model=UserModel(
      email: email,
      name: name,
      phone: phone,
      bio: "write your bio .....",
      image: "https://img.freepik.com/free-vector/illustration-business-people_53876-5879.jpg?t=st=1657175538~exp=1657176138~hmac=8d37df3daed6fc4cb6233b4fb90fd7a6a0b54da43ca21ca29271006fcb49c257&w=740",
      cover: "https://img.freepik.com/free-photo/satisfied-student-posing-against-pink-wall_273609-20219.jpg?t=st=1656973940~exp=1656974540~hmac=2fbc7d0d3f480493000133a274b95c5ec46df590cdc5043f56dc06510eba3a8b&w=996",
      uid: uid,
      isEmailVerified:false
    );

    FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
          emit((CreateUserSuccessStats()));
    })
        .catchError((error){
          emit(CreateUserErrorlStats(error: error.toString()));
    });

  }



}