
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/reusable%20components.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Styles/Icon_broken.dart';

class EditProfile extends StatelessWidget {
  var namecontroller=TextEditingController();
  var biocontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var usermodel = SocialCubit.get(context).usermodel;
        var profileimage=SocialCubit.get(context).profileImage;
        var coverimage=SocialCubit.get(context).coverimage;
        namecontroller.text = usermodel!.name!;
        biocontroller.text = usermodel.bio!;
        phonecontroller.text = usermodel.phone!;
        return  Scaffold(
          appBar: defaultAppbar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaulttextbutton(
                function: (){
                  SocialCubit.get(context).updataUser(
                      name:namecontroller.text ,
                      phone:phonecontroller.text ,
                      bio:biocontroller.text );
                },
                text:'Update',
              ),
              SizedBox(width: 15.0,),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0,),
                                    topRight: Radius.circular(4.0,),
                                  ),
                                  image: DecorationImage(
                                image: coverimage==null?NetworkImage(
                                    '${usermodel.cover}'
                                )as ImageProvider:FileImage(coverimage)as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar
                                  (radius: 20.0,
                                    child: Icon(IconBroken.Camera,size: 16.0,),
                                ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileimage == null
                                    ? NetworkImage('${usermodel.image}')
                                as ImageProvider
                                    : FileImage(profileimage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar
                                (radius: 20.0,
                                child: Icon(IconBroken.Camera,size: 16.0,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage!=null ||SocialCubit.get(context).coverimage!=null )
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      function: () {
                                        SocialCubit.get(context).UploadProfileImage(
                                            name: namecontroller.text,
                                            phone: phonecontroller.text,
                                            bio: biocontroller.text);
                                      },
                                      text: 'Upload Profile',
                                      background: Colors.blue),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              )),
                        SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).coverimage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      function: () {
                                        SocialCubit.get(context).UploadcoverImage(
                                            name: namecontroller.text,
                                            phone: phonecontroller.text,
                                            bio: biocontroller.text);
                                      },
                                      text: 'Upload Cover',
                                      background: Colors.blue),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ))
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultformfield(controller: namecontroller, type: TextInputType.name, validator: (value)
                    {
                      if(value!.isEmpty&&value!=null)
                        {
                          return 'name must not be empty';
                        }
                      return null;
                    }, label: 'Name',
                    prefix:IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(controller: biocontroller, type: TextInputType.text, validator: (value)
                  {
                    if(value!.isEmpty&&value!=null)
                    {
                      return 'Bio must not be empty';
                    }
                    return null;
                  }, label: 'Bio',
                    prefix:IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(controller: phonecontroller, type: TextInputType.phone, validator: (value)
                  {
                    if(value!.isEmpty&&value!=null)
                    {
                      return 'phone number must not be empty';
                    }
                    return null;
                  }, label: 'phone',
                    prefix:IconBroken.Call,
                  ),
                ],
              ),
            ),
          ) ,
        );
      },
    );
  }
}
