import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';

Widget defaultFormField (context,{
  required TextEditingController controller,
  required TextInputType type,
  Function(String val)? onchanged,
  Function? onSupmited,

  FormFieldValidator? validator,
  required String label,
  required IconData prefix,
  Function? onTap,
  IconData? suffix,
  bool isClickable=false,
  bool secure = false,
})
{
  return TextFormField(
    controller: controller,
    obscureText: secure,
    keyboardType: type,
    style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold
    ),

    decoration: InputDecoration(
      labelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
      ),
      labelText: label,
      prefixIcon: Icon(prefix,
        color: Colors.grey,
      ),
      suffixIcon: suffix != null ? Icon(suffix,) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),

      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),

    ),
    readOnly: isClickable,
    onChanged: onchanged,
    onTap: onTap!=null? (){onTap();}:null,
    validator: validator,

  );

}

Widget defaultFormField_2 (context,{
  required TextEditingController controller,
  required TextInputType type,
  Function(String val)? onchanged,
  Function? onSupmited,

  FormFieldValidator? validator,
  IconData? prefix,
  Function? onTap,
  IconData? suffix,
  bool readOnly=false,
  bool secure = false,
}

    ) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.height;
  return TextFormField(
    controller: controller,
    obscureText: secure,
    keyboardType: type,
    style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold
    ),

    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: h*0.015,horizontal: w*0.01),
      filled: true,
      prefixIcon: prefix!=null?Icon(prefix,
      ):null,
      suffixIcon: suffix != null ? Icon(suffix,color: AppCubit.get(context).isDark?Colors.white.withOpacity(0.7):Colors.grey,) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),

      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),

    ),
    readOnly: readOnly,
    onChanged: onchanged,
    onTap: onTap!=null? (){onTap();}:null,
    validator: validator,

  );
}