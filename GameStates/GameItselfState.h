//
//  GameItselfState.h
//  Yaspeg2
//
//  Created by Radex on 10-01-15.
//  Copyright 2010 Radex. All rights reserved.
//

#import "GameState.h"
#import "YaspegController.h"

@interface GameItselfState : GameState
{
   int maxSpeed, runTime;
   float speed, runSpeed, bonusSpeed, ySpeed, x, y;
   bool right, left, up;
   
   ImageLayer *bg;
   ImageLayer *dude;
   
   CATextLayer *info;
}

@end