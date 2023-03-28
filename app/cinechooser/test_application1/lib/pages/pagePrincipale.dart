import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/api/movie.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/utils/top_buttons_row.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:cinechooser/utils/movie_carte.dart';
import 'package:cinechooser/utils/carte_overlay.dart';
import 'package:cinechooser/utils/bottom_buttons_row.dart';

import '../utils/app_styles.dart';

class PagePrincipale extends StatefulWidget {
  const PagePrincipale({Key? key}) : super(key: key);

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {
  static const imageList = [
    'https://m.media-amazon.com/images/I/71xefrbhS8S._AC_SL1500_.jpg',
    'https://marketplace.canva.com/EAFH3gODxw4/1/0/1131w/canva-black-%26-white-modern-mystery-forest-movie-poster-rLty9dwhGG4.jpg'
  ];

  final controller = SwipableStackController();

  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SwipableStack(
                  detectableSwipeDirections: const {
                    SwipeDirection.right,
                    SwipeDirection.left,
                  },
                  controller: _controller,
                  stackClipBehaviour: Clip.none,
                  onSwipeCompleted: (index, direction) {
                    if (kDebugMode) {
                      print('$index, $direction');
                    }
                  },
                  horizontalSwipeThreshold: 0.8,
                  verticalSwipeThreshold: 0.8,
                  builder: (context, properties) {
                    final itemIndex = properties.index % imageList.length;

                    return Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 650,
                            width: 500,
                            child: Cartes(
                              name: 'Carte numéro ${itemIndex + 1}',
                              synopsis: 'histoire du film ${itemIndex + 1}',
                              poster: imageList[itemIndex],
                            ),
                          ),
                        ),
                        if (properties.stackIndex == 0 &&
                            properties.direction != null)
                          OverlayCarte(
                            swipeProgress: properties.swipeProgress,
                            direction: properties.direction!,
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
            BottomButtonsRow(
              onSwipe: (direction) {
                _controller.next(swipeDirection: direction);
              },
              onRewindTap: _controller.rewind,
              canRewind: _controller.canRewind,
            ),
            const TopButtonsRow()
          ],
        ),
      ),
    );
  }
}
