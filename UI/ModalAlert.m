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

static bool ModalAlert_isAlert = NO;

@implementation ModalAlert

- (id) initWithHeader:(NSString*)header description:(NSString*)description
{
   if(self = [super init])
   {
      yaspeg    = [YaspegController sharedYaspegController];
      gameState = yaspeg.currentState;
      
      ModalAlert_isAlert = YES;
      
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
      [okButton handleRender];
   }
   
   return self;
}

+ (id) alertWithHeader:(NSString*)header description:(NSString*)description
{
   return [[self alloc] initWithHeader:header description:description];
}

- (int) handleEvents
{
   if([okButton handleEvents] == 1)
   {
      [self handleOutro];
   }
}

- (void) handleRender
{
   
}

- (void) handleOutro
{
   [okButton removeFromSuperlayer];
   
   ModalAlert_isAlert = NO;
   [self removeFromSuperlayer];
}

+ (bool) isAlert
{
   return ModalAlert_isAlert;
}

@end
