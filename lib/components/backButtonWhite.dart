import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';

class BackButtonWhite extends StatefulWidget {
  final GestureTapCallback onPressed;
  BackButtonWhite({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _BackButtonWhiteState createState() => _BackButtonWhiteState();
}

class _BackButtonWhiteState extends State<BackButtonWhite> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(color: Colors.red)
            ),
            color: Color(0xffF3F4F8),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              //widget.onPressed,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 11),
                  decoration: BoxDecoration(
                 //    color: Color(0xffF3F4F8),
                     borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back,size: 17,color: GoloColors.secondary1,)
                  )),
            ));
  }
}
