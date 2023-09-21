

import 'package:flutter/material.dart';

class ColorUtils {

  static const Color black34 = Color.fromRGBO(34, 34, 34, 1.0);

  static const Color gray153 = Color.fromRGBO(153, 153, 153, 1.0);
  static const Color gray248 = Color.fromRGBO(248, 248, 248, 1.0);
  
  

  static Color rgb(int r, int g, int b, {double alpha = 1}) {
    return Color.fromRGBO(r, g, b, alpha);
  }


}
