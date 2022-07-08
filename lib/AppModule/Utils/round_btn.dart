import 'package:flutter/material.dart';

class RoundBtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const RoundBtn({Key? key,required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: double.infinity,
        height: 50,
        color: Colors.deepOrange,
        child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 18),),
      ),
    );
  }
}
