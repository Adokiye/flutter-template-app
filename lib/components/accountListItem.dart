import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';

class AccountListItem extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  AccountListItem({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _AccountListItemState createState() => _AccountListItemState();
}

class _AccountListItemState extends State<AccountListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
          color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(color: Colors.red)
            ),
     //       color: Color(0xff245DE8),
            child: InkWell(
              onTap: widget.onPressed,
              child: Container(
                margin: EdgeInsets.only(bottom: sizer(false,19,context)),
                  padding: EdgeInsets.only(bottom: sizer(false,18,context)),
                  decoration: BoxDecoration(
               //      color: Color(0xffffffff), 
                  //   borderRadius: BorderRadius.circular(10.0),
                     border: Border(bottom: BorderSide(color: Color(0xffF3F4F8), width: 1.0))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                            Text(widget.title, style: TextStyle(color: GoloColors.secondary1, 
                            fontSize: sizer(true,16.0,context))),
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF3F4F8),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                                child: Icon(Icons.chevron_right,
                                    size: sizer(true,17.0,context), color: Color(0xff091118))),
                         
                      ),  
                    ],
                  )),
            )));
  }
}
