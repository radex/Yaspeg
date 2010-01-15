//
//  MainMenuState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-09.
//  Copyright 2010 Radex. All rights reserved.
//

#import "MainMenuState.h"

@implementation MainMenuState

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   // background
   
   bgLayer = [ImageLayer layerWithImageNamed:@"bg"];
   bgLayer.opacity = 0;
   
   [yaspeg.rootLayer addSublayer:bgLayer];
   
   // header
   
   headerLayer = [ImageLayer layerWithImageNamed:@"header-yaspeg-small" frame:NSMakeRect(250, 600, 300, 95)];
   
   [yaspeg.rootLayer addSublayer:headerLayer];
   
   // footer
   
   footerLayer   = [ImageLayer layerWithImageNamed:@"by-radex"];
   footerLayer.x = 800 - footerLayer.w;
   footerLayer.y = -footerLayer.h;
   
   footerLayer.shadowOpacity = 0;
   footerLayer.shadowOffset  = CGSizeMake(0, 0);
   footerLayer.shadowRadius  = 2;
   
   [yaspeg.rootLayer addSublayer:footerLayer];
   
   // menu items (text)
   
   menuItems =
   [NSArray arrayWithObjects:
    [ImageLayer layerWithImageNamed:@"graj-item"],
    [ImageLayer layerWithImageNamed:@"jak-grac-item"],
    [ImageLayer layerWithImageNamed:@"edytor-poziomow-item"],
    [ImageLayer layerWithImageNamed:@"pobierz-poziomy-item"],
    [ImageLayer layerWithImageNamed:@"autorzy-item"],
    [ImageLayer layerWithImageNamed:@"ustawienia-item"],
    [ImageLayer layerWithImageNamed:@"koniec-item"],
    nil
   ];
   
   int i = 0;
   int itemsTotalHeight = 0;
   for(ImageLayer *layer in menuItems)
   {
      itemsTotalHeight += layer.h;
      
      layer.y             = 600 - 150 - itemsTotalHeight;
      layer.x             = (800 - layer.w)/2;
      layer.shadowOpacity = 0;
      layer.shadowOffset  = CGSizeMake(0, 0);
      layer.shadowRadius  = 5;
      
      [yaspeg.rootLayer addSublayer:layer];
      
      i++;
   }
   
   /***/
   
   currentMenuItem = [self itemSelected:-1];
   changedMenuItem = -1;
}

/*
 * events
 *
 *
 */

- (void) events
{
   /*
    
    note: sometimes (like here) it's better to use if..elseif..elseif
    instead of switch, even if switch seems to be more convenient
    
    */
   
   if(eventType == KeyDown_ET)
   {
      unichar character = [eventCharachters characterAtIndex:0];
      
      if(character == NSDownArrowFunctionKey)
      {
         if(currentMenuItem == 6)
         {
            changedMenuItem = 0;
         }
         else
         {
            changedMenuItem = currentMenuItem + 1;
         }
      }
      else if(character == NSUpArrowFunctionKey)
      {
         if(currentMenuItem == 0)
         {
            changedMenuItem = 6;
         }
         else
         {
            changedMenuItem = currentMenuItem - 1;
         }
         
      }
      else if(character == YK_RETURN || character == YK_ENTER)
      {
         if([self runMenuItem:currentMenuItem])
         {
            return;
         }
      }
   }
   else if(eventType == MouseMove_ET)
   {
      int i = 0;
      
      for(ImageLayer *item in menuItems)
      {
         if([item isInBounds:eventMousePoint])
         {
            if(i != currentMenuItem)
            {
               changedMenuItem = i;
            }
            break;
         }
         
         i++;
      }
      
      if([footerLayer isInBounds:eventMousePoint])
      {
         footerLayer.shadowOpacity = 1;
      }
      else
      {
         footerLayer.shadowOpacity = 0;
      }

   }
   else if(eventType == MouseDown_ET)
   {
      int i = 0;
      
      for(ImageLayer *item in menuItems)
      {
         if([item isInBounds:eventMousePoint])
         {
            [self runMenuItem:i];
            break;
         }
         
         i++;
      }
      
      if([footerLayer isInBounds:eventMousePoint])
      {
         [yaspeg runYaspegHomepage];
      }
   }
   
   eventType = None_ET;
}

/*
 * logic
 *
 *
 */

- (void) logic
{
   
}

/*
 * render
 *
 *
 */

- (void) render
{
   // rendering for first time
   
   static bool menuForFirstTime = YES;
   
   if(!inited)
   {
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:(menuForFirstTime ? 1 : 0.5)]; // longer animation if yaspeg just launched, shorter if when comming back from other state
      
      bgLayer.opacity = 1;
      headerLayer.y = 590 - headerLayer.h;
      footerLayer.y = 0;
      
      [CATransaction commit];
      
      // making "selection pulse" animation
      
      pulseAnimation;
      
      pulseAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
      pulseAnimation.duration = 0.7;
      pulseAnimation.repeatCount = HUGE_VALF;
      pulseAnimation.autoreverses = YES;
      pulseAnimation.fromValue = [NSNumber numberWithFloat:0.3];
      pulseAnimation.toValue = [NSNumber numberWithFloat:1];
      [[menuItems objectAtIndex:currentMenuItem] addAnimation:pulseAnimation forKey:@"animateShadowOpacity"];
      
      inited = YES;
      menuForFirstTime = NO;
   }
   
   // if current menu item changed
   
   if(changedMenuItem != -1)
   {
      [[menuItems objectAtIndex:currentMenuItem] removeAllAnimations];
      [[menuItems objectAtIndex:currentMenuItem] setShadowOpacity: 0];
      [[menuItems objectAtIndex:changedMenuItem] addAnimation:pulseAnimation forKey:@"animateShadowOpacity"];
      
      currentMenuItem = changedMenuItem;
      changedMenuItem = -1;
   }
}

/*
 * outro
 *
 *
 */

- (NSTimeInterval) outro
{
   NSTimeInterval animationDuration = 0.5;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:animationDuration];
   
   bgLayer.opacity = 0;
   headerLayer.y = 600;
   footerLayer.y = -30;
   
   [CATransaction commit];
   
   [super scheduleCleanUp:animationDuration];
   
   [self itemSelected:currentMenuItem];
   
   return animationDuration;
}

#pragma mark -
#pragma mark state-specific methods

- (int) itemSelected: (int)item
{
   static int selectedItem = 0;
   
   if(item != -1)
   {
      selectedItem = item;
   }

   return selectedItem;
}

- (bool) runMenuItem: (int) item
{
   if(item == 6)
   {
      [yaspeg windowWillClose:nil];
      return YES;
   }
   
   GameStateType statesArray[6] = 
   {
      Game_GS,
      Help_GS,
      Editor_GS,
      Download_GS,
      Authors_GS,
      Settings_GS
   };
   
   if(statesArray[item] != None_GS)
   {
      [yaspeg scheduleNextState:statesArray[item]];
      return YES;
   }
   
   return NO;
}

@end
