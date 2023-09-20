import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/Styles/Icon_broken.dart';
Widget myDivider()=>Padding(
  padding: EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],

  ),
);

Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
})=> TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefix,
      ),
      labelText: label,
      border: OutlineInputBorder(),
    ),
    validator: validator,

    keyboardType:type,
    onChanged:onchange
);
Widget defaultpassword({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  Function(String x)?onsubmit,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispassword=false,
  VoidCallback? suffixpressed,
})=>TextFormField(
  controller: controller,
  decoration: InputDecoration(
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null?IconButton(
      onPressed:suffixpressed,
      icon:   Icon(
        suffix,
      ),
    ):null,
    labelText: label,
    border: OutlineInputBorder(),
  ),
  validator: validator,
  keyboardType:type,
  obscureText: ispassword,
  onChanged: onchange,
  onFieldSubmitted:onsubmit,
);
void navigateTo(context,Widget)=>Navigator.push(context, MaterialPageRoute(
  builder:(context)=>Widget,
));

void navigateandFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
  builder: (context)=>Widget,
),
      (route)
  {
    return false;
  },
);
Widget defaulttextbutton({
  required VoidCallback function,
  required String text,
})=>  TextButton(
  onPressed: function,
  child:Text(text.toUpperCase(),),
);
void showToast({
  required String text ,
  required ToastColor state ,
}) =>  Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: ChangeToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
enum ToastColor {SUCCESS,ERROR,WARNING}
Color ChangeToastColor(ToastColor state)
{
  Color color;
  switch(state){
    case ToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastColor.ERROR:
      color = Colors.red;
      break;
    case ToastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
PreferredSizeWidget  defaultAppbar({
  required BuildContext context,
  String? title,
   List<Widget>?actions,
})=>AppBar(
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  },icon: Icon(
    IconBroken.Arrow___Left_2,
  ),),
  titleSpacing: 5.0,
  title: Text(title!),
  actions: actions,
);
Widget defaultButton({
  double width = double.infinity,
  Color? background,
  bool isUppercase = true,
  double raduis = 10,
  @required Function()? function,
  @required String? text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        height: 45.0,
        color: background,
        child: Text(
          isUppercase ? text!.toUpperCase() : text!,
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
      ),
    );
 void navigateToo({required context, required nextPage}) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => nextPage,
  ),
);