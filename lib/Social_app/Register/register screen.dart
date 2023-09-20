import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/Constants.dart';
import 'package:social_app/Social_app/Register/register%20cubit.dart';
import 'package:social_app/Social_app/Register/register%20states.dart';
import 'package:social_app/Social_app/modules/Social_Layout.dart';
import 'package:social_app/Network/reusable%20components.dart';
class SocialRegister extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var passwordcontroller= TextEditingController();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubitRegister(),
      child: BlocConsumer<SocialCubitRegister,SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SuccessCreateUserState)
          {
navigateandFinish(context, SocialLayout(),);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'register now to communicate with friends',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultformfield(
                          controller: namecontroller,
                          type: TextInputType.name,
                          validator: (value)
                          {
                            if(value!.isEmpty&&value!=null)
                            {
                              return 'please enter your name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
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
                        defaultpassword(
                            controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            onsubmit: (value)
                            {

                            },
                            validator: (value)
                            {
                              if(value!.isEmpty&&value!=null)
                              {
                                return ' password is too short';
                              }
                            },
                            label: 'password',
                            ispassword:  SocialCubitRegister.get(context).ispass,
                            prefix: Icons.lock_outline,
                            suffix:  SocialCubitRegister.get(context).suffix,
                            suffixpressed: (){
                              SocialCubitRegister.get(context).changePass();
                            }
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultformfield(
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          validator: (value)
                          {
                            if(value!.isEmpty&&value!=null)
                            {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition:state is !LoadingRegisterState,
                          builder: (context)=>Container(
                              width: double.infinity,
                              color: defaultcolor,
                              child: MaterialButton(onPressed: (){
                                if(formKey.currentState!.validate())
                                {
                                  SocialCubitRegister.get(context).
                                  userRegister(
                                    email:emailcontroller.text,
                                    password:passwordcontroller.text,
                                    phone: phonecontroller.text,
                                    name: namecontroller.text,
                                  );
                                }
                              },child: Text('register',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),),)),
                          fallback:(context)=>Center(child: CircularProgressIndicator()),
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