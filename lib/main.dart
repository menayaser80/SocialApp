import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/Constants.dart';
import 'package:social_app/Social_app/Cubit/States.dart';
import 'package:social_app/Social_app/Cubit/bloc.dart';
import 'package:social_app/Social_app/Login/social%20login.dart';
import 'package:social_app/Social_app/modules/Social_Layout.dart';
import 'package:social_app/Social_app/Cubit/bloc%20observer.dart';
import 'package:social_app/Social_app/Cubit/cashe%20helper.dart';
import 'package:social_app/Styles/themes.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token=await FirebaseMessaging.instance.getToken();
  print('tokin is:$token');
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print('/////////////////////////////Notification recieved////////////////////////////////////////////');
  });
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print('/////////////////////////////Notification recieved////////////////////////////////////////////');
  });
   // bool? isDark = CachHelper.getData(key: 'isDark')??true;
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  Widget widget;
  uid =  await CachHelper.getData(key: 'uid');
}

class MyApp extends StatelessWidget {
  //final bool? isdark;
  final Widget startwidget;
  MyApp({
    //this.isdark,
    required this.startwidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getposts(),
        ),

        // BlocProvider(create:  (BuildContext context)=>SocialCubit()..changeappmode(fromshared:isdark,),),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lighttheme,
              darkTheme: darkTheme,
              themeMode: SocialCubit.get(context).isdark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: SocialLogin(),
            );
          }),
    );
  }
}
