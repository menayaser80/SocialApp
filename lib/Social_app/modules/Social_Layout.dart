import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/reusable%20components.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Social_app/modules/New_Post.dart';
import 'package:social_app/Styles/Icon_broken.dart';
class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState)
          {
            navigateTo(context, NewPost(),);
          }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text(
            cubit.titles[cubit.currentindex],
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification),),
            IconButton(onPressed: (){}, icon: Icon(IconBroken.Search),),
          ],
        ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index)
            {
cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                IconBroken.Chat,
              ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                IconBroken.Paper_Upload,
              ),
                label: 'Post',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                IconBroken.Location,
              ),
                label: 'Users',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                IconBroken.Setting,
              ),
                label: 'Setting',
              ),
            ],
          ),
        );
      },

    );
  }
}
