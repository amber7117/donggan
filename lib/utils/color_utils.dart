

import 'package:flutter/material.dart';

class ColorUtils {

  static const Color red235 = Color.fromRGBO(235, 77, 77, 1.0);

  static const Color black34 = Color.fromRGBO(34, 34, 34, 1.0);
  static const Color black51 = Color.fromRGBO(51, 51, 51, 1.0);

  static const Color gray153 = Color.fromRGBO(153, 153, 153, 1.0);
  static const Color gray240 = Color.fromRGBO(240, 240, 240, 1.0);
  static const Color gray248 = Color.fromRGBO(248, 248, 248, 1.0);
  
  

  static Color rgb(int r, int g, int b, {double alpha = 1}) {
    return Color.fromRGBO(r, g, b, alpha);
  }


}
