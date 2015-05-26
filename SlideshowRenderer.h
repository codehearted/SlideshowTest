//
//  SlideshowRenderer.h
//  SlideshowTest
//
//  Created by Theodore Bendixson on 5/26/15.
//  Copyright (c) 2015 Theodore Bendixson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#import "ImageConverter.h"

@protocol SlideshowRendererDelegate <NSObject>

-(void)didFinishRendering;

@end

@interface SlideshowRenderer : NSObject

@property (strong)AVAssetWriterInput *videoStream;
@property (strong)AVAssetWriter *videoWriter;
@property BOOL finishedWriting;

-(void)renderSlideshow;

@property (nonatomic,weak) id<SlideshowRendererDelegate>delegate;

@end
