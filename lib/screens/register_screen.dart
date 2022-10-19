import 'package:face_app/cubit/register_cubit/cubit.dart';
import 'package:face_app/cubit/register_cubit/states.dart';
import 'package:face_app/shared/local/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';


class RegisterScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStats>(
        listener: (context, stats) {},
        builder: (context,stat){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style:TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
                      ),
                      Text(
                        'register now to communicate with friends',
                        style:TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'pleas enter your name';
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'Name'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'pleas enter your email';
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email_outlined),
                                    labelText: 'Email Address'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'pleas enter your phone';
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.phone),
                                    labelText: 'phone'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                obscureText: RegisterCubit.get(context).isShowePassword,
                                onFieldSubmitted: (value) {

                                },
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'pleas enter your password';
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon:IconButton(icon: Icon(RegisterCubit.get(context).icon,),onPressed: (){RegisterCubit.get(context).showePassword();},),
                                    labelText: 'Password'),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Conditional.single(
                          fallbackBuilder: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                          conditionBuilder: (BuildContext context) =>stat is! RegisterLoadinglStats,
                          context: context,
                          widgetBuilder: (BuildContext context) {
                            return Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(context: context,
                                      name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: Text(
                                  'REGISTER',
                                  style:TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            );
                          }
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
