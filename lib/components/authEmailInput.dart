import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';

class AuthEmailInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  const AuthEmailInput({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
        onSaved: onChanged,
        style: TextStyle(color: GoloColors.secondary1, fontWeight: FontWeight.w500, fontSize: sizer(true,16.0,context)),
        cursorColor: GoloColors.primary,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical:sizer(false,20,context),horizontal:sizer(true,20,context)),

          fillColor: Color(0xffF3F4F8),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xff828A95), fontSize: sizer(true,16.0,context)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1.5, 
                color: GoloColors.primary,
            ),
        ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
          filled: true,
        ),
        
        validator: (val) {
        if (val.length == 0) {
          return hintText+ " is required";
        } else {
          return null;
        }
      },
    );
  }
}
