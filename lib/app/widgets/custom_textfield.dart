import 'package:flutter/material.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  void Function()? function,
  int? maxLength,
}) =>
    TextFormField(
      controller: controller,
      maxLength: maxLength ?? 3,
      autofocus: true,
      cursorColor: greenPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.search,
      onEditingComplete: function,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            )),
        counterText: "",
        focusColor: greenPrimaryColor,
        suffixIconColor: Colors.white,
        iconColor: Colors.white,
        fillColor: greenPrimaryColor,
        hoverColor: greenPrimaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: greenDarkerColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: greenDarkerColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: greenDarkerColor),
        ),
      ),
    );
