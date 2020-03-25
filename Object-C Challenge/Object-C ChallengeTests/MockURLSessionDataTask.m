//
//  MockURLSessionDataTask.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 24/03/20.
//

#import "MockURLSessionDataTask.h"

@interface MockURLSessionDataTask ()

@property (nonatomic) BOOL resumeWasCalled;

@end

@implementation MockURLSessionDataTask

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resumeWasCalled = NO;
    }
    return self;
}

- (void)resume {
    _resumeWasCalled = YES;
}

@end
