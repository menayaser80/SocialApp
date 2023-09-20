import 'package:flutter/material.dart';

class CommentTextFormFiled extends StatelessWidget {
  const CommentTextFormFiled({
    required this.commentController,
    required this.validatorMessage,
    Key? key,
  }) : super(key: key);
  final TextEditingController commentController;
  static final TextSelectionControls c = MaterialTextSelectionControls();
  final String validatorMessage;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty || value == null) {
          return validatorMessage;
        }
        return null;
      },
      controller: commentController,
      decoration: const InputDecoration(
        hintText: 'Write a comment',
        border: InputBorder.none,
      ),
    );
  }
}