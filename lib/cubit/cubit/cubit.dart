
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/models/massageModel.dart';
import 'package:face_app/models/postModel.dart';
import 'package:face_app/models/userModel.dart';
import 'package:face_app/screens/add_new_post_screen.dart';
import 'package:face_app/shared/constat.dart';
import 'package:face_app/styles/icons_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../screens/chats_screen.dart';
import '../../screens/feeds_screen.dart';
import '../../screens/sattings_screen.dart';
import '../../screens/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;



class SocialCubit extends Cubit<SocialStats>{
  SocialCubit() : super(SocialInitialStats());

  static SocialCubit get(context)=>BlocProvider.of(context);

 UserModel ? model;

 void getUserData(){
   emit(SocialGetUserLoadingStats());
   FirebaseFirestore.instance.collection('users').doc(uid).get()
       .then((value) {
         print(value.data());
         model=UserModel.fromJson(value.data()!);
         emit(SocialGetUserSuccessStats());
   })
       .catchError((error){
         emit(SocialGetUserErrorStats(error.toString()));
   });
 }


  List screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPost(),
    UsersScreen(),
    SettingScreens(),
  ];
  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home',),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat',),
    BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post',),
    BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users',),
    BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Setting',),
  ];

  int currentIndex =0;

  void changeBouttomBar(index){
    if(index==0){

      getPosts();
    }
    if(index==1){

      getAllUsers();
    }
    if(index==2){
      emit(NewPostState());
    }
    else
      {
        currentIndex =index;
        emit(BottomNavBarState());
      }

  }

  List<String> titels =[
    "Home",
    "Chat",
    "new post",
    "Users",
    "Setting"
  ];


  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }



  }

  File ?coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpDateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadProfileImageSuccessState());
        // ignore: avoid_print
        print(value);
        userUpdateData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(UpLodeProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UpLodeProfileImageErrorState());
    });
  }



  void upLodeCoverImage(

      {
        required name,
        required phone ,
        required bio,


      }
      ){
    emit(UserUpDateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}').putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {

      //  emit(UpLodeCoverImageSuccessState());
        print(value);
        userUpdateData(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){
        emit(UpLodeCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(UpLodeCoverImageErrorState());
    });


  }




  void userUpdateData(
      {
        required name,
        required phone ,
        required bio,
        String? cover,
        String? image,

      }){
    UserModel modeel=UserModel(

        name: name,
        phone: phone,
        bio: bio,
        image:image?? model!.image,
        cover:cover?? model!.cover,
        email: model!.email,
        uid: model!.uid,

       isEmailVerified:false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid).update(modeel.toMap())
        .then((value) {
      getUserData();
      emit(UserUpDateErrorState());
    })
        .catchError((error){});
  }


  File ?postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }


  void upLodePostImage(
      {
        required String text,
        required String dateTime,
      }
      ){
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}').putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);

      }).catchError((error){
        emit(CreatePostErrorState());
      });
    })
        .catchError((error){
      emit(CreatePostErrorState());
    });


  }

   void removePostImage(){
    postImage=null;
    emit(RemovePostImageState());
   }

  void createPost(
      {
        required String dateTime,
        required String text,
         String? postImage,

      }){
    emit(CreatePostLoadingState());
    PostModel postModel=PostModel(
      image: model!.image,
      uid: model!.uid,
      name: model!.name,
      dateTime: dateTime,
      text: text,
      postImage: postImage??''

    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
    })
        .catchError((error){
          emit(CreatePostErrorState());
    });
  }


 List<PostModel> posts=[];
 List<String> postsId=[];
 List<int> likes=[];
  void getPosts(){
    emit(GetPostsLoadingState());

      posts=[];
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {

            element.reference.collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data())) ;
              emit(GetPostsSuccessStats());
            })
            .catchError((error){
              emit(GetPostsErrorStats(error.toString()));

            });

          });
    })
        .catchError((error){
      emit(GetPostsErrorStats(error.toString()));
    });
  }


  void likePost(String postId){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uid)
        .set({
      'like':true
    })
        .then((value){
          emit(SocialLikePostSuccessStats());
    })
        .catchError((error){
          emit(SocialLikePostErrorStats(error.toString()));
    });
  }


  List<UserModel>? users;
  void getAllUsers(){
    users=[];
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uid']!=model!.uid)
           users!.add(UserModel.fromJson(element.data())) ;

      });
      emit(SocialGetAllUsersSuccessStats());
    }).catchError((error){
          emit(SocialGetAllUsersErrorStats(error.toString()));
    });

  }

  void sendMassage({required String dateTime,required String receiverUid,required String text}){

    MassageModel massageModel =MassageModel(
      senderId: model!.uid,
      text: text,
      receiverId: receiverUid,
      dateTime: dateTime,

    );

    // set my chat
    FirebaseFirestore.instance
    .collection('users')
    .doc(model!.uid)
    .collection('chats')
    .doc(receiverUid)
    .collection('massage')
    .add(massageModel.toMap())
    .then((value) {
      emit(SocialSendMassageSuccessStats());
    })
        .catchError((error){
          emit(SocialSendMassageErrorStats(error.toString()));
    });

   // set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUid)
        .collection('chats')
        .doc(model!.uid)
        .collection('massage')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMassageSuccessStats());
    })
        .catchError((error){
      emit(SocialSendMassageErrorStats(error.toString()));
    });

  }
  
  List<MassageModel> massages=[];
  void getMassages({required String receiverId}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('massage')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          massages=[];
          event.docs.forEach((element) {
            massages.add(MassageModel.fromJson(element.data()));

          });
          emit(SocialGetMassageSuccessStats());
    });
    
  }
}