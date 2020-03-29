import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_busket_game/publicdata.dart';

class ScoreBoard{

  double screenW;
  double screenH;


  double x;
  double y;
  double xWidth;
  double xHeight;
  Sprite Score;


  ScoreBoard(double w,double h){
    screenW=w;
    screenH=h;
    Score=Sprite('scoreback.png');

    this.x=w/3+w / 20;
    this.y=h/30;
    xWidth=w/4;
    xHeight=h/24;

  }
  draw(Canvas c,int score){
    Score.renderRect(c, Rect.fromLTWH(x, y, xWidth, xHeight));
    TextSpan span = new TextSpan(style: new TextStyle(
             color: Color.fromRGBO(255,99,71, 1), fontSize: screenW / 16),
             text: score.toString());
         TextPainter tp = new TextPainter(text: span,
             textAlign: TextAlign.left,
             textDirection: TextDirection.ltr);
         tp.layout();
    tp.paint(c, new Offset(x+screenW / 20,y));

    }

  }

