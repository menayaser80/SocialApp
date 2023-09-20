import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/reusable%20components.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Social_app/models/Social_User_Model.dart';
import 'package:social_app/Social_app/modules/chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0 ,
          builder:(context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>BuildChatItem(SocialCubit.get(context).users[index],context) ,
            separatorBuilder:(context,index)=>myDivider(),
            itemCount:SocialCubit.get(context).users.length,
          ) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget BuildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: (){
navigateTo(context, ChatDetails(
  userModel:model ,
));

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text('${model.name}',
            style: TextStyle(
              height: 1.4,
            ),),

        ],
      ),
    ),
  );
}
