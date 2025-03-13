import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackBarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackBarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    // clear the snackbars and avoid that snackb stay fixed for a while
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(
        label: 'Ok!',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

//~ custom dialog
  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text(
            'Elit sunt commodo magna officia aliqua exercitation proident ex sit Lorem. Ut velit mollit adipisicing commodo reprehenderit. Cupidatat aliquip in ut est consectetur eiusmod. Id irure ea qui aute dolor elit nulla veniam minim tempor sunt labore qui. Mollit minim sunt eu ipsum nisi pariatur in id nisi do excepteur consectetur aliqua. Aute eu proident deserunt excepteur deserunt ex amet esse voluptate ut.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: (){}, child: const Text('Aceptar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars and Dialogs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // like as: d-flex, align-items-center
          children: [
            FilledButton.tonal(
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    const Text(
                        'Laboris aute in esse ad occaecat id amet cillum. Minim velit velit labore incididunt ullamco proident ipsum ullamco occaecat occaecat culpa. Dolore quis nostrud Lorem proident et mollit anim veniam id cillum. Sint anim anim nisi exercitation consequat sunt enim cillum mollit cupidatat anim Lorem occaecat. Reprehenderit dolor laborum irure in sint non minim.')
                  ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () => openDialog(context),
                child: const Text('Mostrar diálogo')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
