import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo({required this.title, required this.caption, required this.imageUrl});
}

final slides = <SlideInfo>[
  SlideInfo(title: 'Busca la comida', caption: 'Eiusmod aliquip enim esse anim cillum esse.', imageUrl: 'assets/images/1.png'),
  SlideInfo(title: 'Entrega rapida', caption: 'Elit nostrud consectetur exercitation tempor laboris non incididunt pariatur aute.', imageUrl: 'assets/images/2.png'),
  SlideInfo(title: 'Disfruta la comida', caption: 'Non ipsum consequat mollit adipisicing nisi.', imageUrl: 'assets/images/3.png'),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  // late final PageController pageviewController;
  final PageController pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;
      if ( !endReached && page >= (slides.length - 1.5)) {
        //! tener cuidado usar asi los setState dentro de initState y listeners
        //! cada que queremos usar un controller o un listener hacer uso de los: dispose()
        setState(() {
          endReached = true;
        });
      }
      // pueden ser valores entre 0.0 a 0.9... 1...
      // debugPrint('${ pageviewController.page }');
    });
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            //? controller: es como si tuvieramos control en un video de YT, poner pausa, adelantar, play...
            //? aplica en aquellos widgets donde hay scroll
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: slides.map(
                (slideData) => _Slide(title: slideData.title, caption: slideData.caption, imageUrl: slideData.imageUrl)
              ).toList(),
          ),

          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Salir')
            ),
          ),

          endReached ? Positioned(
            bottom: 30,
            right: 30,
          child: FadeInRight(
            from: 15,
            delay: const Duration(seconds: 1),
            child: FilledButton(
              child: const Text('Comenzar'),
              onPressed: () => context.pop(),
            ),
          ),
          ) : const SizedBox(),

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // vertical
          crossAxisAlignment: CrossAxisAlignment.start, // horizontal
          children: [
            Image(image: AssetImage(imageUrl), ),
            const SizedBox(height: 30),
            Text(title, style: titleStyle,),
            const SizedBox(height: 10),
            Text(caption, style: captionStyle,),
          ],
        ),
      ),
    );
  }
}