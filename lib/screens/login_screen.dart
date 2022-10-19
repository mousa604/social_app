import 'package:face_app/cubit/login_cubit/cubit.dart';
import 'package:face_app/cubit/login_cubit/states.dart';
import 'package:face_app/screens/home_screen.dart';
import 'package:face_app/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../shared/local/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStats>(
        listener: (context,state){
          if(state is LoginSuccessStats){
            CatchHelper.saveData(Key: 'uid', value:state.uid).then((value){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            }).catchError((){});
          }
        },
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'LOGIN',
                          style:TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
                      ),
                      Text(
                        'login now to communicate with friends',
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
                                obscureText: LoginCubit.get(context).isShowePassword,
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(context: context,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
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
                                    suffixIcon:IconButton(icon: Icon(LoginCubit.get(context).icon,),onPressed: (){LoginCubit.get(context).showePassword();},),
                                    labelText: 'Password'),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Conditional.single(
                          fallbackBuilder: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                          conditionBuilder: (BuildContext context) =>state is ! LoginLoadinglStats,
                          context: context,
                          widgetBuilder: (BuildContext context) {
                            return Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(context: context,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white, fontSize: 20)
                                ),
                              ),
                            );
                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Don\'t have an account ?  ',
                              style:TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
                          ),
                          TextButton(onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            );
                          }, child: Text('REGISTER'))
                        ],
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
