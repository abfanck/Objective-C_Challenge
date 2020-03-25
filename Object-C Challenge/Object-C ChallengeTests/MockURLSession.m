//
//  MockURLSession.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 24/03/20.
//

#import "MockURLSession.h"
#import "MockURLSessionDataTask.h"

@interface MockURLSession ()

@property (strong, nonatomic) NSURL *lastURL;
@property (strong, nonatomic) NSData *nextData;
@property (strong, nonatomic) NSError *nextError;
@property (nonatomic) id<URLSessionDataTaskProtocol> nextDataTask;

@end

@implementation MockURLSession

- (NSURLResponse *)sucessHttpUrlResponse:(NSURL *)url {
    return [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:nil];
}

- (id<URLSessionDataTaskProtocol>)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    self.lastURL = url;
    
    completionHandler(_nextData, [self sucessHttpUrlResponse:url], _nextError);
    
    return _nextDataTask;
}

@end
