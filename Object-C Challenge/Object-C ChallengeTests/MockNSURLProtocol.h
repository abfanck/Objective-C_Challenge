//
//  MockNSURLProtocol.h
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 25/03/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MockNSURLProtocol : NSURLProtocol

+ (NSMutableDictionary<id, NSData *> *)sharedURLs;

+ (BOOL)canInitWithRequest:(NSURLRequest *)request;
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request;
- (void)startLoading;
- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
