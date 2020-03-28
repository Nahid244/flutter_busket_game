import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_busket_game/publicdata.dart';

class Live{

  double screenW;
  double screenH;
  Sprite life1;

  double x;
  double y;
  double xWidth;
  double xHeight;



  Live(double w,double h){
   screenW=w;
   screenH=h;
   life1=Sprite('heart_life.png');

   this.x=w/20;
   this.y=h/30;
   xWidth=w/12;
   xHeight=h/24;

  }
  draw(Canvas c){

   double distanceLife=0;
   for(int i=1;i<=life;i++){
     life1.renderRect(c, Rect.fromLTWH(x+distanceLife, y, xWidth, xHeight));
     distanceLife+=xWidth;
   }

  }

}