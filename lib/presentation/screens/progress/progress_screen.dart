import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress indicators')
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30,),

          Text('Circular progress indicator'),
          SizedBox(height: 10,),
          CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black45,),

          SizedBox(height: 20,),
          Text('Circular y Linear controlado'),
          SizedBox(height: 10,),

          _ControlledProgressIndicator(),

        ],
      ),
    );
  }
}


class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
        return (value * 2) / 100; // 0.0, 1.0
      }).takeWhile((value) => value < 100), // flujo de informacion
      // takeWhile -> terminar el proceso
      // context -> informacion del arbol
      // snapshot -> valor que tiene nuestro stream
      builder: (context, snapshot) {

        final progressValue = snapshot.data ?? 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // centrar
            children: [
              CircularProgressIndicator(value: progressValue, strokeWidth: 2, backgroundColor: Colors.black12,),
              const SizedBox(width: 20,),
        
              Expanded(
                child: LinearProgressIndicator(value: progressValue,),
              )
        
            ],
          ),
        );
      },
    );
  }
}