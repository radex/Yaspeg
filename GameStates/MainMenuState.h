//
//  MainMenuState.h
//  Yaspeg2
//
//  Created by Radex on 10-01-09.
//  Copyright 2010 Radex. All rights reserved.
//

#import "GameState.h"
#import "YaspegController.h"

@interface MainMenuState : GameState
{
   ImageLayer *bgLayer;
   ImageLayer *headerLayer;
   ImageLayer *footerLayer;
   
   //CALayer    *dupaLayer;
   
   NSArray *menuItems;   // CALayer[]
   NSArray *menuItems_g; // CALayer[] menu items' glows
   
   
   
   CABasicAnimation *pulseAnimation;
   
   int currentMenuItem;
   int changedMenuItem;
}

- (bool) runMenuItem:(int)item;
- (int) itemSelected:(int)item;

@end
