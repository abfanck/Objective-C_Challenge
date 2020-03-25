//
//  NSURLSession+Extension.m
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 24/03/20.
//

#import "NSURLSession+Extension.h"

@implementation NSURLSession (Extension)

- (id<URLSessionDataTaskProtocol>)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    return [self dataTaskWithURL:url completionHandler:completionHandler];
}

@end
