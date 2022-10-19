import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/cubit/cubit.dart';
import '../cubit/cubit/states.dart';
import '../styles/icons_broken.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){},
      builder: (context,state){
        var UserModel=SocialCubit.get(context).model;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text = SocialCubit.get(context).model!.name!;
        bioController.text =SocialCubit.get(context).model!.bio!;
        phoneController.text =SocialCubit.get(context).model!.phone!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar:AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Edit Profile',style: GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.bold),),
            iconTheme:IconThemeData(color: Colors.black) ,
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
              icon: Icon(IconBroken.Arrow___Left_2),

            ),
            actions: [
              TextButton(onPressed: (){
                SocialCubit.get(context).userUpdateData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
              },child: Text('UPDATE'),),
              SizedBox(width: 10,)
            ],

          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics:BouncingScrollPhysics(),
              child: Column(
                children: [
                  if(state is UserUpDateLoadingState)
                      LinearProgressIndicator(),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(

                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                clipBehavior:Clip.antiAliasWithSaveLayer ,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),

                                    )
                                ),
                                child:Image(image:
                                NetworkImage('${UserModel?.cover}'),
                                  height: 140,
                                  width: double.infinity,

                                  fit: BoxFit.cover,
                                ),
                              ),
                              CircleAvatar(
                                  radius: 15,
                                  child: IconButton(onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  }, icon: Icon(IconBroken.Camera),iconSize: 15,))
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,

                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(

                                radius: 60,
                                backgroundImage:profileImage==null?NetworkImage('${UserModel?.image}',):FileImage(profileImage)as ImageProvider,

                              ),
                            ),
                            CircleAvatar(
                                radius: 15,
                                child: IconButton(onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                }, icon: Icon(IconBroken.Camera),iconSize: 15,))
                          ],
                        ),
                      ],
                    ),
                  ),
                  if(SocialCubit.get(context).profileImage !=null || SocialCubit.get(context).coverImage !=null )
                     Row(
                    children: [
                      if(SocialCubit.get(context).profileImage !=null  )
                         Expanded(child: Column(
                           children: [
                             Container(
                                 width: double.infinity,
                                 child: OutlinedButton(onPressed: (){
                                   SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone:  phoneController.text, bio: bioController.text);
                                 }, child: Text('Add Photo'))),
                             if(state is UserUpDateLoadingState)
                               LinearProgressIndicator(),
                           ],
                         )),
                      SizedBox(width: 10,),
                      if(SocialCubit.get(context).coverImage !=null  )
                         Expanded(
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: OutlinedButton(onPressed: (){
                                  SocialCubit.get(context).upLodeCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                }, child: Text('Add Cover'))),
                            if(state is UserUpDateLoadingState)
                              LinearProgressIndicator()
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'pleas enter your name';
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(IconBroken.User),
                        labelText: 'Name'),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'pleas enter your bio';
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(IconBroken.Info_Circle),
                        labelText: 'Bio'),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'pleas enter your phone';
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(IconBroken.Call),
                        labelText: 'phone'),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}
