import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Social_app/Register/register%20states.dart';
import 'package:social_app/Social_app/models/Social_User_Model.dart';
class SocialCubitRegister extends Cubit<SocialRegisterStates>
{
  SocialCubitRegister() : super(InitialRegisterState());
  static SocialCubitRegister get(context) => BlocProvider.of(context);
  bool ispass = true;
  IconData suffix = Icons.visibility;
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uid,

})
  {
SocialUserModel model=SocialUserModel(
  name: name,
  email: email,
  phone: phone,
  uid: uid,
  bio: 'write your Bio ....',
  image:'https://as1.ftcdn.net/v2/jpg/04/28/56/60/1000_F_428566061_Fkqaq0l831DXPM12Ixs9ds3waZWlCXHH.jpg',
  cover:'https://as1.ftcdn.net/v2/jpg/04/28/56/60/1000_F_428566061_Fkqaq0l831DXPM12Ixs9ds3waZWlCXHH.jpg',
  isEmailVerified: false,
);
FirebaseFirestore.instance.collection('users').doc(uid)
    .set(model.toMap()).then((value){
      emit(SuccessCreateUserState());
}).catchError((error){
emit(ErrorCreateUserState(error.toString()));
});
  }
  void changePass() {
    if (ispass == false) {
      ispass = true;
      suffix = Icons.visibility;
    }
    else {
      ispass = false;
      suffix = Icons.visibility_off;
    }
    emit(ChangePassRegisterState());
  }
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(LoadingRegisterState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:email ,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email:email,
          name:name,
          phone:phone ,
          uid:value.user!.uid,

      );
     }).catchError((error){
      emit(ErrorRegisterState(error.toString()));
    });

  }
}