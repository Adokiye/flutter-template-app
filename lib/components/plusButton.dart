import 'package:flutter/material.dart';
import 'package:Instahelp/modules/setting/colors.dart';

class PlusButton extends StatelessWidget {
  final Function onPressed;
  const PlusButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffDFE8FC),
       shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
      child:InkWell(
        onTap: onPressed,
        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: 36,
                            height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: GoloColors.primary
                                      ),
         ) )),
        )  );
  }
}
