import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Helper function to create a TextStyle with optional color, size, and fontWeight
  static TextStyle _inter({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  // Regular Styles (default weight: w400)
  static TextStyle regular10({Color? color}) => _inter(size: 10, weight: FontWeight.w400, color: color);
  static TextStyle regular11({Color? color}) => _inter(size: 11, weight: FontWeight.w400, color: color);
  static TextStyle regular12({Color? color}) => _inter(size: 12, weight: FontWeight.w400, color: color);
  static TextStyle regular13({Color? color}) => _inter(size: 13, weight: FontWeight.w400, color: color);
  static TextStyle regular14({Color? color}) => _inter(size: 14, weight: FontWeight.w400, color: color);
  static TextStyle regular15({Color? color}) => _inter(size: 15, weight: FontWeight.w400, color: color);
  static TextStyle regular16({Color? color}) => _inter(size: 16, weight: FontWeight.w400, color: color);
  static TextStyle regular17({Color? color}) => _inter(size: 17, weight: FontWeight.w400, color: color);
  static TextStyle regular18({Color? color}) => _inter(size: 18, weight: FontWeight.w400, color: color);
  static TextStyle regular19({Color? color}) => _inter(size: 19, weight: FontWeight.w400, color: color);
  static TextStyle regular20({Color? color}) => _inter(size: 20, weight: FontWeight.w400, color: color);
  static TextStyle regular21({Color? color}) => _inter(size: 21, weight: FontWeight.w400, color: color);
  static TextStyle regular22({Color? color}) => _inter(size: 22, weight: FontWeight.w400, color: color);
  static TextStyle regular23({Color? color}) => _inter(size: 23, weight: FontWeight.w400, color: color);
  static TextStyle regular24({Color? color}) => _inter(size: 24, weight: FontWeight.w400, color: color);
  static TextStyle regular25({Color? color}) => _inter(size: 25, weight: FontWeight.w400, color: color);

  // SemiBold Styles (default weight: w600)
  static TextStyle semiBold10({Color? color}) => _inter(size: 10, weight: FontWeight.w600, color: color);
  static TextStyle semiBold11({Color? color}) => _inter(size: 11, weight: FontWeight.w600, color: color);
  static TextStyle semiBold12({Color? color}) => _inter(size: 12, weight: FontWeight.w600, color: color);
  static TextStyle semiBold13({Color? color}) => _inter(size: 13, weight: FontWeight.w600, color: color);
  static TextStyle semiBold14({Color? color}) => _inter(size: 14, weight: FontWeight.w600, color: color);
  static TextStyle semiBold15({Color? color}) => _inter(size: 15, weight: FontWeight.w600, color: color);
  static TextStyle semiBold16({Color? color}) => _inter(size: 16, weight: FontWeight.w600, color: color);
  static TextStyle semiBold17({Color? color}) => _inter(size: 17, weight: FontWeight.w600, color: color);
  static TextStyle semiBold18({Color? color}) => _inter(size: 18, weight: FontWeight.w600, color: color);
  static TextStyle semiBold19({Color? color}) => _inter(size: 19, weight: FontWeight.w600, color: color);
  static TextStyle semiBold20({Color? color}) => _inter(size: 20, weight: FontWeight.w600, color: color);
  static TextStyle semiBold21({Color? color}) => _inter(size: 21, weight: FontWeight.w600, color: color);
  static TextStyle semiBold22({Color? color}) => _inter(size: 22, weight: FontWeight.w600, color: color);
  static TextStyle semiBold23({Color? color}) => _inter(size: 23, weight: FontWeight.w600, color: color);
  static TextStyle semiBold24({Color? color}) => _inter(size: 24, weight: FontWeight.w600, color: color);
  static TextStyle semiBold25({Color? color}) => _inter(size: 25, weight: FontWeight.w600, color: color);

  // Bold Styles (default weight: w700)
  static TextStyle bold10({Color? color}) => _inter(size: 10, weight: FontWeight.w700, color: color);
  static TextStyle bold11({Color? color}) => _inter(size: 11, weight: FontWeight.w700, color: color);
  static TextStyle bold12({Color? color}) => _inter(size: 12, weight: FontWeight.w700, color: color);
  static TextStyle bold13({Color? color}) => _inter(size: 13, weight: FontWeight.w700, color: color);
  static TextStyle bold14({Color? color}) => _inter(size: 14, weight: FontWeight.w700, color: color);
  static TextStyle bold15({Color? color}) => _inter(size: 15, weight: FontWeight.w700, color: color);
  static TextStyle bold16({Color? color}) => _inter(size: 16, weight: FontWeight.w700, color: color);
  static TextStyle bold17({Color? color}) => _inter(size: 17, weight: FontWeight.w700, color: color);
  static TextStyle bold18({Color? color}) => _inter(size: 18, weight: FontWeight.w700, color: color);
  static TextStyle bold19({Color? color}) => _inter(size: 19, weight: FontWeight.w700, color: color);
  static TextStyle bold20({Color? color}) => _inter(size: 20, weight: FontWeight.w700, color: color);
  static TextStyle bold21({Color? color}) => _inter(size: 21, weight: FontWeight.w700, color: color);
  static TextStyle bold22({Color? color}) => _inter(size: 22, weight: FontWeight.w700, color: color);
  static TextStyle bold23({Color? color}) => _inter(size: 23, weight: FontWeight.w700, color: color);
  static TextStyle bold24({Color? color}) => _inter(size: 24, weight: FontWeight.w700, color: color);
  static TextStyle bold25({Color? color}) => _inter(size: 25, weight: FontWeight.w700, color: color);
}
