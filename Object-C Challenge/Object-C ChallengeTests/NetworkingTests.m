//
//  NetworkingTests.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 23/03/20.
//

#import <XCTest/XCTest.h>
#import "Networking.h"
#import "MovieDbAPI.h"
#import "MockNSURLProtocol.h"
#import "Movie.h"
#import "Genre.h"
#import "Parsing.h"

@interface NetworkingTests : XCTestCase

@property (strong, nonatomic) Networking *network;

@end

@implementation NetworkingTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    
    NSURL *popularURL = [MovieDbAPI getUrl:POPULAR];
    NSURL *nowplayingURL = [MovieDbAPI getUrl:NOWPLAYING];
    NSURL *genresURL = [MovieDbAPI getUrl:GENRE string:@"419704"];
    
    NSString *moviePath = [[NSBundle bundleForClass:MockNSURLProtocol.class] pathForResource:@"movie" ofType:@"json"];
    NSData *movieData = [[NSData alloc] initWithContentsOfFile:moviePath];
    
    NSString *genrePath = [[NSBundle bundleForClass:MockNSURLProtocol.class] pathForResource:@"genre" ofType:@"json"];
    NSData *genreData = [[NSData alloc] initWithContentsOfFile:genrePath];
    
    [MockNSURLProtocol.sharedURLs setValue:movieData forKey:popularURL.absoluteString];
    [MockNSURLProtocol.sharedURLs setValue:movieData forKey:nowplayingURL.absoluteString];
    [MockNSURLProtocol.sharedURLs setValue:genreData forKey:genresURL.absoluteString];
    
    
    NSURLSessionConfiguration *config = NSURLSessionConfiguration.ephemeralSessionConfiguration;
    config.protocolClasses = [[NSArray alloc] initWithObjects:MockNSURLProtocol.class, nil];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    self.network = [[Networking alloc] initWithSession:session];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [MockNSURLProtocol.sharedURLs removeAllObjects];
}

- (void)testFetchPopular {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Popular request"];
    
    [self.network fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
        
        NSArray<Movie *> *movies = array;
        XCTAssertEqual(movies.count, 2);
        XCTAssertTrue([movies[0].title isEqualToString:@"Ad Astra"]);
        XCTAssertTrue(movies[0].movieId.intValue == 419704);
        XCTAssertTrue([movies[0].posterpath isEqualToString:@"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"]);
        XCTAssertTrue(movies[0].voteAverage.doubleValue == 5.9);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchNowPlaying {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Now Playing request"];
    
    [self.network fetchMovie:NOWPLAYING completionHandler:^(NSMutableArray * _Nonnull array) {
        
        NSArray<Movie *> *movies = array;
        XCTAssertEqual(movies.count, 2);
        XCTAssertTrue([movies[1].title isEqualToString:@"Bloodshot"]);
        XCTAssertTrue(movies[1].movieId.intValue == 338762);
        XCTAssertTrue([movies[1].posterpath isEqualToString:@"/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg"]);
        XCTAssertTrue(movies[1].voteAverage.doubleValue == 6.4);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchMovieGenre {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Genre request"];
    
    NSNumber *movieID = [[NSNumber alloc] initWithInt:419704];
    
    [self.network fetchMovieGenre:movieID completionHandler:^(NSMutableArray * _Nonnull array) {
        
        NSArray<Genre *> *genres = array;
        
        XCTAssertTrue(genres[0].genreId.intValue == 878);
        XCTAssertTrue([genres[0].name isEqualToString:@"Science Fiction"]);
        XCTAssertTrue(genres[1].genreId.intValue == 18);
        XCTAssertTrue([genres[1].name isEqualToString:@"Drama"]);
        XCTAssertTrue(genres[2].genreId.intValue == 53);
        XCTAssertTrue([genres[2].name isEqualToString:@"Thriller"]);
        XCTAssertTrue(genres[3].genreId.intValue == 12);
        XCTAssertTrue([genres[3].name isEqualToString:@"Adventure"]);
        XCTAssertTrue(genres[4].genreId.intValue == 9648);
        XCTAssertTrue([genres[4].name isEqualToString:@"Mystery"]);
        
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
    
    NSString *urlString = @"https://api.themoviedb.org/3/movie/419704?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US";
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURL *movieDbApiGenres = [MovieDbAPI getUrl:GENRE string:movieID.stringValue];
    
    XCTAssertEqualObjects(url, movieDbApiGenres);
}

-(void)testGetUrlImage {
    
    NSString *posterPath = @"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg";
    
    NSString *urlString = @"https:image.tmdb.org/t/p/w500//xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg";
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURL *movieDbApiImage = [MovieDbAPI getUrl:IMAGE string:posterPath];
    
    XCTAssertEqualObjects(url, movieDbApiImage);
}

-(void)testGetUrlSearch {
    
    NSString *searchString = @"art";
    
    NSString *urlString = @"https://api.themoviedb.org/3/search/movie?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&query=art&page=1&include_adult=false";
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURL *movieDbApiSearch = [MovieDbAPI getUrl:SEARCH string:searchString];
    
    XCTAssertEqualObjects(url, movieDbApiSearch);
}

-(void)testParsingMovies {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Popular request"];

    Movie *movie1 = [[Movie alloc] initWithTitle:@"Ad Astra" posterPath:@"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg" movieId:@419704 voteAverage:@5.9];
    Movie *movie2 = [[Movie alloc] initWithTitle:@"Bloodshot" posterPath:@"/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg" movieId:@338762 voteAverage:@6.4];
    
    NSMutableArray <Movie *> *fakeMovies = NSMutableArray.new;
    [fakeMovies addObject:movie1];
    [fakeMovies addObject:movie2];
    
    [self.network fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
        
        NSArray <Movie *> *parsedMovie = array;
        
        for (int i=0; i<fakeMovies.count; i++) {
            XCTAssertTrue([fakeMovies[i].title isEqualToString:parsedMovie[i].title]);
            XCTAssertTrue([fakeMovies[i].posterpath isEqualToString:parsedMovie[i].posterpath]);
            XCTAssertTrue([fakeMovies[i].movieId isEqualToNumber:parsedMovie[i].movieId]);
            XCTAssertTrue([fakeMovies[i].voteAverage isEqualToNumber:parsedMovie[i].voteAverage]);
        }
        
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
