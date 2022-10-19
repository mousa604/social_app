import 'package:face_app/cubit/cubit/states.dart';
import 'package:face_app/screens/edit_profile_screen.dart';
import 'package:face_app/styles/icons_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/cubit/cubit.dart';

class SettingScreens extends StatelessWidget {
  const SettingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStats>(
      listener: (context,state){},
      builder: (context,state){

        var UserModel=SocialCubit.get(context).model;
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(

                      child: Container(
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
                      alignment: AlignmentDirectional.topCenter,

                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(

                        radius: 60,
                        backgroundImage:NetworkImage('${UserModel?.image}',),

                      ),
                    ),
                  ],
                ),
              ),
              Text('${UserModel?.name}',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 19),),
              SizedBox(height: 5,),
              Text('${UserModel?.bio}',style: GoogleFonts.lato(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 5,),


                            Text('posts',style: GoogleFonts.lato(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('45',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 5,),


                            Text('Photos',style: GoogleFonts.lato(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 5,),

                            Text('Followers',style: GoogleFonts.lato(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('64',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 5,),


                            Text('Following',style: GoogleFonts.lato(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                 Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Add Photos'))),
                 SizedBox(width: 10,),
                 OutlinedButton(onPressed: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>  EditProfile()),
                   );
                 }, child: Icon(IconBroken.Edit)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
