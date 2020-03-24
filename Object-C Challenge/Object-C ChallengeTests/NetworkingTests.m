//
//  NetworkingTests.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 23/03/20.
//

#import <XCTest/XCTest.h>
#import "Networking.h"

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

- (void)testFetchPopular {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Popular request"];
    
    [self.network fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testFetchNowPlaying {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Now Playing request"];
    
    [self.network fetchMovie:NOWPLAYING completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testFetchMovieGenre {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Genre request"];
    
    NSNumber *movieID = [[NSNumber alloc] initWithInt:419704];
    
    [self.network fetchMovieGenre:movieID completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testFetchSearch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Search request"];
    
    NSString *searchString = @"art";
    
    [self.network fetchSearch:searchString completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
