

import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_busket_game/publicdata.dart';
class SoundBut{

  double x;
  double y;
  double xWidth;
  double xHeight;
  double screenW;
  double screenH;
  Paint paint;
  Rect but;
  Sprite On;
  Sprite Off;

  SoundBut (double w,double h){

    screenW=w;
    screenH=h;

    this.x=w-w/6;
    this.y=h/30;
    xWidth=w/10;
    xHeight=h/20;
    On=Sprite('sound_on.png');
    Off=Sprite('sound_off.png');
  }
  draw(Canvas c){
    paint=Paint();
    but = Rect.fromLTWH(x, y, xWidth, xHeight);
    if(soundEnabled){
      //paint.color=Color.fromRGBO(255,99,71, 1);
      On.renderRect(c, but);
    }
    else{
     // paint.color=Color.fromRGBO(0,0,0, 1);
      Off.renderRect(c, but);
    }



  }
  void onTapped(double x,double y){
     if(but.contains(Offset(x, y))){

         if(soundEnabled){
          // enabled=false;
           soundEnabled=false;

         }
         else{

         //  enabled=true;
           soundEnabled=true;
         }
     }
  }
}