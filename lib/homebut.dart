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

  Sprite banner;
  Rect bannerRect;


  Rect bgBlack;
  Paint bgBlackPaint;

  Rect board;
  Paint boardPaint;

  Rect outerBoard;
  Paint outerBoardPaint;

  TextSpan yName;
  TextPainter tp1;
  TextSpan yScore;
  TextPainter tp2;
  TextSpan SScore;
  TextPainter tp3;



  HomeBut(double w, double h) {
    screenW = w;
    screenH = h;

    this.x = w/2.2;
    this.y = h *.58;
    xWidth = w / 10;
    xHeight = w / 10;
    home = Sprite('home.png');
    gamePlan=Sprite('gameplan.png');
    gamePlanRect=Rect.fromLTWH(w/5, h*.35, xWidth, xHeight);

    banner=Sprite('banner.png');
    bannerRect=Rect.fromLTWH(w*.35, h*.30, xWidth*3.5, xHeight*1.5);

    bgBlack=Rect.fromLTWH(0, 0, w, h);
    bgBlackPaint=Paint();
    bgBlackPaint.color=Color.fromRGBO(0, 0, 0, 0.5);
   // bgBlackPaint.maskFilter=MaskFilter.blur(BlurStyle.outer, 50);

    board=Rect.fromLTWH(w/6, h/3, w*.70, h/3);
    boardPaint=Paint();
    boardPaint.color=Color.fromRGBO(255, 255, 255, 1);

    outerBoard=Rect.fromLTWH(w/6-w/100, h/3-w/100, w*.70+w/50, h/3+w/50);
    outerBoardPaint=Paint();
    outerBoardPaint.color=Color.fromRGBO(0, 0, 0, 1);

    //

     yName = new TextSpan(style: TextStyle(
      fontStyle: FontStyle.normal,
      fontSize: w/ 25,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(0, 0, 0, 1),
    ), text: "Your Name : "+playerName);
     tp1 = new TextPainter(text: yName,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp1.layout();

   yScore  = new TextSpan(style: TextStyle(
      fontStyle: FontStyle.normal,
      fontSize: w/ 25,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(0, 0, 0, 1),
    ), text: "Your Score  ");
    tp2 = new TextPainter(text: yScore,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp2.layout();





}

  draw(Canvas c,int score) {

   c.drawRect(bgBlack, bgBlackPaint);
   c.drawRRect(RRect.fromRectAndRadius(outerBoard, Radius.circular(4)),outerBoardPaint);
   c.drawRRect(RRect.fromRectAndRadius(board, Radius.circular(4)), boardPaint);

    but = Rect.fromLTWH(x, y, xWidth, xHeight);

      home.renderRect(c, but);
      banner.renderRect(c, bannerRect);
      gamePlan.renderRect(c, gamePlanRect);
   tp1.paint(c, new Offset(screenW / 3, screenH *.38));
   tp2.paint(c, new Offset(screenW /2.5, screenH *.42));


   SScore  = new TextSpan(style: TextStyle(
     fontStyle: FontStyle.normal,
     fontSize: screenW/ 10,
     foreground: Paint()
       ..style = PaintingStyle.fill
       ..strokeWidth = 6
       ..color = Color.fromRGBO(0, 0, 0, 1),
   ), text: score.toString());
   tp3 = new TextPainter(text: SScore,
       textAlign: TextAlign.center,
       textDirection: TextDirection.ltr);
   tp3.layout();

if(score.toString().length==1){
  tp3.paint(c, new Offset(screenW *.45, screenH *.48));
}
else if(score.toString().length==2){
  tp3.paint(c, new Offset(screenW *.42, screenH *.48));
}else{
  tp3.paint(c, new Offset(screenW *.39, screenH *.48));
}


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