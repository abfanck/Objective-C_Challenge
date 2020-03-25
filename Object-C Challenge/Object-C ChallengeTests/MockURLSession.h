//
//  MockURLSession.h
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 24/03/20.
//

#import <Foundation/Foundation.h>
#import "URLSessionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockURLSession : NSObject <URLSessionProtocol>

- (NSURLResponse *)sucessHttpUrlResponse:(NSURL *)url;
- (id<URLSessionDataTaskProtocol>)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
