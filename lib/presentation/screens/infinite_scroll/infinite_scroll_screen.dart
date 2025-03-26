import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {

  List<int> imagesIds = [1,2,3,4,5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // determinate if the user is at the end of the list
      // scrollController.position.pixels; // current position
      // scrollController.position.maxScrollExtent; // max position
      // treshold: espacio de gracia antes de llegar al final
      if ( (scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent ) {
        loadNextPage();
      }

    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  Future loadNextPage() async {
    // nos salimos y no volveremos a realizar la peticion si ya estamos cargando el contenido
    if (isLoading) return;
    isLoading = true;
    setState(() {});

    // esperamos 2s para volver a cargar las demas imagenes
    await Future.delayed(const Duration(seconds: 2));

    addFiveImages();
    isLoading = false;

    // todo: revisar si esta montado el componente / widget
    // verificar en los setState para saber si el componente se encuentra montado
    if (!isMounted) return;
    setState(() {});

    moveScrollToBottom();

  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});
    
    await Future.delayed(const Duration(seconds: 3));
    if (!isMounted) return;

    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();
    setState(() {});
  }

  /*
   * una vez que el usuario hizo scroll hasta el final, se carga el siguiente item y realiza un scroll hacia abajo
  */
  void moveScrollToBottom() {
    if (scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;

    scrollController.animateTo(
      scrollController.position.pixels + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn
    );
  }

  void addFiveImages() {
    final lastId = imagesIds.last; // take the last item of array
    // append 5 more...
    imagesIds.addAll(
      [1,2,3,4,5].map((e) => lastId + e) // sumar 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // .builder: construir bajo demanda
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true, // remove the top space
        //! for IOS
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10, // move the position the spinner
          strokeWidth: 2,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
          
              return FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage('https://picsum.photos/id/${ imagesIds[index] }/500/300'),
              );
            }
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: isLoading ? SpinPerfect(
          infinite: true,
          child: const Icon(Icons.refresh_rounded)
        ) : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined)), 
      ),

    );
  }
}