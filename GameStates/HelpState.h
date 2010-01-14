//
//  HelpState.h
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "GameState.h"
#import "YaspegController.h"
#import "BackButton.h"

@interface HelpState : GameState
{
   ImageLayer *bgLayer;
   ImageLayer *headerLayer;
   CATextLayer*textLayer;
   BackButton *backButton;
}

@end
