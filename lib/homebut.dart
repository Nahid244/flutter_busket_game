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



  Sprite home;
  Rect but;
  Sprite gamePlan;
  Rect gamePlanRect;

  Sprite bg;
  Rect bgRect;
  Sprite basketBg;
  Rect basketBgRect;

//  Sprite banner;
//  Rect bannerRect;
//
//
//  Rect bgBlack;
//  Paint bgBlackPaint;
//
//  Rect board;
//  Paint boardPaint;
//
//  Rect outerBoard;
//  Paint outerBoardPaint;

  TextSpan gameOver;
  TextPainter tp1;
  TextSpan yScore;
  TextPainter tp2;

  TextPainter tp3;
  TextSpan yName;
  TextSpan SScore;
  TextPainter tp4;

//  TextSpan hbut;
//  TextPainter tp4;

 // String test="00";

  HomeBut(double w, double h) {
    screenW = w;
    screenH = h;

    this.x = w*.43;
    this.y = h *.7;
    xWidth = w / 7;
    xHeight = w / 7;
    but = Rect.fromLTWH(x, y, xWidth, xHeight);
    home = Sprite('homepop.png');
    bg=Sprite("popbg.png");
    bgRect=Rect.fromLTWH(0, 0, w, h);

    basketBg=Sprite("basketpop.png");
    basketBgRect=Rect.fromLTWH(0,0 , w*.50, h*.3);

    gamePlan=Sprite('gameplannew.png');
    gamePlanRect=Rect.fromLTWH(w-(w/5)*1.2, h-(w/5), (w/5), (w/5));

//    banner=Sprite('banner.png');
//    bannerRect=Rect.fromLTWH(w*.35, h*.30, (w/10)*3.5, xHeight*1.5);
//
//    bgBlack=Rect.fromLTWH(0, 0, w, h);
//    bgBlackPaint=Paint();
//    bgBlackPaint.color=Color.fromRGBO(0, 0, 0, 0.5);
//   // bgBlackPaint.maskFilter=MaskFilter.blur(BlurStyle.outer, 50);
//
//    board=Rect.fromLTWH(w/6, h/3, w*.70, h/3);
//    boardPaint=Paint();
//    boardPaint.color=Color.fromRGBO(255, 255, 255, 1);
//
//    outerBoard=Rect.fromLTWH(w/6-w/200, h/3-h/400, w*.70+w/110, h/3+h/200);
//    outerBoardPaint=Paint();
//    outerBoardPaint.color=Color.fromRGBO(0, 0, 0, 1);

    //
//
    gameOver = new TextSpan(style: TextStyle(
      fontFamily: "font1",
      fontStyle: FontStyle.normal,
      fontSize: w/ 7,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(255, 255, 255, 1),
    ), text: "GAME OVER");
     tp1 = new TextPainter(text: gameOver,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp1.layout();

    yName = new TextSpan(style: TextStyle(
      fontFamily: "font1",
      fontStyle: FontStyle.normal,
      fontSize: w/ 8,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(255, 255, 255, 1),
    ), text: playerName);
    tp2 = new TextPainter(text: yName,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp2.layout();

    yScore = new TextSpan(style: TextStyle(
      fontFamily: "font1",
      fontStyle: FontStyle.normal,
      fontSize: w/ 6.8,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(255, 255, 255, 1),
    ), text:"Score");
    tp3 = new TextPainter(text: yScore,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp3.layout();


//
//   yScore  = new TextSpan(style: TextStyle(
//      fontStyle: FontStyle.normal,
//      fontSize: w/ 25,
//      foreground: Paint()
//        ..style = PaintingStyle.fill
//        ..strokeWidth = 6
//        ..color = Color.fromRGBO(0, 0, 0, 1),
//    ), text: "Your Score  ");
//    tp2 = new TextPainter(text: yScore,
//        textAlign: TextAlign.left,
//        textDirection: TextDirection.ltr);
//    tp2.layout();


//    hbut  = new TextSpan(style: TextStyle(
//      fontStyle: FontStyle.normal,
//      fontSize: w/ 25,
//      foreground: Paint()
//        ..style = PaintingStyle.fill
//        ..strokeWidth = 6
//        ..color = Color.fromRGBO(255, 255, 255, 1),
//    ), text: "Home");
//    tp4 = new TextPainter(text: hbut,
//        textAlign: TextAlign.left,
//        textDirection: TextDirection.ltr);
//    tp4.layout();


}

  draw(Canvas c,int score) {
    int length=playerName.length;
     bg.renderRect(c, bgRect);
     basketBg.renderRect(c, basketBgRect);
     gamePlan.renderRect(c, gamePlanRect);
     home.renderRect(c, but);
      tp1.paint(c, new Offset(screenW *.03, screenH *.31));
     // Offset o=;
     tp2.paint(c,new Offset(screenW*.5-tp2.width/2, screenH *.40) );//(font size:screenW/8)
     tp3.paint(c, new Offset(screenW *.28, screenH *.50));
//   c.drawRect(bgBlack, bgBlackPaint);
//   c.drawRRect(RRect.fromRectAndRadius(outerBoard, Radius.circular(4)),outerBoardPaint);
//   c.drawRRect(RRect.fromRectAndRadius(board, Radius.circular(4)), boardPaint);

//    but = Rect.fromLTWH(x, y, xWidth, xHeight);
//
//     // home.renderRect(c, but);
//   c.drawRRect(RRect.fromRectAndRadius(but, Radius.circular(6)), butPaint);
//   //tp4.paint(c, but.center.translate(-but.width/4, -but.height/4));
//
//     // banner.renderRect(c, bannerRect);
//      gamePlan.renderRect(c, gamePlanRect);
//   tp1.paint(c, new Offset(screenW / 3, screenH *.38));
//   //tp2.paint(c, new Offset(screenW /2.5, screenH *.42));
//
//
   SScore  = new TextSpan(style: TextStyle(
     fontFamily: "font1",
     fontStyle: FontStyle.normal,
     fontSize: screenW/ 7.8,
     foreground: Paint()
       ..style = PaintingStyle.fill
       ..strokeWidth = 6
       ..color = Color.fromRGBO(255, 255, 255, 1),
   ), text: score.toString());
   tp4= new TextPainter(text: SScore,
       textAlign: TextAlign.center,
       textDirection: TextDirection.ltr);
   tp4.layout();
//
//if(score.toString().length==1){
//  tp4.paint(c, new Offset(screenW *.43, screenH *.58));
//}
//else if(score.toString().length==2){
//  tp4.paint(c, new Offset(screenW *.39, screenH *.58));
//}else{
//  tp4.paint(c, new Offset(screenW *.33, screenH *.58));
//}

    tp4.paint(c, new Offset(screenW *.5-tp4.width/2, screenH *.58));
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