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

@interface ImageLayer : CALayer
{
	NSString *imageName;
}

@property (assign, readwrite) NSString *imageName;

+ (id)layerWithImageNamed:(NSString *)newImageName frame:(NSRect)newFrame;
+ (id)layerWithImageNamed:(NSString *)newImageName;

@end

