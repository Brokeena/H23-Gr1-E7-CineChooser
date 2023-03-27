import 'package:test_application1/api/api.dart';
import 'package:test_application1/api/movie.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:test_application1/utils/movie_card.dart';
import 'package:test_application1/utils/card_overlay.dart';
import 'package:test_application1/utils/bottom_buttons_row.dart';


class PagePrincipale extends StatefulWidget {



  const PagePrincipale({Key? key}) : super(key: key);



  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {

  static const imageList = [
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.movieposters.com%2F&psig=AOvVaw3r-YMW8GklSzFDkujSHEN7&ust=1680031409599000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCPj6ufXq_P0CFQAAAAAdAAAAABAE',
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.movieposters.com%2F&psig=AOvVaw3r-YMW8GklSzFDkujSHEN7&ust=1680031409599000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCPj6ufXq_P0CFQAAAAAdAAAAABAJ',
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.ebay.fr%2Fitm%2F115504916055&psig=AOvVaw3r-YMW8GklSzFDkujSHEN7&ust=1680031409599000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCPj6ufXq_P0CFQAAAAAdAAAAABAT'
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
      body: SafeArea(
        top: false,
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
                    final itemIndex = properties.index % 3;

                    return Stack(
                      children: [
                        ExampleCard(
                          name: 'Sample No.${itemIndex + 1}',
                          assetPath: imageList[itemIndex],
                        ),
                        // more custom overlay possible than with overlayBuilder
                        if (properties.stackIndex == 0 &&
                            properties.direction != null)
                          CardOverlay(
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
          ],
        ),
      ),
    );
  }
}




