//
//  NetworkingTests.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 23/03/20.
//

#import <XCTest/XCTest.h>
#import "Networking.h"
#import "MovieDbAPI.h"
#import "Movie.h"

@interface NetworkingTests : XCTestCase

@end

@implementation NetworkingTests

- (void)setUp {
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
//    self.protocolNetworking = MockNetworking.new;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// AMW: Nos tests testFetchSearch, testFetchNowPlaying, testFetchMovieGenre e testFetchPopular, vocês precisam usar mocks. Por exemplo, e se em algum momento não tiver nenhum filme com “art” (na pesquisa, por exemplo). Com o mock vocês sabem exatamente quantos vem e aí podem conferir pela quantidade exata.
- (void)testFetchPopular {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Popular request"];
    
    Networking *network = Networking.new;
    [network fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchNowPlaying {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Now Playing request"];
    
    Networking *network = Networking.new;
    [network fetchMovie:NOWPLAYING completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchMovieGenre {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Genre request"];
    
    NSNumber *movieID = [[NSNumber alloc] initWithInt:419704];
    
    Networking *network = Networking.new;
    [network fetchMovieGenre:movieID completionHandler:^(NSMutableArray * _Nonnull array) {
        XCTAssertGreaterThan(array.count, 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchSearch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Search request"];
    
    NSString *searchString = @"art";
    
    Networking *network = Networking.new;
    [network fetchSearch:searchString completionHandler:^(NSMutableArray * _Nonnull array) {
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

// AMW: Nos tests testGetUrlGenre poderia só colocar a URL esperada, sem fazer a concatenação. Se não me engano, e se tu quiser, da pra comparar o .absoluteString do NSURL.
-(void)testGetUrlGenre{
    
    NSNumber *movieID = [[NSNumber alloc] initWithInt:419704];
    
    NSString *urlString = @"https://api.themoviedb.org/3/movie/419704?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US";
    
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

// AMW: O que estamos testando com testDataTask? Se estamos testando se chamando dataTaskWithURL, ele retorna um data, acho que não precisamos desse teste. Se é um método é provido pela Apple, não precisamos testar :)
- (void)testDataTask {
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

//MARK: - Mock JSON

// AWM: Como você tem o parsing sendo feito por uma classe separada, eu faria o teste testParseMovie chamar o método do Parsing.
//- (void)testParseMovie{
//
//    [self.protocolNetworking fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
//
//        NSMutableArray<Movie *> *movies = array;
//
//        XCTAssertTrue([movies[0].title isEqualToString:@"Ad Astra"]);
//        XCTAssertFalse([movies[0].title isEqualToString:@"AdAstra"]);
//
//        XCTAssertTrue([movies[0].posterpath isEqualToString:@"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"]);
//        XCTAssertFalse([movies[0].posterpath isEqualToString:@""]);
//
//        XCTAssertTrue(movies[0].movieId.intValue == 419704);
//        XCTAssertFalse(movies[0].movieId.intValue == 1);
//
//        XCTAssertTrue(movies[0].voteAverage.doubleValue == 5.9);
//        XCTAssertFalse(movies[0].voteAverage.doubleValue == 8.5);
//
//    }];
//
//}

@end

