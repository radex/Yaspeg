//
//  ImageLayer.h
//  Yaspeg
//
//  Created by Matt Gallagher on 13/02/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//  Copyright 2010 Radex. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Cocoa/Cocoa.h>

@interface ImageLayer : CALayer
{
	NSString *imageName;
   
   int x; // in fact, these two variables are fake - they are empty
   int y; // and only overwritten accessors points at self.frame.origin.x/y
   
   int w; // ... and these at self.frame.size.width/height
   int h;
}

@property (assign, readwrite) NSString *imageName;
@property (assign, readwrite) int x;
@property (assign, readwrite) int y;
@property (assign, readwrite) int w;
@property (assign, readwrite) int h;

+ (id)layerWithImageNamed:(NSString *)newImageName frame:(NSRect)newFrame;
+ (id)layerWithImageNamed:(NSString *)newImageName;

@end

