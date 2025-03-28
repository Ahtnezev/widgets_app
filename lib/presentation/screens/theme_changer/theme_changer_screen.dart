import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme_changer_screen';
  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // #1
    // final bool isDarkMode = ref.watch(isDarkmodeProvider);
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme changer'),
        actions: [
          IconButton(
            icon: Icon( isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {
              // ref.read(isDarkmodeProvider.notifier).update((state) => !state);
              // cuando no hacemos uso de riverpod, es porque lo crea automaticamente y cuando hacemos uso
              // es porque nosotros debemos encargarnos
              ref.read( themeNotifierProvider.notifier ).toggleDarkMode();
            },
          )
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<Color> colors = ref.watch(colorListProvider);
    final int selectedIndexColor = ref.watch(selectedColorProvider);

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {

        final Color color = colors[index];

        return RadioListTile(
          title: Text('Este color', style: TextStyle(color: color),),
          subtitle: Text('${color.value}'),
          activeColor: color, // color del radio seleccionado
          value: index,
          groupValue: selectedIndexColor,
          onChanged: (value) {
            // todo: notificar el cambio
            ref.read(selectedColorProvider.notifier).state = index;
          },
        );
      },
    );
  }
}