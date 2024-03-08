import 'package:code_jam_app/resources/basic_exports.dart';

class AppColors {
  static LinearGradient backgroundLinear = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffFFF5EB),
      Color(0xffFFF5EB),
    ],
  );

  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: Color(0xffFF8A1E),
    onPrimary: Color(0xffFFFFFF),
    secondary: Color(0xffFFFFFF),
    surface: Color(0xffFBC390),
    onSecondary: Color(0xff000000),
    onSecondaryContainer: Color(0xffFBC390),
    onPrimaryContainer: Color(0xff9B9292),
  );
}
