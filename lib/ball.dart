import 'dart:ui';
import 'dart:math';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter_busket_game/basket.dart';
import 'package:flutter_busket_game/basketback.dart';
import 'package:flutter_busket_game/publicdata.dart';




class Ball {
  double x;
  double tempX;
  double y;
  double radius;
  Paint paint;

  double screenW;
  double screenH;

  bool mararDirectionErTutoEkbar;

  bool rising;
  bool ballrisingShrink;
  bool falling;
  bool topHit;
  bool firstRowHit;
  bool secondRowHit;
  bool scoreCleanSheet;
  int scoreIncreaserCleanSheet;

  List<bool> hoopRbahir=[false,false];

  bool basketCollisionHit;
  bool basketLeftCollision;

  bool basketRightCollision;

  Sprite b;
  SpriteSheet spritesheet;
  Animation animation;
  double spriteIndex;

  String ballFallingDirection;
  double shootDirectionAfterCollision;
  double shootDirection;
  double ballShootAmount;
  bool shoot;
  int timer;

  double screenSizeX;
  double screenSizeY;

  double velocity;
  double initialVelocity;

  double groundToballHeight;

  double mass;
  double lowerLimitmass;

  int score;
  int pastScore;
  double g=2.3;
  int level;

  bool leftrun;
  bool rightrun;

  bool scoreUpdated;

  int scorebreakdown;
  bool ekthrowAKonoCollision;
  //delete


  Ball(double w,double h,double r){
    scoreIncreaserCleanSheet=2;
    ekthrowAKonoCollision=false;
   // b[0]=;
  // b=Sprite('aa.png');
   spritesheet = SpriteSheet(
     imageName: 'Ball_Sprite.png',
     textureWidth: 325,
     textureHeight: 325,
     columns: 5,
     rows: 5,
   );

   animation = spritesheet.createAnimation(0, stepTime: 0.1);
   spriteIndex=0;

    pastScore=-1;
    score=0;
    level=1;
    mararDirectionErTutoEkbar=firstTimeTuto;
    init(w, h, r);

  }
  void init(double w,double h,double r){
    screenW=w;
    screenH=h;
    radius=r;
    x=w/2;
    y=h-h/8;

    shoot=false;
    timer=0;

    screenSizeX=w;
    screenSizeY=h;

    velocity=sqrt(2*g*(h-h/10+screenH/11-radius*1.2));
    groundToballHeight=0;
    initialVelocity=velocity;
    rising=true;
    topHit=false;
    ballrisingShrink=true;
    falling=false;
    basketCollisionHit=false;
    tempX=x;
    ballFallingDirection="middle";
    shootDirectionAfterCollision=1;
    firstRowHit=false;
    secondRowHit=false;

    mass=1;
    lowerLimitmass=1;

    shootDirection=1;
    ballShootAmount=0;

//    if(scoreUpdated==false){
//      score=0;
//    }
    scoreCleanSheet=true;

    if(ekthrowAKonoCollision==false &&  pastScore!=score && pastScore!=-1) {
      scoreIncreaserCleanSheet *= 2;
    }
      else{
        scoreIncreaserCleanSheet=2;
      }
      ekthrowAKonoCollision=false;




    if(pastScore==score ){
      life--;
    }
    pastScore=score;

    if(score>=1 && score<10 ){
      level=2;
      leftrun=true;
      rightrun=false;

    }
    else if(score>=10 && score<25){
      level=3;

    }
    else if(score>=25 && score<40){
      level=4;
    }
    else if(score>=40 && score<50 ){
      level=5;
    }
    else if(score>=50 && score<60 ){
      level=6;
    }
    else if(score>=60 && score<70 ){
      level=7;
    }
    else if(score>=70 && score<80 ){
      level=8;
    }
    else if(score>=80  ){
      level=9;
    }
    scoreUpdated=false;

    if(score>=5 && life>=1){
      x=Random.secure().nextInt((screenW-radius*2).toInt())+radius;
    }




    scorebreakdown=1;



  }
  void draw(Canvas c){
    paint = Paint();
    paint.color =Color.fromRGBO(0, 0, 0, 0.3);
    //c.drawCircle(Offset(x, y), radius, paint);
 //  b.renderRect(c, Rect.fromLTWH(x - radius, y - radius, radius * 2, radius * 2));
   // b.renderRect(c, Rect.fromLTWH(x - radius, y - radius, radius , radius ));
   if(animation.loaded() && shoot==false){
     c.drawOval( Rect.fromLTWH(x - radius, y +radius / 2, radius * 2, radius), paint);
     animation.getSprite().renderRect(c, Rect.fromLTWH(x - radius, y - radius, radius * 2, radius * 2));
   }
   else if(animation.loaded() && shoot==true){
     if(gamePause==false){
       spriteIndex++;
       if(spriteIndex>484){
         spriteIndex=0;
     }
     }
    // print((spriteIndex/10).ceil());

       animation.update(spriteIndex.toDouble()/22);
       animation.getSprite().renderRect(c, Rect.fromLTWH(x - radius, y - radius, radius * 2, radius * 2));



   }



  }
  void update(List<Basket> basket){


    groundToballHeight=screenSizeY-y;
    updateVelocityDependingOnHeight();


    //print("life $life");
    if(timer>500 || y>=screenSizeY){
      if(life>=1){
        init(screenSizeX, screenSizeY, screenW/7);
      }



    }
    if(shoot){

      int hittedBasket=0;
      if(level!=5){
      //  if(checkForMassUpdateBelowLevel5){
          mass=sqrt(2*g*(screenH-(basket[0].y-radius*2.3)));

         // checkForMassUpdateBelowLevel5=false;
       // }

        ballBasketHitCheck(basket[0].x, basket[0].y, basket[0].x+basket[0].xWidth, basket[0].y);
       // scoreUpdate(basket[0].x, basket[0].y, basket[0].x+basket[0].xWidth, basket[0].y);
        scoreChk(basket[0].x, basket[0].y, basket[0].xWidth, basket[0].xHeight);
      }
      else{
        if(y<basket[1].y-radius*2.5 ){
          mass=sqrt(2*g*(screenH-(basket[0].y-radius*2.3)));

        }
        else if(y>=basket[1].y-radius*2.5 ){
          mass=sqrt(2*g*(screenH-(basket[1].y-radius*2.3)));

        }



       // ballBasketHitCheck(basket[0].x, basket[0].y, basket[0].x+basket[0].xWidth, basket[0].y);
        for(hittedBasket=0;hittedBasket<=1;hittedBasket++){
          bool tmp=ballBasketHitCheck(basket[hittedBasket].x, basket[hittedBasket].y, basket[hittedBasket].x+basket[hittedBasket].xWidth, basket[hittedBasket].y);
          if(tmp){
            break;
          }
        }

        if(firstRowHit==false && secondRowHit==false){
          //firstRowHit=scoreUpdate(basket[0].x, basket[0].y, basket[0].x+basket[0].xWidth, basket[0].y);
          firstRowHit= scoreChk(basket[0].x, basket[0].y, basket[0].xWidth, basket[0].xHeight);
        }
         if(secondRowHit==false){
          scoreUpdated=false;
         // secondRowHit=scoreUpdate(basket[1].x, basket[1].y, basket[1].x+basket[1].xWidth, basket[1].y);
          secondRowHit=scoreChk(basket[1].x, basket[1].y, basket[1].xWidth, basket[1].xHeight);

        }
//        if(firstRowHit){
//          print("first");
//          scoreUpdated=false;
//          secondRowHit=scoreUpdate(basket[1].x, basket[1].y, basket[1].x+basket[1].xWidth, basket[1].y);
//          print(secondRowHit);
//          if(secondRowHit){
//            print("second");
//            score++;
//          }
//        }


      }

      timer++;

      if(rising==true){
        y-=velocity;
        if(ballrisingShrink && radius>basket[0].xWidth/3){
          radius-=screenH/600;
        }

      }
      else{
        y+=velocity;
        ballrisingShrink=false;
      }




          if(basketCollisionHit){
              //shootXdirection=0;


               if(basketLeftCollision){
                 ballShootAmount=(radius-(basket[hittedBasket].x-x).abs())/10;

                  if(basket[hittedBasket].x<x ){

                 //   shootDirectionAfterCollision=-sqrt(velocity).toInt();
                   // shootDirectionAfterCollision=sqrt(velocity)*2;
                   // ballShootAmount=mass/2.5;
                    if(level>2 && basket[hittedBasket].leftrun){
                      shootDirection=0.8;
                    }
                    else if(level>2 && basket[hittedBasket].rightrun){
                      shootDirection=1.2;
                    }
                    else{
                      shootDirection=0.8;
                    }



                  }
                  else{

                   // shootDirectionAfterCollision=-sqrt(velocity)*2;
                   // shootXdirection=tshootXdirection;
                   // ballShootAmount=-mass/9;
                    shootDirection=-2;
                  }


               }
               else if(basketRightCollision){
                 ballShootAmount=(radius-(basket[hittedBasket].x+basket[hittedBasket].xWidth-x).abs())/10;

                 if(basket[hittedBasket].x+basket[hittedBasket].xWidth>x ){

                  // shootDirectionAfterCollision=-sqrt(velocity).toInt();
                   //shootDirectionAfterCollision=-sqrt(velocity)*2;
                  // ballShootAmount=-mass/2.5;
                   if(level>2 && basket[hittedBasket].leftrun){
                     shootDirection=-1.2;
                   }
                   else if(level>2 && basket[hittedBasket].rightrun){
                     shootDirection=-0.8;
                   }
                   else{
                     shootDirection=-0.8;
                   }


                  // shootDirection=-1;
                  // print("vhitor");
                 }
                 else{

                  // shootDirectionAfterCollision=sqrt(velocity)*2;
                  // shootXdirection=tshootXdirection;
                  // ballShootAmount=mass/9;
                   shootDirection=2;
                  // print("bhair");
                 }


               }

//             shootDirectionAfterCollision=-1;
             basketCollisionHit=false;
             basketLeftCollision=false;
             basketRightCollision=false;

          }
          x+=ballShootAmount*shootDirection;







    }
    else{
//      if(level==2){
//        if(leftrun){
//          x-=2;
//          if(x<=screenW/5){
//            leftrun=false;
//            rightrun=true;
//          }
//        }
//      else if(rightrun){
//        x+=2;
//        if(x>=screenW-screenW/5){
//          leftrun=true;
//          rightrun=false;
//        }
//      }
//      }
    }

  }

  void updateVelocityDependingOnHeight(){

    if(velocity<=0.5){
      rising=false;
      falling=true;
      topHit=true;
    }
    if(rising){
      if(sqrt((initialVelocity*initialVelocity)-2*g*groundToballHeight)>=0){
        velocity=sqrt((initialVelocity*initialVelocity)-2*g*groundToballHeight);
      }
      else{
        velocity=0;
      }
      //velocity=sqrt((initialVelocity*initialVelocity)-2*0.31*groundToballHeight);
    }
    else{
     // velocity=sqrt(2*0.30*groundToballHeight);
//      if(x<tempX){
//        ballFallingDirection="left";
//      }
//      else{
//        ballFallingDirection="right";
//      }
//      tempX=x;

        velocity+=screenH/700;


      //print(screenH/100);
    }

  }
  bool ballBasketHitCheck(double basketLeftPointX,double basketLeftPointY,double basketRightPointX,double basketRightPointY){
    if(falling){

      if((basketLeftPointX>=x && basketLeftPointX<=x+radius && basketLeftPointY>=y && basketLeftPointY<=y+radius)
          ||(basketLeftPointX<=x && basketLeftPointX>=x-radius && basketLeftPointY>=y && basketLeftPointY<=y+radius)
      ) {
        basketCollisionHit = true;
        basketLeftCollision = true;
        basketRightCollision = false;
     //  if(basketLeftPointY>y+radius*1.5 ){
          rising = true;
          falling = false;
     //  }

        initialVelocity = mass;
      //  mass--;
        ekthrowAKonoCollision=true;
         scoreCleanSheet=false;
        if(soundEnabled){
        Flame.audio.play('rHoop.mp3');
      }
      }
      else if((basketRightPointX<=x && basketRightPointX>=x-radius && basketRightPointY>=y && basketRightPointY<=y+radius)
      ||(basketRightPointX>=x && basketRightPointX<=x+radius && basketRightPointY>=y && basketRightPointY<=y+radius)){

        basketCollisionHit=true;
        basketLeftCollision=false;
        basketRightCollision=true;
    //  if(basketLeftPointY>y+radius*1.5 ){
          rising=true;
          falling=false;
      // }

       initialVelocity=mass;
     //  mass--;
        ekthrowAKonoCollision=true;
        scoreCleanSheet=false;
        if(soundEnabled) {
          Flame.audio.play('rHoop.mp3');
        }

      }
//      if(basketLeftPointX<x-radius && basketRightPointX>x+radius && basketLeftPointY<=y && basketLeftPointY>=y-radius && scoreUpdated==false){
//        score++;
//        scoreUpdated=true;
//       // Flame.audio.play('one.mp3');
//      }
    }
    return basketCollisionHit;
  }
  bool scoreUpdate(double basketLeftPointX,double basketLeftPointY,double basketRightPointX,double basketRightPointY){
   if(falling){
     if(basketLeftPointX<x-radius && basketRightPointX>x+radius && basketLeftPointY<=y && basketLeftPointY>=y-radius && scoreUpdated==false){
       // if(level<5){
//       if(basketCollisionHit){
//         score++;
//       }
//       else{
//         score+=2;
//       }

        score++;
       // }

       scoreUpdated=true;
       // Flame.audio.play('one.mp3');
     }
   }
    return scoreUpdated;
  }
  bool score5Update(double basketLeftPointX,double basketLeftPointY,double basketRightPointX,double basketRightPointY){
    bool tmpUpdate=false;
    if(falling){
      if(basketLeftPointX<x-radius && basketRightPointX>x+radius && basketLeftPointY<=y && basketLeftPointY>=y-radius && scoreUpdated==false){

        tmpUpdate=true;
        // Flame.audio.play('one.mp3');
      }
    }
    return tmpUpdate;
  }
   bool scoreChk(double basketX, double basketY, double basketWidth,double basketHeight){
    if(falling){
      Rect r=Rect.fromLTWH(basketX+basketX/10, basketY, basketWidth-basketX/5, basketHeight);
      Rect r1=Rect.fromLTWH(x-radius,y-radius,radius*2,radius);
      if(r1.overlaps(r) && scoreUpdated==false){

        if(scoreCleanSheet==true){
          score+=scoreIncreaserCleanSheet;
          scorebreakdown=scoreIncreaserCleanSheet;
          if(soundEnabled){
            Flame.audio.play('cleansheet.mp3');
          }


        }
        else{
         // scoreIncreaserCleanSheet=2;
          score++;
          scorebreakdown=1;
        }

        scoreUpdated=true;
      }
    }
    return scoreUpdated;
   }

 }