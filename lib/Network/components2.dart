import 'dart:io';

import 'package:flutter/material.dart';
navigateTo({required context, required nextPage}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );

navigateToWithReplacement({required context, required nextPage}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => nextPage,
      ),
    );

var information = Platform.localeName.characters.toList();
String lang = '${information[0]}${information[1]}';

class CachedNetworkImageErrorWidget extends StatelessWidget {
  const CachedNetworkImageErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.error,
      color: Colors.blue,
    );
  }
}

class CachedNetworkImageProgressIndicator extends StatelessWidget {
  const CachedNetworkImageProgressIndicator({
    Key? key,
    required this.downloadProgress,
  }) : super(key: key);
  final downloadProgress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
    );
  }
}

// MotionToast errorMotionToast(String messageDescription) {
//   return MotionToast.error(
//     title: const Text("Error"),
//     description: Text(messageDescription),
//     position: MOTION_TOAST_POSITION.top,
//     animationType: ANIMATION.fromTop,
//     toastDuration: const Duration(seconds: 1, milliseconds: 1000),
//   );
// }
//
// MotionToast warningMotionToast(
//   String description, {
//   MOTION_TOAST_POSITION? position,
//   ANIMATION? animationType,
// }) {
//   return MotionToast.warning(
//     title: const Text("Warning"),
//     description: Text(description),
//     position: position ?? MOTION_TOAST_POSITION.bottom,
//     animationType: animationType ?? ANIMATION.fromBottom,
//     toastDuration: const Duration(seconds: 1, milliseconds: 1000),
//   );
// }
//
// MotionToast successMotionToast(String description) {
//   return MotionToast.success(
//     title: const Text("Success"),
//     description: Text(description),
//     position: MOTION_TOAST_POSITION.top,
//     animationType: ANIMATION.fromTop,
//     toastDuration: const Duration(seconds: 1, milliseconds: 1000),
//   );
// }
