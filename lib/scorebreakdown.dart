import 'dart:ui';

import 'package:flutter/material.dart';



class ScoreBreakDown{

  double screenW;
  double screenH;


  double x;
  double y;
  double xWidth;
  double xHeight;



  ScoreBreakDown(double w,double h){
    screenW=w;
    screenH=h;


    this.x=w/20;
    this.y=h/30;
    xWidth=w/12;
    xHeight=h/24;
    init();
  }
  init(){

  }
  draw(Canvas c,double basketX,double basketxWidth,double basketY,bool scoreUpdated,double ballY ,String s){


          if(scoreUpdated){
            TextSpan span5 = new TextSpan(style: new TextStyle( fontSize: screenW / 16,color:Color.fromRGBO(0, 0, 0, 0.5)), text: "+"+s);
            TextPainter tp5 = new TextPainter(text: span5, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
            tp5.layout();

            tp5.paint(c, new Offset(x,y));
            y-=1;
          }


          else{
            x=basketX+basketxWidth/3;
            y=basketY;
          }



  }


}