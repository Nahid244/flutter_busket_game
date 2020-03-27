import 'dart:ui';

class BasketBack{
  double x;
  double y;
  double initPosX;
  double initPosY;

  double screenW;
  double screenH;

  double xWidth;
  double xHeight;
  Paint paint;
  Paint paint1;
  bool leftrun;
  bool rightrun;
  bool toprun;
  bool bottomrun;
  BasketBack(double w,double h,bool l,bool r,double PosX,double PosY){

    init(w,h,l,r,PosX,PosY);
  }
  init(double w,double h,bool l,bool r,double PosX,double PosY){
    screenW=w;
    screenH=h;

//    initPosX=w/6;
//    initPosY=h/20;
//    this.x=w/5;
//    this.y=h/10;

    initPosX=PosX;
    initPosY=PosY;
    this.x=PosX;
    this.y=PosY;

    xWidth=w/2+w/8;
    xHeight=h/4;
    leftrun=l;
    rightrun=r;
    bottomrun=true;
    toprun=false;
  }
  draw(Canvas c){
    paint=Paint();
    paint1=Paint();
    paint.color=Color.fromRGBO(0, 0, 0, 0.5);
    paint1.color=Color(0xffe8f5f9);

   // RRect r=RRect.fromLTRBR(x+10, y+10, xWidth, xHeight-20, Radius.circular(4));
    Rect baskt = Rect.fromLTWH(x, y, xWidth, xHeight);
   // Rect baskt1 = Rect.fromLTWH(x+10, y+10, xWidth-20, xHeight-20);
    c.drawRRect(RRect.fromRectAndRadius(baskt, Radius.circular(20)), paint);
    Rect basktInner= Rect.fromLTWH(x+screenW/50, y+screenH/100, xWidth-screenW/25, xHeight-screenH/50);
    c.drawRRect(RRect.fromRectAndRadius(basktInner, Radius.circular(20)), paint1);

    Rect baskt1= Rect.fromLTWH(x+screenW/5, y+screenH/11, xWidth/3+xWidth/50, xHeight/2-xHeight/10);
    c.drawRect(baskt1, paint);
    Rect baskt1Inner= Rect.fromLTWH(x+screenW/5+screenW/100, y+screenH/11+screenH/200, xWidth/3+xWidth/50-screenW/50, xHeight/2-xHeight/10-screenH/100);
    c.drawRect(baskt1Inner, paint1);
   // c.drawRRect(r, paint1);

  }
  update(int level,double w,double h){

   if(level==3 || level==5){
     level3Update(w, h);
   }
   else if(level==4){
     level4Update(w, h);
   }

  }
  level3Update(double w,double h){
    if(leftrun){
      x-=2;
      if(x<=0){
        leftrun=false;
        rightrun=true;
      }
    }
    else if(rightrun){
      x+=2;
      if(x>=w-xWidth){
        leftrun=true;
        rightrun=false;
      }
    }
  }
  level4Update(double w,double h){
    if(leftrun){
      y++;
      if(bottomrun){
        x-=2;
        if(x<=0){
          toprun=true;
          bottomrun=false;
        }
      }
      else{
         x+=2;
         if(x>=w-xWidth){
           toprun=false;
           bottomrun=true;
         }
      }

      if(y>=h/4){


        leftrun=false;
        rightrun=true;
      }
    }
    else if(rightrun){
      if(bottomrun){
        x-=2;
        if(x<=0){
          toprun=true;
          bottomrun=false;
        }
      }
      else{
        x+=2;
        if(x>=w-xWidth){
          toprun=false;
          bottomrun=true;
        }
      }
      y--;
      if(y<=initPosY){

        leftrun=true;
        rightrun=false;
      }
    }
  }
}