//
//  ImageLayer.m
//  Yaspeg
//
//  Created by Matt Gallagher on 13/02/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//  Copyright 2010 Radosław Pietruszewski. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "ImageLayer.h"
#import "YaspegController.h"

@implementation ImageLayer

@synthesize imageName;

#pragma mark -
#pragma mark initializers

- (id)initWithImageNamed:(NSString *)newImageName frame:(NSRect)newFrame
{
	self = [super init];
	if (self != nil)
	{
		self.anchorPoint = CGPointMake(0.5, 0.5);
      
		imageName = newImageName;
		[self setNeedsDisplay];
      
		self.frame = NSRectToCGRect(newFrame);
	}
	return self;
}

- (id)initWithImageNamed:(NSString *)newImageName
{
	self = [super init];
	if (self != nil)
	{
		self.anchorPoint = CGPointMake(0.5, 0.5);
      
		imageName = newImageName;
		[self setNeedsDisplay];
      
      NSImage *image = [NSImage imageNamed:imageName];
      NSSize imageSize = image.size;
      NSRect imageRect = NSMakeRect(0, 0, imageSize.width, imageSize.height);
		self.frame = NSRectToCGRect(imageRect);
	}
	return self;
}

+ (id)layerWithImageNamed:(NSString *)newImageName frame:(NSRect)newFrame
{
   return [[self alloc] initWithImageNamed:newImageName frame:newFrame];
}

+ (id)layerWithImageNamed:(NSString *)newImageName
{
   return [[self alloc] initWithImageNamed:newImageName];
}

#pragma mark -
#pragma mark accessors

- (void)setImageName:(NSString *)newImageName
{
	if(newImageName != imageName)
	{
		imageName = newImageName;
		[self setNeedsDisplay];
	} 
}

#pragma mark -
#pragma mark drawing and other stuff

- (void)drawInContext:(CGContextRef)ctx
{
	NSGraphicsContext *oldContext = [NSGraphicsContext currentContext];
	NSGraphicsContext *context    = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO];
   
	NSGraphicsContext.currentContext = context;
	
	NSImage *image = [NSImage imageNamed:imageName];
	[image
		drawInRect:NSRectFromCGRect([self bounds])
		fromRect:[image alignmentRect]
		operation:NSCompositeSourceOver
		fraction:1];
	
	NSGraphicsContext.currentContext = oldContext;
}

@end

