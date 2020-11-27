import 'package:Instahelp/components/buttonBlue.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatefulWidget {
  EmptyData({Key key, @required this.title, this.isButton, this.buttonText,
  this.buttonFn}) : super(key: key);
  final String title;
  final bool isButton;
  final String buttonText;
  final Function buttonFn;

  @override
  _EmptyDataState createState() => _EmptyDataState();
}

class _EmptyDataState extends State<EmptyData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
                      mainAxisSize: MainAxisSize.max,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff8E919C),
                              fontSize: sizer(true,16.0,context),)),
                        SizedBox(height: 30),
                              widget.isButton ? ButtonBlue(title: widget.buttonText, onPressed: widget.buttonFn):Container()
                        ]
                        
    );
  }
}
