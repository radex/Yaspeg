//
//  ImageLayer.m
//  Yaspeg2
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

#import "ImageLayer.h"

@implementation ImageLayer

@synthesize imageName, x, y, w, h;

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
	if (newImageName != imageName)
	{
		imageName = newImageName;
		[self setNeedsDisplay];
	} 
}

- (int)x
{
   return NSRectFromCGRect(self.frame).origin.x;
}

- (int)y
{
   return NSRectFromCGRect(self.frame).origin.y;
}

- (int)w
{
   return NSRectFromCGRect(self.frame).size.width;
}

- (int)h
{
   return NSRectFromCGRect(self.frame).size.height;
}

- (void)setX:(int)newX
{
   NSRect frame = NSRectFromCGRect(self.frame);
   
   frame = NSMakeRect(newX, frame.origin.y, frame.size.width, frame.size.height);
   self.frame = NSRectToCGRect(frame);
}

- (void)setY:(int)newY
{
   NSRect frame = NSRectFromCGRect(self.frame);
   
   frame = NSMakeRect(frame.origin.x, newY, frame.size.width, frame.size.height);
   self.frame = NSRectToCGRect(frame);
}

- (void)setW:(int)newW
{
   NSRect frame = NSRectFromCGRect(self.frame);
   
   frame = NSMakeRect(frame.origin.x, frame.origin.y, newW, frame.size.height);
   self.frame = NSRectToCGRect(frame);
}

- (void)setH:(int)newH
{
   NSRect frame = NSRectFromCGRect(self.frame);
   
   frame = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, newH);
   self.frame = NSRectToCGRect(frame);
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
		fraction:1.0];
	
	NSGraphicsContext.currentContext = oldContext;
}

- (bool)isInBounds:(NSPoint)point
{
   NSRect frame = NSRectFromCGRect(self.frame);
   
   if(point.x > frame.origin.x &&
      point.x < frame.origin.x + frame.size.width &&
      point.y > frame.origin.y &&
      point.y < frame.origin.y + frame.size.height)
   {
      return YES;
   }
   
   return NO;
}

@end

