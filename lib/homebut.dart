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

  Rect but;
  Sprite home;
  Sprite gamePlan;
  Rect gamePlanRect;



  Rect bgBlack;
  Paint bgBlackPaint;

  Rect board;
  Paint boardPaint;


  HomeBut(double w, double h) {
    screenW = w;
    screenH = h;

    this.x = w/2.2;
    this.y = h *.58;
    xWidth = w / 10;
    xHeight = h / 20;
    home = Sprite('home.png');
    gamePlan=Sprite('gameplan.png');
    gamePlanRect=Rect.fromLTWH(w/5, h*.35, xWidth*1.5, xHeight*1.5);

    bgBlack=Rect.fromLTWH(0, 0, w, h);
    bgBlackPaint=Paint();
    bgBlackPaint.color=Color.fromRGBO(0, 0, 0, 0.5);

    board=Rect.fromLTWH(w/6, h/3, w*.70, h/3);
    boardPaint=Paint();
    boardPaint.color=Color.fromRGBO(255, 255, 255, 1);
  }

  draw(Canvas c) {

   c.drawRect(bgBlack, bgBlackPaint);
   c.drawRRect(RRect.fromRectAndRadius(board, Radius.circular(40)), boardPaint);
    but = Rect.fromLTWH(x, y, xWidth, xHeight);

      home.renderRect(c, but);
      gamePlan.renderRect(c, gamePlanRect);


  }

  bool onTapped(double x, double y) {
    bool kireturnkorbo=false;
    if(but.contains(Offset(x, y))){

     print("home clicked");
     kireturnkorbo=true;
    }
    return kireturnkorbo;
  }
}