import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_busket_game/publicdata.dart';
class CrossBut{

  double x;
  double y;
  double xWidth;
  double xHeight;
  double screenW;
  double screenH;

  Rect but;
  Sprite cross;

  CrossBut (double w,double h){

    screenW=w;
    screenH=h;


    xWidth=w/14;
    xHeight=h/28;
    this.x=w-xWidth;
    this.y=h/100;
    cross=Sprite('cross.png');
    but = Rect.fromLTWH(x, y, xWidth, xHeight);
  }
  draw(Canvas c){

    cross.renderRect(c, but);




  }
  void onTapped(double x,double y){
    if(but.contains(Offset(x, y))){

        gamePause=true;

    }
  }
}