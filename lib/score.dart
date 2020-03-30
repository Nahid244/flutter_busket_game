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
    this.y=h/48;
    xWidth=w/4;
    xHeight=h/18;

  }
  draw(Canvas c,int score){
    String s=score.toString();
   // s="";
    Score.renderRect(c, Rect.fromLTWH(x, y, xWidth, xHeight));
    TextSpan span = new TextSpan(style: new TextStyle(
             color: Color.fromRGBO(255,255,255, 1), fontSize: screenW / 14),
             text: s);
         TextPainter tp = new TextPainter(text: span,
             textAlign: TextAlign.left,
             textDirection: TextDirection.ltr);
         tp.layout();
      if(s.length==1){
        tp.paint(c, new Offset(x+screenW / 10,y));
      }
      else if(s.length==2){
        tp.paint(c, new Offset(x+screenW / 13,y));
      }
      else{
        tp.paint(c, new Offset(x+screenW / 16,y));
      }


    }

  }

