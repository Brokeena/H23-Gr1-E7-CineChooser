import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application1/trashTinder/CardProvider.dart';

class MovieCard extends StatefulWidget {

  final String urlImage;
  //final bool isFront;

  const MovieCard({Key? key, required this.urlImage, /*required this.isFront */}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context);
      provider.setScreenSize(size);
    }
    );
  }


  @override
  Widget build(BuildContext context) => SizedBox.expand(
  //  child: widget.isFront ? builFrontdCard() : buildCard(),
  );

 Widget buildCard() => ClipRRect(
   borderRadius: BorderRadius.circular(20),
   child: Container(
     decoration: BoxDecoration(
       image: DecorationImage(
         image: NetworkImage(widget.urlImage),
         fit: BoxFit.cover,
       )
     ),
   ),
 );



  Widget builFrontdCard() => GestureDetector(


    child: LayoutBuilder(
      builder: (context, constraints){
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        final milliseconds = provider.isDragging ? 0 : 400;

        final center = constraints.smallest.center(Offset.zero);
        final angel = provider.angle * pi / 180;
        final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(angel)
          ..translate(-center.dx, -center.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
          child: buildCard(),
        );
      },
    ),
    onPanStart: (details) {
      final provider = Provider.of<CardProvider>(context);
          provider.startPosition(details);
    },
    onPanUpdate: (details){
      final provider = Provider.of<CardProvider>(context);
      provider.updatePosition(details);
    },
    onPanEnd: (details) {
      final provider = Provider.of<CardProvider>(context);
      provider.endPosition();
    },




  );

}


