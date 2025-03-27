import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  // para saber cuando el usuario da click a un menu y quede marcado el "estilo selected"
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    // para saber el espacio ocupado en top ya que unos telefonos tienen notch o IOS/Android
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        // indice, opcion seleccionada
        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        //* para poder hacer referencia de la variable que esta fuera de nuestro widget 
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Main')
        ),

        ...appMenuItems
          .sublist(0,3) // muestra los primeros 3 items del menu
          .map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title)
          )
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More options')
        ),

        ...appMenuItems
          .sublist(3) // muestra los primeros 3 items del menu
          .map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title)
          )
        ),

      ],
    );
  }
}