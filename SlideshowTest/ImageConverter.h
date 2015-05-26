//
//  ImageConverter.h
//  SlideshowTest
//
//  Created by Theodore Bendixson on 5/26/15.
//  Copyright (c) 2015 Theodore Bendixson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ImageConverter : NSObject

+ (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image andSize:(CGSize) size;

@end
