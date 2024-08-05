import 'package:my_weather_app/presentation/consts/consts.dart';

Widget customTextField(
    {required TextEditingController controller,
    required String hintText,
    Widget? suffixIcon,
    required String? Function(String?)? validator,
    required bool obscureText,
    required TextInputType keyBoardType}) {
  return TextFormField(
    style: const TextStyle(color: white),
    controller: controller,
    validator: validator,
    keyboardType: keyBoardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      border: InputBorder.none,
      suffixIcon: suffixIcon,
      hintStyle: const TextStyle(
          color: grey,
          fontWeight: FontWeight.normal,
          fontSize: smallFont,
          fontFamily: poppins),
      isDense: true,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(smallBorderRadius),
          borderSide: const BorderSide(width: 2, color: white)),
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(smallBorderRadius),
        borderSide: const BorderSide(width: 1, color: white),
      ),
    ),
  );
}
