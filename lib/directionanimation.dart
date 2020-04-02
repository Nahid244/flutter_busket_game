import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter_busket_game/publicdata.dart';







class DirectionAnimation{

  double screenW;
  double screenH;


  double x;
  double y;
  double xWidth;
  double xHeight;

  SpriteSheet hand;
  Animation animation;

  double radius;
  Paint paint;
  int index;
  int index1;
  double i;
  double j;
  DirectionAnimation(double w,double h){
    screenW=w;
    screenH=h;

    index=0;
    index1=0;
    this.x=w/2;
    this.y=h*.7;
    xWidth=w/12;
    xHeight=h/24;
    radius=w/6;
    i=0;

    hand = SpriteSheet(
      imageName: 'spHand.png',
      textureWidth: 180,
      textureHeight: 180,
      columns: 5,
      rows: 5,
    );





  }

  draw(Canvas c){

    paint=Paint();
    paint.color=Color.fromRGBO(0,0,0, 0.6);

   // c.rotate(0.3);
    if(gamePause==false){
      index++;
      j=index/5;
    }


 //  print(index%200);
//
//       TextSpan span7 = new TextSpan(style: new TextStyle( fontSize: screenW / 20,color: Color.fromRGBO(0,0,0, 0.6)), text: "SWIPE");
//       TextPainter tp7 = new TextPainter(text: span7, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
//       tp7.layout();
//       tp7.paint(c, new Offset(screenW/2.35, screenH/3+screenH/8));






    hand.getSprite(i.toInt(),j.toInt()).renderRect(c, Rect.fromLTWH(x - radius, y - radius, radius * 2, radius * 2));

    if(index>20){
      index=0;
      i++;
      if(i>=5){
        i=0;
      }
    }


  //  c.drawLine(Offset(x, y), Offset(x+10, y+30), paint);


  }


}