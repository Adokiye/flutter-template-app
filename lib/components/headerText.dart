import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatefulWidget {  
  final String title;
  HeaderText({Key key, @required this.title}) : super(key: key);


  @override
  _HeaderTextState createState() => _HeaderTextState();
}

class _HeaderTextState extends State<HeaderText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('${widget.title}', 
              style: TextStyle(color: GoloColors.secondary1,
              fontSize: 28.0, fontWeight: FontWeight.w700),);
  }
}



