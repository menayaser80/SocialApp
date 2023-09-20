import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/Constants.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Social_app/Cubit/cashe%20helper.dart';
import 'login states.dart';
class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  Future userlogin({
    required String email,
    required String password,
    required BuildContext context
  })
  async
  {
    emit(SocialLoginLoadingState());
FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
).then((value) async {
  print(value.user!.email);
  print(value.user!.uid);
 await CachHelper.saveData(key: 'uid', value: value.user!.uid);
  uid = value.user?.uid ?? '';
  SocialCubit.get(context).getUserData();
  emit(SocialLoginSuccessState(value.user!.uid));
}).catchError((error){
emit(SocialLoginErrorState(error.toString()));
}
);
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changepasswordvisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialchangePasswordState());
  }

}