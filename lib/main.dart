import 'dart:async';
import 'dart:typed_data';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as UI;
import 'dart:math' as Math;

import 'package:flutter/services.dart';
import 'package:flutter_busket_game/ball.dart';
import 'package:flutter_busket_game/basket.dart';
import 'package:flutter_busket_game/basketback.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/position.dart';
import 'package:flutter_busket_game/cross.dart';
import 'package:flutter_busket_game/crosspop.dart';
import 'package:flutter_busket_game/homebut.dart';
import 'package:flutter_busket_game/life.dart';
import 'package:flutter_busket_game/publicdata.dart';
import 'package:flutter_busket_game/score.dart';
import 'package:flutter_busket_game/scorebreakdown.dart';
import 'package:flutter_busket_game/soundButton.dart';

import 'directionanimation.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  GG game=GG();

  runApp(game.widget);

  PanGestureRecognizer pan=PanGestureRecognizer();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
 // tapper.onTapUp=game.onTapUp();
  pan.onStart=game.onPanStart;
  pan.onUpdate=game.onPanUpdate;
  pan.onEnd=game.onPanEnd;
  flameUtil.addGestureRecognizer(pan);
  flameUtil.addGestureRecognizer(tapper);

}
class GG extends Game{
  Size screenSize;


  @override
  void onAttach() {

  }

  int gameTimer;
  SoundBut soundBut;
  CrossBut crossBut;
  CrossButPop crossButPop;
  HomeBut hbut;
  Live live;
  Ball ball;
  double ballInitalPosX;
  double ballInitalPosY;


  List<Basket> basket=[];
  double basketLeftPointX;
  double basketLeftPointY;

  double basketRightPointX;
  double basketRightPointY;


  List<BasketBack> basketback=[];
  List<ScoreBreakDown> scoreBreakDown=[];

  bool shootball=false;
  bool panStartFromRightPos;
  ///

  double panFingerPosX=0;
  double panFingerPosY;

  double panStartFingerPosX=0;
  double panStartFingerPosY;
  //direction
  double ballShootAmount;
  ///
  int pastLevel;
  int presentLevel;

  DirectionAnimation dirAnim;
  ScoreBoard scoreBoard;
/////////
  Rect bgRect;
  Paint bgPaint;

  GG(){

    initialize();

  }


  void initialize() async {

    resize(await Flame.util.initialDimensions());
    init();
  }
  void init(){
    gameTimer=0;
    life=3;

     soundEnabled=true;
    firstTimeTuto=true;

     playerName="Rohim";
    gamePause=false;

    live=Live(screenSize.width,screenSize.height);


    ball=Ball(screenSize.width,screenSize.height,screenSize.width/7);
    // basket=Basket(screenSize.width,screenSize.height);

    basket.add(Basket(screenSize.width,screenSize.height));
    basket.add(Basket(screenSize.width,screenSize.height));

    // basketback=BasketBack(screenSize.width, screenSize.height,true,false);

    basketback.add(BasketBack(screenSize.width, screenSize.height,true,false,screenSize.width/5,screenSize.height/10));

    basketback.add(BasketBack(screenSize.width, screenSize.height,false,true,screenSize.width/5,screenSize.height/3+screenSize.height/40));

    ballInitalPosX=ball.x;
    ballInitalPosY=ball.y;
    ballShootAmount=0;

    pastLevel=ball.level;
    presentLevel=ball.level;

    soundBut=SoundBut(screenSize.width,screenSize.height);
    hbut=HomeBut(screenSize.width,screenSize.height);
    panStartFromRightPos=false;
    scoreBreakDown.add(ScoreBreakDown(screenSize.width, screenSize.height));
    scoreBreakDown.add(ScoreBreakDown(screenSize.width, screenSize.height));
    dirAnim=DirectionAnimation(screenSize.width, screenSize.height);
    scoreBoard=ScoreBoard(screenSize.width, screenSize.height);
   crossBut=CrossBut(screenSize.width, screenSize.height);
    crossButPop=CrossButPop(screenSize.width, screenSize.height);
    //////
    bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    bgPaint = Paint();
    bgPaint.color = Color.fromRGBO(255, 255, 255, 1);
  }
  @override
  void render(Canvas canvas) {

       // TODO: implement render


       // bgPaint.color = Color(0xff576574);

       canvas.drawRect(bgRect, bgPaint);
       if(life>=1) {



       basketback[0].draw(canvas);
       if(ball.level!=5){
         scoreBreakDown[0].draw(canvas,basket[0].x,basket[0].xWidth,basket[0].y-basket[0].xWidth/2,ball.scoreUpdated,ball.y,ball.scorebreakdown.toString());
       }


       if (ball.level == 5) {
         basketback[1].draw(canvas);
         scoreBreakDown[0].draw(canvas,basket[0].x,basket[0].xWidth,basket[0].y-basket[0].xWidth/2,ball.firstRowHit,ball.y,ball.scorebreakdown.toString());
         scoreBreakDown[1].draw(canvas,basket[1].x,basket[1].xWidth,basket[1].y-basket[1].xWidth/2,ball.secondRowHit,ball.y,ball.scorebreakdown.toString());
       }

       ///scorebreak


       ///
       soundBut.draw(canvas);

       live.draw(canvas);
       if (gameTimer > 200 && life >= 1) {
         scoreBoard.draw(canvas, ball.score);
//         TextSpan span = new TextSpan(style: new TextStyle(
//             color: Color.fromRGBO(0, 0, 0, 0.3), fontSize: 60),
//             text: ball.score.toString());
//         TextPainter tp = new TextPainter(text: span,
//             textAlign: TextAlign.left,
//             textDirection: TextDirection.ltr);
//         tp.layout();
//         tp.paint(canvas, new Offset(
//             ballInitalPosX - screenSize.width / 20, screenSize.height / 2+screenSize.height / 10));
       }

       if(ball.mararDirectionErTutoEkbar && gameTimer > 200){
         dirAnim.draw(canvas);
       }

       basket[0].draw(canvas);
       if (ball.level == 5 ) {
         basket[1].draw(canvas);
       }

       //shadow
//       if (ball.shoot == false) {
//         Rect shadow = Rect.fromLTWH(
//             ball.x - ball.radius, ball.y + ball.radius / 2, ball.radius * 2,
//             ball.radius);
//         Paint shadowPaint = Paint();
//         shadowPaint.color = Color.fromRGBO(0, 0, 0, 0.3);
//         canvas.drawOval(shadow, shadowPaint);
//       }
       //shadow

       if (ball.rising) {
         // ball.draw(canvas);

         ball.draw(canvas);
       }
       else if (ball.falling) {
         /// ball.draw(canvas);
//         g.renderRect(canvas, Rect.fromLTWH(
//             ball.x - ball.radius, ball.y - ball.radius, ball.radius * 2,
//             ball.radius * 2));
         ball.draw(canvas);
         basket[0].draw(canvas);

         if (ball.level == 5) {
           basket[1].draw(canvas);
         }
       }

       if (gameTimer <= 200 ) {
         String s;
         if (gameTimer < 150) {
           s = (4 - (gameTimer / 50).ceil()).toString();
         }
         else {
           s = "Start";
         }
         TextSpan span1 = new TextSpan(style: TextStyle(
           fontStyle: FontStyle.normal,
           fontSize: screenSize.width / 6,
           foreground: Paint()
             ..style = PaintingStyle.fill
             ..strokeWidth = 4
             ..color = Colors.orange,
         ), text: s);
         TextPainter tp1 = new TextPainter(text: span1,
             textAlign: TextAlign.center,
             textDirection: TextDirection.ltr);
         tp1.layout();
         if (gameTimer < 150) {
           tp1.paint(canvas, new Offset(
               ballInitalPosX - screenSize.width / 20, screenSize.height / 2));
         }
         else {
           tp1.paint(canvas,
               new Offset(screenSize.width / 3.4, screenSize.height / 2));
         }
       }else if(gamePause==false){
         crossBut.draw(canvas);
       }

//       if (life <= 0) {
//         String s = "Score : " + ball.score.toString();
//         TextSpan span2 = new TextSpan(style: TextStyle(
//           fontStyle: FontStyle.italic,
//           fontSize: screenSize.width / 6,
//           foreground: Paint()
//             ..style = PaintingStyle.stroke
//             ..strokeWidth = 4
//             ..color = Colors.green,
//         ), text: s);
//         TextPainter tp2 = new TextPainter(text: span2,
//             textAlign: TextAlign.left,
//             textDirection: TextDirection.ltr);
//         tp2.layout();
//         tp2.paint(
//             canvas, new Offset(screenSize.width / 6, screenSize.height / 2));
//       }
       if(gamePause){
         crossButPop.draw(canvas);
       }
     }
     else{
       basketback[0].init(screenSize.width, screenSize.height,true,false,screenSize.width/5,screenSize.height/10);
       basketback[0].draw(canvas);
       basket[0].init(screenSize.width,screenSize.height);
       basket[0].draw(canvas);
       ball.init(screenSize.width,screenSize.height,screenSize.width/7);
//       Rect shadow = Rect.fromLTWH(
//           ball.x - ball.radius, ball.y + ball.radius / 2, ball.radius * 2,
//           ball.radius);
//       Paint shadowPaint = Paint();
//       shadowPaint.color = Color.fromRGBO(0, 0, 0, 0.3);
//       canvas.drawOval(shadow, shadowPaint);

         ball.draw(canvas);
//       TextSpan span1 = new TextSpan(style: TextStyle(
//         fontStyle: FontStyle.italic,
//         fontSize: screenSize.width / 15,
//         foreground: Paint()
//           ..style = PaintingStyle.fill
//           ..strokeWidth = 6
//           ..color = Color.fromRGBO(0, 0, 0, 0.4),
//       ), text: "Your Score");
//       TextPainter tp1 = new TextPainter(text: span1,
//           textAlign: TextAlign.left,
//           textDirection: TextDirection.ltr);
//       tp1.layout();
//       tp1.paint(canvas, new Offset(screenSize.width / 3, screenSize.height / 2));

//       double divided_by;
//       String scoreString=ball.score.toString();
//       divided_by=1.4+ball.score.toString().length;
//
//       TextSpan span2 = new TextSpan(style: TextStyle(
//         fontStyle: FontStyle.italic,
//         fontSize: screenSize.width / 7,
//         foreground: Paint()
//           ..style = PaintingStyle.fill
//           ..strokeWidth = 6
//           ..color = Colors.orange,
//       ), text: (ball.score).toString());
//       TextPainter tp2 = new TextPainter(text: span2,
//           textAlign: TextAlign.left,
//           textDirection: TextDirection.ltr);
//       tp2.layout();
//       tp2.paint(canvas, new Offset(screenSize.width / divided_by, screenSize.height / 2+screenSize.height / 20));
       hbut.draw(canvas,ball.score);
//       g.renderRect(canvas, Rect.fromLTWH(
//           ball.x - ball.radius, ball.y - ball.radius, ball.radius * 2,
//           ball.radius * 2));

     }

     ////just checking
//       String s="center("+ball.x.ceil().toString()+","+ball.y.ceil().toString()+")";
//       TextSpan span5 = new TextSpan(style: new TextStyle( fontSize: screenSize.width / 20,color: Colors.blue[800]), text: s);
//       TextPainter tp5 = new TextPainter(text: span5, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
//       tp5.layout();
//       tp5.paint(canvas, new Offset(5.0, screenSize.height-100));
//
//        s="shootDir:"+ballShootAmount.ceil().toString();
//       TextSpan span6 = new TextSpan(style: new TextStyle( fontSize: screenSize.width / 20,color: Colors.blue[800]), text: s);
//       TextPainter tp6 = new TextPainter(text: span6, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
//       tp6.layout();
//       tp6.paint(canvas, new Offset(5.0, screenSize.height-120));
//
//       s="touchStart:"+panStartFingerPosX.ceil().toString()+"end:"+panFingerPosX.ceil().toString();
//       TextSpan span7 = new TextSpan(style: new TextStyle( fontSize: screenSize.width / 20,color: Colors.blue[800]), text: s);
//       TextPainter tp7 = new TextPainter(text: span7, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
//       tp7.layout();
//       tp7.paint(canvas, new Offset(5.0, screenSize.height-140));


  }

  @override
  void resize(Size size) {
    screenSize=size;


  }

  @override
  void update(double t) {
    //print(t);

    if(gamePause==false) {
      if (life >= 1) {
        gameTimer++;
        // TODO: implement update
//    basketLeftPointX=basket.x;
//    basketLeftPointY=basket.y;
//    basketRightPointX=basket.x+basket.xWidth;
//    basketRightPointY=basket.y;

        presentLevel = ball.level;
        if (presentLevel != pastLevel) {
          basket[0].init(screenSize.width, screenSize.height);
          basket[1].init(screenSize.width, screenSize.height);

          basketback[0].init(screenSize.width, screenSize.height, true, false,
              screenSize.width / 5, screenSize.height / 10);

          basketback[1].init(screenSize.width, screenSize.height, false, true,
              screenSize.width / 5,
              screenSize.height / 3 + screenSize.height / 40);
        }
        pastLevel = presentLevel;

        ball.update(basket);
        basketback[0].update(
            ball.level, screenSize.width, screenSize.height, ball.score);

        // basketback[1].update(ball.level,screenSize.width,screenSize.height);
        if (ball.level == 5) {
          basketback[1].update(
              ball.level, screenSize.width, screenSize.height, ball.score);
        }
        basket[0].update(ball.level, basketback[0]);

        // basket[1].update(ball.level,basketback[1]);
        if (ball.level == 5) {
          basket[1].update(ball.level, basketback[1]);
        }
      }
    }
  }
  void onPanStart(DragStartDetails d){
    panStartFingerPosX=d.globalPosition.dx;
     if(d.globalPosition.dy>=ball.y-ball.radius*2  && d.globalPosition.dx>=ball.x-ball.radius && d.globalPosition.dx<=ball.x+ball.radius){
       panStartFromRightPos=true;
     }
     else{
       panStartFromRightPos=false;
     }
  }
  void onPanUpdate(DragUpdateDetails d){
     panFingerPosX=d.globalPosition.dx;
     panFingerPosY=d.globalPosition.dy;



  }
  void onPanEnd(DragEndDetails d){
   //  print((panFingerPosX-ballInitalPosX)/10);
   // print(screenSize.height);

    if(panStartFromRightPos && ball.shoot==false && gameTimer>200 && gamePause==false){
     // ballShootDirection=(panFingerPosX-ball.x)/10;
      if(panFingerPosX-panStartFingerPosX>0){
        ball.shootDirection=1;
      }
      else{
        ball.shootDirection=-1;
      }
      ballShootAmount=(panFingerPosX-panStartFingerPosX).abs()/5;
      ball.ballShootAmount= ballShootAmount;
      ball.shoot=true;
      if(soundEnabled) {
       Flame.audio.play('swipe.mp3');
        //Flame.audio.play('lHoop.mp3');
      }
      ball.mararDirectionErTutoEkbar=false;
    }
  }
  void onTapDown(TapDownDetails d){
    if(gamePause==false){
      soundBut.onTapped(d.globalPosition.dx, d.globalPosition.dy);
    }
    if(gamePause){
      crossButPop.onTapped(d.globalPosition.dx, d.globalPosition.dy);
    }

    if(life<=0){
      bool tmp=hbut.onTapped(d.globalPosition.dx, d.globalPosition.dy);
      if(tmp){
      // init();


      }

    }
    if(life>=1){
      if(gamePause==false && gameTimer>=200){
          crossBut.onTapped(d.globalPosition.dx, d.globalPosition.dy);
      }
    }

  }

  @override
  void onDetach() {

  }

}
