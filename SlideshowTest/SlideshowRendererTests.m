//
//  SlideshowRendererTests.m
//  SlideshowTest
//
//  Created by Theodore Bendixson on 5/26/15.
//  Copyright (c) 2015 Theodore Bendixson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "SlideshowRenderer.h"

@interface SlideshowRendererTests : XCTestCase<SlideshowRendererDelegate>{
    XCTestExpectation *finishRenderingExpectation;
}

@property (strong)SlideshowRenderer *renderer;

@end

@implementation SlideshowRendererTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _renderer = [[SlideshowRenderer alloc] init];
    [_renderer setDelegate:self];
    finishRenderingExpectation = [self expectationWithDescription:@"Finished Rendering"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    _renderer = nil;
    finishRenderingExpectation = nil;
}

-(void)testVideoExportPerformance{
    
    [_renderer renderSlideshow];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError *error) {
        NSLog(@"Finished Waiting");
    }];
    
}

-(void)didFinishRendering{
    [finishRenderingExpectation fulfill];
}

@end
