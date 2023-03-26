import 'package:flutter/material.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
}) =>
    TextFormField(
      controller: controller,
      maxLength: 3,
      cursorColor: greenPrimaryColor,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: hintText,
          counterText: "",
          border: InputBorder.none,
          focusColor: greenPrimaryColor,
          fillColor: greenPrimaryColor,
          hoverColor: greenPrimaryColor,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: greenPrimaryColor,
          ))),
    );
