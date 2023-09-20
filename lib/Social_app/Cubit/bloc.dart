import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Network/Constants.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/cashe%20helper.dart';
import 'package:social_app/Social_app/models/Post_model.dart';
import 'package:social_app/Social_app/models/Social_User_Model.dart';
import 'package:social_app/Social_app/models/comment%20model.dart';
import 'package:social_app/Social_app/models/message%20model.dart';
import 'package:social_app/Social_app/modules/New_Post.dart';
import 'package:social_app/Social_app/modules/chats.dart';
import 'package:social_app/Social_app/modules/feeds.dart';
import 'package:social_app/Social_app/modules/setting.dart';
import 'package:social_app/Social_app/modules/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit():super(SocialInitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);
  SocialUserModel? usermodel;
  Future getUserData() async
  {
 if(uid != null) {
   emit(SocialGetUserLoadingState());
   await FirebaseFirestore.instance.collection('users').
   doc(uid).get()
       .then((value){
     // print(value.data());
     usermodel=SocialUserModel.fromJson(value.data()!);
     emit(SocialGetUserSuccessState());
   })
       .catchError((error){
     print(error.toString());
     emit(SocialGetUserErrorState(error.toString()));
     throw error;
   });
 }
  }
  int currentindex=0;
  List<Widget>screens=[
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    NewPost(),
    SettingScreen(),
  ];
  List<String>titles=[
    'Home',
    'Chats',
    'post',
    'Users',
    'Setting',
  ];
  void changeBottomNav(int index)
  {
    if(index==1)
      {
        getAllUsers();
      }
    if(index==2)
      emit(SocialNewPostState());
    currentindex=index;
    emit(SocialChangeBottomState());
  }
  bool isdark =false;
  void changeappmode({bool? fromshared})
  {
    if(fromshared !=null)
    {
      isdark=fromshared;
      emit(AppChangeDarkState());
    }
    else
    {
      isdark=!isdark;
      CachHelper.putBoolean(key:'isdark', value:isdark).then((value){
        emit(AppChangeDarkState());
      });
    }
  }
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }
  File? coverimage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverimage = File(pickedFile.path);
      emit(SocialcoverimagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialcoverimagePickedErrorState());
    }
  }
  void UploadProfileImage
      ({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
      //  emit(SocialuploadimageSuccessState());
        print(value);
        updataUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error) {
        emit(SocialuploadimageErrorState());
      });
    }).catchError((error){
      emit(SocialuploadimageErrorState());
    });
        }

  void UploadcoverImage({
    required String name,
    required String phone,
    required String bio,
}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       // emit(SocialuploadcoverimageSuccessState());
        print(value);
updataUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error) {
        emit(SocialuploadcoverimageErrorState());
      });
    }).catchError((error){
      emit(SocialuploadcoverimageErrorState());
    });
  }
//   void updataUserImages({
//     required String name,
//     required String phone,
//     required String bio,
// })
//   {
//     emit(SocialUserUpdateLoadingState());
//     if(coverimage!=null)
//       {
//         UploadcoverImage();
//       }
//     else if(profileImage!=null)
//       {
//         UploadProfileImage();
//       }
//     else if(coverimage!=null && profileImage!=null)
//       {
//
//       }
//     else
//       {
// updataUser(name: name, phone: phone, bio: bio);
//       }
//   }
  void updataUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  })
  {
    SocialUserModel model=SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: usermodel!.email,
      cover: cover ?? usermodel!.cover!,
      image: image ?? usermodel!.image!,
      uid: usermodel!.uid,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(model.uid).update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }
  File? Postimage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Postimage = File(pickedFile.path);
      emit(SocialPostimagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostimagePickedErrorState());
    }
  }
  void removepostimage()
  {
    Postimage=null;
    emit(SocialRemoveimageState());
  }
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(Postimage!.path).pathSegments.last}')
        .putFile(Postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createpost(
          dateTime: dateTime,
          text: text,
          postimage:value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createpost({
    required String dateTime,
    required String text,
    String? postimage,
  })
  {
    emit(SocialCreatePostLoadingState());
    PostModel model=PostModel(
      name: usermodel!.name,
      image:usermodel!.image,
      uid: usermodel!.uid,
      dateTime:dateTime,
      text: text,
      postImage: postimage??'',
    );
    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
        })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  List<PostModel>posts=[];
  List<String>postsId=[];
  List<int>likes=[];
  List<int>comments=[];

  void getposts()
  {
FirebaseFirestore.instance.collection('posts').get().then((value) {
  value.docs.forEach((element) {
    element.reference.collection('likes')
        .get()
        .then((value){
          likes.add(value.docs.length);
      postsId.add(element.id);
      posts.add(PostModel.fromJson(element.data()));
    }).catchError((error){});
  });
  emit(SocialGetPostsSuccessState());
}).catchError((error){
  emit(SocialGetPostsErrorState(error.toString()));
});
  }
  void likePost(String postId)
  {
FirebaseFirestore.instance.
collection('posts').
doc(postId).collection('likes').
doc(usermodel!.uid).set({
  'like':true,
})
    .then((value) {
      emit(SocialLikePostsSuccessState());
})
    .catchError((error){
      emit(SocialLikePostsErrorState(error.toString()));
});
  }
  void createComment({required String postId,required String comment,required String dataTime}){
    emit(SocialCreateCommentPostsLoadingState());
    // commentList.add(comment);
    // print(_commentModel!.text??'null');
    CommentModel commentModel=CommentModel(
      name: usermodel!.name,
      image:usermodel!.image,
      uid: usermodel!.uid,
      text:comment,
      dateTime:dataTime ,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comments')
        .doc(usermodel!.uid)
        .collection('user Comment')
        .add(commentModel.toMap()
    ).then((value) {
      emit(SocialCreateCommentPostsSuccessState());
      getComments(postId);
    })
        .catchError((error){
      emit(SocialCreateCommentPostsErrorState(error.toString()));

    });

  }
  List<String> commentList=[];
  List<CommentModel> commentModelList=[];
  String? newPostId;

  void getComments(String postId){
    emit(SocialGetCommentPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comments')
        .doc(usermodel!.uid)
        .collection('user Comment')
        .orderBy('dateTime')
        .get()
        .then((value) {
      commentModelList.clear();
      commentList.clear();
      value.docs.forEach((element) {
        // commentModel=   CommentModel.fromJson(element.data());
        commentModelList.add(CommentModel.fromJson(element.data()));
        commentList.add(element.id);
        emit(SocialGetCommentPostsSuccessState(postId));
      });
      print(postId+' 3');
      newPostId=postId ;
      print(newPostId);
      emit(SocialGetCommentPostsSuccessState(postId));
    }).catchError((error){
      emit(SocialGetCommentPostsErrorState(error.toString()));
      print(error);
    });
  }
  List<SocialUserModel>users=[];
  void getAllUsers()
  {
    if(users.length==0)
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uid']!=usermodel!.uid)
        users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error){
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }
  void SendMessage({
    required String recieverID,
    required String text,
    required String dateTime,
  })
  {
  MessageModel model=MessageModel(
    text:text,
    dateTime:dateTime ,
    recieverID:recieverID ,
    senderID:usermodel!.uid,
  );
  //set my chat
  FirebaseFirestore.instance.collection('users').doc(usermodel!.uid).
  collection('chats').doc(recieverID).collection('messages').add(model.toMap())
  .then((value){
    emit(SocialSendMessageSuccessState());
  }).catchError((error){
    emit(SocialSendMessageErrorState());
  });
  //set reciever chat

  FirebaseFirestore.instance.collection('users').doc(recieverID).
  collection('chats').doc(usermodel!.uid).collection('messages').add(model.toMap())
      .then((value){
    emit(SocialSendMessageSuccessState());
  }).catchError((error){
    emit(SocialSendMessageErrorState());
  });
  }
  List<MessageModel>messages=[];
  void getMessages({
    required String recieverID,
  })
  {
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uid)
        .collection('chats').doc(recieverID).collection('messages')
    .orderBy('dateTime')
        .snapshots().listen((event) {
       event.docs.forEach((element)
       {
         // messages=[];
         messages.add(MessageModel.fromJson(element.data()));
       });
emit(SocialGetMessageSuccessState());
    });
  }
}
