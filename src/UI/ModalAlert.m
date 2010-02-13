//
//  ModalAlert.m
//  Yaspeg
//
//  Created by Radex on 10-02-11.
//  Copyright 2010 Radex. All rights reserved.
//  
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "ModalAlert.h"
#import "YaspegController.h"

static ModalAlert *ModalAlert_instance;

@implementation ModalAlert

- (id) initWithHeader:(NSString*)header description:(NSString*)description
{
   if(self = [super init])
   {
      yaspeg    = [YaspegController sharedYaspegController];
      gameState = yaspeg.currentState;
      
      [self setNeedsDisplay];
      
      [yaspeg.rootLayer addSublayer:self];
      
      // shady layer
      
      shadyLayer = [CALayer layer];
      shadyLayer.frame = NSMakeRect(0, 0, 800, 600);
      shadyLayer.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 0.5);
      
      [self addSublayer:shadyLayer];
      
      // box layer
      
      boxLayer = [CALayer layer];
      boxLayer.frame = NSMakeRect(200, 200, 400, 200);
      boxLayer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 0.2);
      boxLayer.cornerRadius = 20;
      
      [self addSublayer:boxLayer];
      
      // header
      
      headerLayer          = [CATextLayer layer];
      headerLayer.frame    = CGRectMake(220, 360, 360, 30);
      headerLayer.font     = @"palatino";
      headerLayer.fontSize = 24;
      headerLayer.string   = header;
      headerLayer.alignmentMode   = kCAAlignmentCenter;
      headerLayer.foregroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
      
      [self addSublayer:headerLayer];
      
      // description
      
      descriptionLayer          = [CATextLayer layer];
      descriptionLayer.frame    = CGRectMake(220, 280, 360, 75);
      descriptionLayer.font     = @"palatino";
      descriptionLayer.fontSize = 17;
      descriptionLayer.string   = description;
      descriptionLayer.alignmentMode   = kCAAlignmentCenter;
      descriptionLayer.foregroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
      
      [self addSublayer:descriptionLayer];
      
      // button
      
      okButton = [Button buttonWithLabel:@"OK" position:NSMakePoint(362, 210) width:75];
      [gameState.handledObjects removeObject:okButton];
      
      [okButton removeFromSuperlayer];
      [self addSublayer:okButton];
      
      [okButton handleIntro];
   }
   
   return self;
}

+ (void) displayAlertWithHeader:(NSString*)header description:(NSString*)description
{
   ModalAlert_instance = [[self alloc] initWithHeader:header description:description];
}

+ (bool) handleEvents
{
   if(ModalAlert_instance == nil) return NO;
   
   return [ModalAlert_instance intHandleEvents];
}

- (bool) intHandleEvents
{
   if([okButton handleEvents] == 1)
   {
      [okButton removeFromSuperlayer];
      
      ModalAlert_instance = nil;
      
      [self removeFromSuperlayer];
   }
   
   okButton.eventsHandled = NO;
   
   return YES;
}

@end
