
// Tarea: Estado => isDarkmodeProvider = boolean

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Listado de colores inmutable
//! Provider: para valores inmutables
final colorListProvider = Provider((ref) => colorList);

//! StateProvider: para mantener alguna pieza de estado
// boolean
final isDarkmodeProvider = StateProvider<bool>((themeRef) => false);

// un simple int
final selectedColorProvider = StateProvider<int>((ref) => 0);


//! Un objeto de tipo AppTheme (custom)
//! StateNotifierProvider: se utiliza cuando el objeto es un poco mas elaborado, mantiene el estado
// este StateNotifierProvider es de tipo AppTheme (su clase personalizada)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

// class name: puede ser -> Notifier o Controller
class ThemeNotifier extends StateNotifier<AppTheme> {
  //! significa que necesito que haga una instancia del AppTheme, con sus valores por defecto de lo que tenga la clase
  // STATE = Estado = new AppTheme();
  ThemeNotifier(): super (AppTheme());

  void toggleDarkMode() {
    // state.isDarkMode = false;
    // copia del estado actual enviandole el valor opuesto
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }

  void changeColorIndex(int colorIndex) {

  }

}
