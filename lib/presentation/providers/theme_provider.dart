
// Tarea: Estado => isDarkmodeProvider = boolean

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// bool
final isDarkmodeProvider = StateProvider<bool>((themeRef) => false);

// 
final selectedColorProvider = StateProvider<int>((ref) => 0);
