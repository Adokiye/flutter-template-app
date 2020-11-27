import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';

class ButtonBlue extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonBlue({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonBlueState createState() => _ButtonBlueState();
}

class _ButtonBlueState extends State<ButtonBlue> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
       //   elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: GoloColors.primary,
            child: InkWell(
              onTap: widget.onPressed,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 22.0),
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizer(true,16.0,context),
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            )));
  }
}
