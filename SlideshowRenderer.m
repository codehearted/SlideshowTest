//
//  SlideshowRenderer.m
//  SlideshowTest
//
//  Created by Theodore Bendixson on 5/26/15.
//  Copyright (c) 2015 Theodore Bendixson. All rights reserved.
//

#import "SlideshowRenderer.h"

@implementation SlideshowRenderer

-(void)renderSlideshow{
    
    NSLog(@"Export Started");
    
    _finishedWriting = false;
    
    int videoWidth = 2048;
    int videoHeight = videoWidth;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"slideshowtest.mov"];
    
    NSError *error = nil;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }
    
    _videoWriter = [[AVAssetWriter alloc] initWithURL: [NSURL fileURLWithPath:filePath] fileType:AVFileTypeQuickTimeMovie error:&error];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   
                                   [NSNumber numberWithInt:videoWidth], AVVideoWidthKey,
                                   
                                   [NSNumber numberWithInt:videoHeight], AVVideoHeightKey,
                                   
                                   nil];
    
    _videoStream = [AVAssetWriterInput
                                        assetWriterInputWithMediaType:AVMediaTypeVideo
                                        outputSettings:videoSettings];
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
                                                     
                                                     assetWriterInputPixelBufferAdaptorWithAssetWriterInput: _videoStream
                                                     
                                                     sourcePixelBufferAttributes:nil];
    
    [_videoWriter addInput: _videoStream];
    
    [_videoWriter startWriting];
    
    [_videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    CVPixelBufferRef buffer = NULL;
    int frameCount = 1;
    
    NSArray *images = [self images];
    
    for(UIImage *img in images)
    {
        
        buffer = [ImageConverter pixelBufferFromCGImage:[img CGImage] andSize:img.size];
        BOOL append_ok = NO;
        
        while (!append_ok){
            if (adaptor.assetWriterInput.readyForMoreMediaData){
                CMTime frameTime = CMTimeMake(frameCount,(int32_t) 1);
                append_ok = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
                
                if(buffer)
                    CVBufferRelease(buffer);
                
                 
                [NSThread sleepForTimeInterval:0.05];
            }else{
                [NSThread sleepForTimeInterval:0.1];
            }
        }
        frameCount++;
    }
    
    [_videoStream markAsFinished];
    
    [_videoWriter finishWritingWithCompletionHandler:^{
        
        _finishedWriting = true;
        [_delegate didFinishRendering];
        
        NSLog(@"%@",_videoWriter);
        NSLog(@"All Done");
    }];
    
}

-(NSArray*)images{
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    NSInteger i = 0;
    
    for (i = 0; i < 10; i++) {
        [images addObject:[UIImage imageNamed:@"test.png"]];
    }
    
    return images;
}

@end
