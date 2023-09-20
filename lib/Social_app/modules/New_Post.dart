import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/reusable%20components.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Styles/Icon_broken.dart';

class NewPost extends StatelessWidget {
var textcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: defaultAppbar(
            context: context,
            title: 'create post',
            actions: [
              defaulttextbutton(
                  function: (){
                    final now = DateTime.now();
                    if(SocialCubit.get(context).Postimage==null)
                      {
                        SocialCubit.get(context).createpost(dateTime: now.toString(), text: textcontroller.text);
                      }
                    else
                      {
                        SocialCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textcontroller.text);
                      }
                  },
                  text: 'post'
              ),

            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('assets/images/mena.jpg'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text('Mena Yaser',
                        style: TextStyle(
                          height: 1.4,
                        ),),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textcontroller,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind...',
                      border:InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).Postimage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(4.0,),
                        image:DecorationImage(
                      image:FileImage(SocialCubit.get(context).Postimage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                      SocialCubit.get(context).removepostimage();
                      },
                      icon: CircleAvatar
                        (radius: 20.0,
                        child: Icon(Icons.close,size: 16.0,),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.Image,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Add photo',),


                        ],
                      ),),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child:
                      Text(
                          '# tags',
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
