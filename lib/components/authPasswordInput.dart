import 'package:Instahelp/modules/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:Instahelp/helpers/sizeCalculator.dart';

class AuthPasswordInput extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final Function onChanged;
  AuthPasswordInput({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  _AuthPasswordInputState createState() => _AuthPasswordInputState();
}

class _AuthPasswordInputState extends State<AuthPasswordInput> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

   bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: widget.onChanged,
      style: TextStyle(
          color: GoloColors.secondary1,
          fontWeight: FontWeight.w500,
          fontSize: sizer(true,16.0,context)),
      cursorColor: GoloColors.primary,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
              // Based on passwordVisible state choose the icon
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color(0xff828A95),
              size: 20.0),
          onPressed: _toggle,
        ),
        contentPadding: EdgeInsets.symmetric(vertical:sizer(false,20,context),horizontal:sizer(true,20,context)),

        fillColor: Color(0xffF3F4F8),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Color(0xff828A95), fontSize: sizer(true,16.0,context)),
        errorMaxLines: 5,
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
          return "Password is required";
        } else if(val.length < 8){
          return 'Password must be a minimum of 8 characters, containing at least one uppercase letter, one lowercase letter, one number and one special character';
          }else if(!validateStructure(val)){
          return 'Password must contain at least one uppercase letter, one lowercase letter, one number and one special character';
        } else {
          return null;
        }
      },
    );
  }
}
