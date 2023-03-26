import 'package:flutter/material.dart';


enum CardStatus {like, dislike, superLike}

class CardProvider extends ChangeNotifier {
  List<String> _urlImage = ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDstxpX8FgO24-O3LSqLzvfOiwHV_ubon9sQ&usqp=CAU',
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDstxpX8FgO24-O3LSqLzvfOiwHV_ubon9sQ&usqp=CAU'];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<String> get urlImages => _urlImage;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  cardProvider() {
    resetUsers();
  }


  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details){
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details){
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * (x / _screenSize.width);

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.like: like();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x =  _position.dx;

    const delta = 100;

    if (x>=delta)
      {
        return CardStatus.like;
      }


  }

  void resetUsers() {
    _urlImage = <String>['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuApOKVCw5CZez8AOTKjutOxU2_P8aQeaMSW0JEWq1AvT3UFXaUXKdaoocljrcdBZrZ_0&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDstxpX8FgO24-O3LSqLzvfOiwHV_ubon9sQ&usqp=CAU'
    ].reversed.toList();
    notifyListeners();
  }

  void like() {
  _angle = 20;
  _position += Offset(_screenSize.width * 2, 0);
  _nextCard();
  notifyListeners();

  }

  Future _nextCard() async {

    if (_urlImage.isEmpty){
      return;}

      await Future.delayed(const Duration(milliseconds: 200));

      _urlImage.removeLast();
      resetPosition();
    }


  }


