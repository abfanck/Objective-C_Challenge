//
//  Object_C_ChallengeTests.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 23/03/20.
//

#import <XCTest/XCTest.h>
#import <Object-C Challenge/Networking/Networking.h>

@interface Object_C_ChallengeTests : XCTestCase

@property (strong, nonatomic) Networking *net;

@end

@implementation Object_C_ChallengeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
