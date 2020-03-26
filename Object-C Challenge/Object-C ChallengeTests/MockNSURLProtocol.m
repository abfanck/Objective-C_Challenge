//
//  MockNSURLProtocol.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 25/03/20.
//

#import "MockNSURLProtocol.h"

static NSMutableDictionary<id, NSData *> *testURLs = nil;

@implementation MockNSURLProtocol

+ (NSMutableDictionary<id, NSData *> *)sharedURLs {
    if (testURLs == nil) {
        testURLs = [NSMutableDictionary<id, NSData *> dictionary];
    }
    return testURLs;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSURL *url = self.request.URL;
    NSData *data = [MockNSURLProtocol.sharedURLs valueForKey:url.absoluteString];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading { }

@end
