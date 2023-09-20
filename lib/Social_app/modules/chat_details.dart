import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/Constants.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Social_app/models/Social_User_Model.dart';
import 'package:social_app/Social_app/models/message%20model.dart';
import 'package:social_app/Styles/Icon_broken.dart';

class ChatDetails extends StatelessWidget {
 SocialUserModel? userModel;
 var messagecontroller=TextEditingController();
ChatDetails({
   this.userModel,
});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(recieverID: userModel!.uid!);
        return  BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title:Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(userModel!.name!),
                  ],
                ),
              ),
              body:
              ConditionalBuilder(
                condition:SocialCubit.get(context).messages.length>0,
                builder:(context)=>Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                   Expanded(
                     child: ListView.separated(
                       physics: BouncingScrollPhysics(),
                       itemBuilder:(context,index)
                  {
                      var messag=SocialCubit.get(context).messages[index];
if(SocialCubit.get(context).usermodel!.uid==messag.senderID)
  return buildMymessage(messag);
return buildmessage(messag);
                  },
                       separatorBuilder:(context,index)=>SizedBox(
                         height: 15.0,
                       ),
                  itemCount:SocialCubit.get(context).messages.length,
                     ),
                   ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messagecontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here ...'

                                ),
                              ),
                            ),
                            Container(
                              height: 48.0,
                              color: defaultcolor,
                              child: MaterialButton(onPressed: (){
                                SocialCubit.get(context).SendMessage(
                                  recieverID: userModel!.uid!,
                                  dateTime:DateTime.now().toString(),
                                 text:messagecontroller.text,
                                );
                              },minWidth: 1.0,child: Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback:(context)=> Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
  Widget buildmessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],

          borderRadius: BorderRadiusDirectional.only(
            bottomEnd:Radius.circular(10.0),
            topEnd:Radius.circular(10.0),
            topStart:Radius.circular(10.0),

          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,
              horizontal: 10.0),
          child: Text(model.text!),
        )),
  );
 Widget buildMymessage(MessageModel model)=>Align(
   alignment: AlignmentDirectional.centerEnd,
   child: Container(
       decoration: BoxDecoration(
         color: Colors.blue.withOpacity(0.2),

         borderRadius: BorderRadiusDirectional.only(
           bottomStart:Radius.circular(10.0),
           topEnd:Radius.circular(10.0),
           topStart:Radius.circular(10.0),

         ),
       ),
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 5.0,
             horizontal: 10.0),
         child: Text(model.text!),
       )),
 );


}
