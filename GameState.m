//
//  GameState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-03.
//  Copyright 2010 Radex. All rights reserved.
//

#import "GameState.h"


@implementation GameState

@synthesize yaspeg, eventType, eventIsRepeat, eventCharachters, eventMousePoint;

- (id) init
{
   if(self = [super init])
   {
      eventType = None_ET;
      inited    = NO;
   }
   
   return self;
}

- (void) stateInit{}
- (void) events{eventType = None_ET;}
- (void) logic{}
- (void) render{}
- (NSTimeInterval) outro
{
   [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(cleanUp) userInfo:nil repeats:NO];
   
   return 0;
}
- (void) cleanUp{}

@end
