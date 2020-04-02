import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_busket_game/publicdata.dart';
class CrossButPop {

  double x;
  double y;
  double xWidth;
  double xHeight;
  double screenW;
  double screenH;

  Rect quitBut;
  Paint quitButPaint;
  Rect cancelBut;
  Paint cancelButPaint;



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

  TextSpan yQuite;
  TextPainter tp3;
  TextSpan yCancel;
  TextPainter tp4;


  CrossButPop(double w, double h) {
    screenW = w;
    screenH = h;

    this.x = w/5;
    this.y = h *.50;
    xWidth = w / 4;
    xHeight = w / 10;


    bgBlack=Rect.fromLTWH(0, 0, w, h);
    bgBlackPaint=Paint();
    bgBlackPaint.color=Color.fromRGBO(0, 0, 0, 0.5);
    // bgBlackPaint.maskFilter=MaskFilter.blur(BlurStyle.outer, 50);

    board=Rect.fromLTWH(w/6, h/3, w*.70, h/4);
    boardPaint=Paint();
    boardPaint.color=Color.fromRGBO(255, 255, 255, 1);

    outerBoard=Rect.fromLTWH(w/6-w/200, h/3-h/400, w*.70+w/110, h/4+h/200);
    outerBoardPaint=Paint();
    outerBoardPaint.color=Color.fromRGBO(0, 0, 0, 1);

    quitBut=Rect.fromLTWH(w/4.2,y, xWidth, xHeight);
    quitButPaint=Paint();
    quitButPaint.color=Color.fromRGBO(84, 119, 175, 1);

    cancelBut=Rect.fromLTWH(w*.55,y, xWidth, xHeight);
    cancelButPaint=Paint();
    cancelButPaint.color=Color.fromRGBO(84, 119, 175, 1);
    //

    yName = new TextSpan(style: TextStyle(
      fontStyle: FontStyle.normal,
      fontSize: w/ 25,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(0, 0, 0, 1),
    ), text: "If you quit now, your current score");
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
    ), text: "will be recorded as your final score.");
    tp2 = new TextPainter(text: yScore,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp2.layout();

    yQuite  = new TextSpan(style: TextStyle(
      fontStyle: FontStyle.normal,
      fontSize: w/ 25,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(255, 255, 255, 1),
    ), text: "Quit");
    tp3 = new TextPainter(text: yQuite,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp3.layout();

    yCancel  = new TextSpan(style: TextStyle(
      fontStyle: FontStyle.normal,
      fontSize: w/ 25,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 6
        ..color = Color.fromRGBO(255, 255, 255, 1),
    ), text: "Cancel");
    tp4 = new TextPainter(text: yCancel,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp4.layout();





  }

  draw(Canvas c) {

    c.drawRect(bgBlack, bgBlackPaint);
    c.drawRRect(RRect.fromRectAndRadius(outerBoard, Radius.circular(4)),outerBoardPaint);
    c.drawRRect(RRect.fromRectAndRadius(board, Radius.circular(4)), boardPaint);

   c.drawRRect(RRect.fromRectAndRadius(quitBut, Radius.circular(6)), quitButPaint);
    c.drawRRect(RRect.fromRectAndRadius(cancelBut, Radius.circular(6)), cancelButPaint);


    tp1.paint(c, new Offset(screenW / 5, screenH *.38));
    tp2.paint(c, new Offset(screenW /5, screenH *.42));

    tp3.paint(c, quitBut.center.translate(-quitBut.width/5, -quitBut.height/4));
    tp4.paint(c, cancelBut.center.translate(-cancelBut.width/4, -cancelBut.height/4));




  }

  String onTapped(double x, double y) {


    if(quitBut.contains(Offset(x, y))){


      return "Q";

    }
    else if(cancelBut.contains(Offset(x, y))){

      gamePause=false;
      return "C";

    }

  }
}