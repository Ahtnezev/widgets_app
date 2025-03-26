import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // estado actual del Scaffold
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // debemos tener referencia 
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
      // drawer abre de izq a der
      // enddrawer abre de der a izq
      // NavigationDrawer: crea el template en blanco vacio
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    // .builder -> se crea en tiempo de ejecucion
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];

        return _CustomTile(menuItem: menuItem, colors: colors);
      },
    );
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.menuItem,
    required this.colors,
  });

  final MenuItem menuItem;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary,),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary,),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        // navegar a otra pantalla
        //* .push() empuja una vista encima de la actual, .pop() remueve

        // #1
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const ButtonsScreen())
        // );

        // #2
        // Navigator.pushNamed(context, menuItem.link);

        // #3
        // context.pushNamed(CardScreen.name);
        context.push(menuItem.link);
        
      },
    );
  }
}
