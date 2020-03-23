//
//  NetworkingTests.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 23/03/20.
//

#import <XCTest/XCTest.h>
#import <Object-C Challenge/Networking/Networking.h>

@interface NetworkingTests : XCTestCase

@property (strong, nonatomic) Networking *network;

@end

@implementation NetworkingTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    self.network = Networking.new;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    
    [self.network fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssert(array, @"array nil");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
