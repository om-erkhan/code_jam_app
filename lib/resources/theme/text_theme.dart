import 'package:code_jam_app/resources/basic_exports.dart';

class AppStyles {
  static TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.lightColorScheme.primary,
    ),
    titleMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.lightColorScheme.primary,
    ),
    titleSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.lightColorScheme.onSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.lightColorScheme.onPrimaryContainer,
    ),
    bodyLarge: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.lightColorScheme.primary,
    ),
    bodyMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.lightColorScheme.primary,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.lightColorScheme.primary,
    ),
  );
}
