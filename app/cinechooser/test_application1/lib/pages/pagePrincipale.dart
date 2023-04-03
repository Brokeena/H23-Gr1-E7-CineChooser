import 'package:cinechooser/utils/top_buttons_row.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:cinechooser/utils/movie_carte.dart';
import 'package:cinechooser/utils/bottom_buttons_row.dart';
import '../utils/app_styles.dart';
import '../utils/carte_overlay.dart';


class PagePrincipale extends StatefulWidget {
  const PagePrincipale({Key? key}) : super(key: key);

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {
  static const imageList = [
    'https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg',
    'https://image.tmdb.org/t/p/original/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg'
  ];

  final controller = SwipableStackController();

  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override //lsuihfsioghoiseg
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            const TopButtonsRow(),
            SwipableStack(
              detectableSwipeDirections: const {
                SwipeDirection.right,
                SwipeDirection.left,
              },
              controller: _controller,
              stackClipBehaviour: Clip.none,
              onSwipeCompleted: (index, direction) {
                if (kDebugMode) {
                  print('$index, $direction'); //debug
                }
              },
              builder: (context, properties) {
                final itemIndex = properties.index % imageList.length;

                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: SizedBox(
                          height: heigth*0.65,
                          width: width*0.9,
                          child: Cartes(
                            name: 'Film ${itemIndex + 1}',
                            genres: 'Genre du film ${itemIndex + 1}',
                            poster: imageList[itemIndex],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            BottomButtonsRow(
              onSwipe: (direction) {
                _controller.next(swipeDirection: direction);
              },
              onRewindTap: _controller.rewind,
              canRewind: _controller.canRewind,
            ),
          ],
        ),
      ),
    );
  }
}
