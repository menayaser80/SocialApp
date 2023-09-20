import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:social_app/Network/Constants.dart';
import 'package:social_app/Social_app/Login/login%20cubit.dart';
import 'package:social_app/Social_app/Login/login%20states.dart';
import 'package:social_app/Social_app/Register/register%20screen.dart';
import 'package:social_app/Social_app/modules/Maps.dart';
import 'package:social_app/Social_app/modules/Social_Layout.dart';
import 'package:social_app/Social_app/Cubit/cashe%20helper.dart';
import 'package:social_app/Network/reusable%20components.dart';
class SocialLogin extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
      listener: (context,state)
      {
      if(state is SocialLoginErrorState)
        {
          showToast(
              text:state.error,
              state:ToastColor.ERROR,
          );
        }
      if(state is SocialLoginSuccessState)
        {
          CachHelper.saveData(
              key: 'uid',
              value: state.uid,
          ).then((value) {


            navigateandFinish(context,SocialLayout());
          });
        }
      },
        builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Social app',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            actions:  [
              IconButton(onPressed: ()async
              {
               navigateTo(context, Archized);
               Location x=new Location();
                dynamic y=await x.getLocation();
                double a=y.latitude;
                double b=y.longitude;
                print("خط الطول"+b.toString());
                print("خط العرض"+a.toString());
              },
                icon: Icon(Icons.location_on),),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style:Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Login now to communicate with friends',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultformfield(
                        controller: emailcontroller,
                        type: TextInputType.emailAddress,
                        validator: (value)
                        {
                          if(value!.isEmpty&&value!=null)
                          {
                            return ' email address must not be empty';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultpassword(controller: passwordcontroller,
                          type: TextInputType.visiblePassword,
                          onsubmit: (value)
                          {
                            if(formkey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).
                              userlogin(email:emailcontroller.text,
                                  password:passwordcontroller.text,context: context);
                            }
                          },
                          validator: (value)
                          {
                            if(value!.isEmpty&&value!=null)
                            {
                              return ' password is too short';
                            }
                          },
                          label: 'password',
                          ispassword:  SocialLoginCubit.get(context).isPassword,
                          prefix: Icons.lock_outline,
                          suffix:  SocialLoginCubit.get(context).suffix,
                          suffixpressed: (){
                            SocialLoginCubit.get(context).changepasswordvisibility();
                          }
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition:state is!SocialLoginLoadingState,
                        builder: (context)=>Container(
                            width: double.infinity,
                            color: defaultcolor,
                            child: MaterialButton(onPressed: (){
                              if(formkey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).
                                userlogin(email:emailcontroller.text,
                                    password:passwordcontroller.text,context: context);
                              }
                            },child: Text('Login',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),),)),
                        fallback:(context)=>Center(child: CircularProgressIndicator()),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          defaulttextbutton(
                            function: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder:(context)=>SocialRegister(),
                              ));
                            },
                            text:'register',
                          ),
                        ],
                      ),
                    ],
                  ),
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
