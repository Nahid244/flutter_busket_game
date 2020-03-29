import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_busket_game/publicdata.dart';
class HomeBut {

  double x;
  double y;
  double xWidth;
  double xHeight;
  double screenW;
  double screenH;
  Paint paint;
  Rect but;
  Sprite home;
  Canvas cc;


  HomeBut(double w, double h) {
    screenW = w;
    screenH = h;

    this.x = w/2.2;
    this.y = h / 2+h/5;
    xWidth = w / 10;
    xHeight = h / 20;
    home = Sprite('home.png');

  }

  draw(Canvas c) {
   cc=c;
    paint = Paint();
    but = Rect.fromLTWH(x, y, xWidth, xHeight);

      home.renderRect(c, but);


  }

  void onTapped(double x, double y) {
    if(but.contains(Offset(x, y))){

     print("home clicked");
    }
  }
}