import 'package:flutter/material.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';

class MediumText extends StatefulWidget {  
  final String title;
  MediumText({Key key, @required this.title}) : super(key: key);


  @override
  _MediumTextState createState() => _MediumTextState();
}

class _MediumTextState extends State<MediumText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('${widget.title}', 
              style: TextStyle(
                fontSize: sizer(true,16.0,context),
                color: Color(0xff8E919C),
                fontWeight: FontWeight.w500),);
  }
}



