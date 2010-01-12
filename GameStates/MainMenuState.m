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
   bgLayer.opacity = 0.0;
   
   [yaspeg.rootLayer addSublayer:bgLayer];
   
   // header
   
   headerLayer = [ImageLayer layerWithImageNamed:@"header-yaspeg-small" frame:NSMakeRect(250, 600, 300, 95)];
   
   [yaspeg.rootLayer addSublayer:headerLayer];
   
   // footer
   
   footerLayer = [ImageLayer layerWithImageNamed:@"by-radex"];
   footerLayer.x = 800 - footerLayer.w - 10;
   footerLayer.y = -footerLayer.h;
   
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
      
      layer.y = 600 - 150 - itemsTotalHeight;
      layer.x = (800 - layer.w)/2;
      
      [yaspeg.rootLayer addSublayer:layer];
      
      i++;
   }
   
   // menu items (glow)
   
   menuItems_g =
   [NSArray arrayWithObjects:
    [ImageLayer layerWithImageNamed:@"graj-item-glow"],
    [ImageLayer layerWithImageNamed:@"jak-grac-item-glow"],
    [ImageLayer layerWithImageNamed:@"edytor-poziomow-item-glow"],
    [ImageLayer layerWithImageNamed:@"pobierz-poziomy-item-glow"],
    [ImageLayer layerWithImageNamed:@"autorzy-item-glow"],
    [ImageLayer layerWithImageNamed:@"ustawienia-item-glow"],
    [ImageLayer layerWithImageNamed:@"koniec-item-glow"],
    nil
   ];
   
   i = 0;
   itemsTotalHeight = 0;
   for(ImageLayer *layer in menuItems_g)
   {
      itemsTotalHeight += layer.h;
      
      layer.y = 600 - 150 - itemsTotalHeight;
      layer.x = (800 - layer.w)/2;
      layer.opacity = 0.0;
      
      [yaspeg.rootLayer addSublayer:layer];
      
      i++;
   }
   
   /***/
   
   currentMenuItem = 6;
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
      else if(character == NSCarriageReturnCharacter || character == NSEnterCharacter) // return/enter
      {
         if(currentMenuItem == 6)
         {
            [yaspeg windowWillClose:nil];
            return;
         }
      }
      /*
      else if(character == 't')
      {
         CGContextRef myBitmapContext = MyCreateBitmapContext(800,600);
         [yaspeg.rootLayer renderInContext:myBitmapContext];
         CGImageRef myImage = CGBitmapContextCreateImage(myBitmapContext);
         dupaLayer = [CALayer layer];
         dupaLayer.frame = NSMakeRect(100, 100, 800, 600);
         dupaLayer.contents = (id) myImage;
         [yaspeg.rootLayer addSublayer:dupaLayer];
         CGImageRelease(myImage);
      }
       */
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
   
   if(!inited)
   {
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:1.0];
      
      bgLayer.opacity = 1.0;
      headerLayer.y = 590 - headerLayer.h;
      footerLayer.y = 10;
      
      [CATransaction commit];
      
      // making "selection pulse" animation
      
      pulseAnimation;
      
      pulseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
      pulseAnimation.duration = 0.7;
      pulseAnimation.repeatCount = HUGE_VALF;
      pulseAnimation.autoreverses = YES;
      pulseAnimation.fromValue = [NSNumber numberWithFloat:0.3];
      pulseAnimation.toValue = [NSNumber numberWithFloat:1.0];
      [[menuItems_g objectAtIndex:currentMenuItem] addAnimation:pulseAnimation forKey:@"animateOpacity"];
      
      inited = YES;
   }
   
   // if current menu item changed
   
   if(changedMenuItem != -1)
   {
      [[menuItems_g objectAtIndex:currentMenuItem] removeAllAnimations];
      [[menuItems_g objectAtIndex:currentMenuItem] setOpacity: 0.0];
      [[menuItems_g objectAtIndex:changedMenuItem] addAnimation:pulseAnimation forKey:@"animateOpacity"];
      
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
   NSTimeInterval animationDuration = 1.0;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:animationDuration];
   
   bgLayer.opacity = 0;
   headerLayer.y = 600;
   footerLayer.y = -30;
   
   [CATransaction commit];
   
   [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(cleanUp) userInfo:nil repeats:NO];
   
   return animationDuration;
}

/*
 * cleanUp
 *
 *
 */

- (void) cleanUp
{
   [bgLayer removeFromSuperlayer];
   [headerLayer removeFromSuperlayer];
   [footerLayer removeFromSuperlayer];
   
   for(ImageLayer *layer in menuItems)
   {
      [layer removeFromSuperlayer];
   }
   
   for(ImageLayer *layer in menuItems_g)
   {
      [layer removeAllAnimations];
      [layer removeFromSuperlayer];
   }
}

/*
 * finalize
 *
 *
 */

- (void) finalize
{
   [self cleanUp];
   [super finalize];
}

@end
