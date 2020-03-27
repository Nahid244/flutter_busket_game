import 'dart:ui';

import 'package:flutter_busket_game/basketback.dart';

class Basket {
  double x;
  double y;
  double xWidth;
  double xHeight;
  double screenW;
  double screenH;

  Paint paint;
  bool leftrun;
  bool rightrun;
  Basket(double w,double h){

    init(w,h);
  }
  init(double w,double h){
    screenW=w;
    screenH=h;
    this.x=w/3+w/21;
    this.y=h/4+h/30;
    xWidth=w/4+w/100;
    xHeight=h/100;
    leftrun=true;
    rightrun=false;
  }
  draw(Canvas c){
    paint=Paint();
    paint.color=Color.fromRGBO(255,99,71, 1);
    Rect baskt = Rect.fromLTWH(x, y, xWidth, xHeight);
    c.drawRRect(RRect.fromRectAndRadius(baskt, Radius.circular(20)), paint);


  }
  update(int level, BasketBack basketback){
   if(level==3 || level==5){
x=basketback.x+screenW/5-screenW/49;
y=basketback.y+screenH/11+screenH/11;

   }
   else if(level==4){
     x=basketback.x+screenW/5-screenW/49;
     y=basketback.y+screenH/11+screenH/11;
   }
  }

}