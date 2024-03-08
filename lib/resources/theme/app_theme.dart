import 'package:code_jam_app/resources/basic_exports.dart';
import 'package:code_jam_app/resources/theme/text_theme.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    colorScheme: AppColors.lightColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme(AppStyles.textTheme),

  );
}
