//
//  myBitmapContext.h
//  Yaspeg2
//
//  Created by Radex on 10-01-11.
//  Copyright 2010 Radex. All rights reserved.
//
//

inline CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh)
{
   CGContextRef    context = NULL;
   CGColorSpaceRef colorSpace;
   void *          bitmapData;
   int             bitmapByteCount;
   int             bitmapBytesPerRow;
   
   bitmapBytesPerRow   = (pixelsWide * 4);
   bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
   
   colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
   
   bitmapData = malloc(bitmapByteCount);
   
   if(bitmapData == NULL)
   {
      fprintf(stderr, "Memory not allocated!");
      return NULL;
   }
   
   context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
   
   if(context == NULL)
   {
      free (bitmapData);
      fprintf (stderr, "Context not created!");
      return NULL;
   }
   
   CGColorSpaceRelease(colorSpace);
   
   return context;
}