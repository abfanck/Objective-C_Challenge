//
//  NetworkingTests.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 23/03/20.
//

#import <XCTest/XCTest.h>
#import "Networking.h"
#import "MovieDbAPI.h"

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
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchNowPlaying {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Now Playing request"];
    
    [self.network fetchMovie:NOWPLAYING completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchMovieGenre {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Genre request"];
    
    NSNumber *movieID = [[NSNumber alloc] initWithInt:419704];
    
    [self.network fetchMovieGenre:movieID completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchSearch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Search request"];
    
    NSString *searchString = @"art";
    
    [self.network fetchSearch:searchString completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testGetUrlPopular {
    
    NSURL *popularUrl = [[NSURL alloc] initWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1"];
    
    NSURL *movieDbApiPopular = [MovieDbAPI getUrl:POPULAR];
    
    XCTAssertEqualObjects(popularUrl, movieDbApiPopular);
}

-(void)testGetUrlNowPlaying {
    
    NSURL *popularUrl = [[NSURL alloc] initWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1"];
    
    NSURL *movieDbApiNowPlaying = [MovieDbAPI getUrl:NOWPLAYING];
    
    XCTAssertEqualObjects(popularUrl, movieDbApiNowPlaying);
}

-(void)testGetUrlGenre{
    
    NSNumber *movieID = [[NSNumber alloc] initWithInt:419704];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US", movieID.stringValue];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURL *movieDbApiGenres = [MovieDbAPI getUrl:GENRE string:movieID.stringValue];
    
    XCTAssertEqualObjects(url, movieDbApiGenres);
}

-(void)testGetUrlImage {
    
    NSString *posterPath = @"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg";
    
    NSString *urlString = [NSString stringWithFormat:@"https:image.tmdb.org/t/p/w500/%@", posterPath];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURL *movieDbApiImage = [MovieDbAPI getUrl:IMAGE string:posterPath];
    
    XCTAssertEqualObjects(url, movieDbApiImage);
}

-(void)testGetUrlSearch {
    
    NSString *searchString = @"art";
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&query=%@&page=1&include_adult=false", searchString];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURL *movieDbApiSearch = [MovieDbAPI getUrl:SEARCH string:searchString];
    
    XCTAssertEqualObjects(url, movieDbApiSearch);
}

- (void)testDataTask
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];

    NSString *searchString = @"art";
    NSURL *url = [MovieDbAPI getUrl:SEARCH string:searchString];
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssertNil(error, @"dataTaskWithURL error %@", error);

        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
            XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", statusCode);
        }

        XCTAssert(data, @"data nil");

        // do additional tests on the contents of the `data` object here, if you want

        // when all done, Fulfill the expectation

        [expectation fulfill];
    }];
    [task resume];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
