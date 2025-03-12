import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  static const String name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          context.pop(); // back
        },
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  // just we need the {super.key} if we need it on another file
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity, // take the 100% with the `Padding`
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Wrap(
            // text-wrap
            spacing: 10, // margin
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center, // center the icons
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
              const ElevatedButton(
                  onPressed: null, child: Text('Elevated Disabled')),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.access_alarm_rounded),
                  label: const Text('Elevated Icon')),

                FilledButton(onPressed: () {}, child: const Text('Filled')),
                FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.ac_unit_sharp), label: const Text('Filled Icon'),),

                OutlinedButton(onPressed: (){}, child: const Text('Outline')),
                OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.terminal_sharp), label: const Text('Outline')),

                TextButton(onPressed: (){}, child: const Text('Text')),
                TextButton.icon(onPressed: (){}, icon: const Icon(Icons.telegram), label: const Text('Text Icon'),),

                //todo: custom button

                const CustomButton(),

                IconButton(onPressed: (){}, icon: const Icon(Icons.access_time)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.accessible_forward_sharp), style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(colors.primary),
                  iconColor: const MaterialStatePropertyAll(Colors.white),
                ),),

            ],
          )),
    );
  }
}


class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // to redounded borders
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: colors.primary,
        // react to text
        child: InkWell(
          onTap: (){},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Hola Mundo', style: TextStyle(color: Colors.white),)
            ),
        ),
      ),
    );
  }
}