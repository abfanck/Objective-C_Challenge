//
//  MockURLSessionDataTask.h
//  Object-C ChallengeTests
//
//  Created by Arthur Bastos Fanck on 24/03/20.
//

#import <Foundation/Foundation.h>
#import "URLSessionDataTaskProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockURLSessionDataTask : NSObject <URLSessionDataTaskProtocol>

- (void)resume;

@end

NS_ASSUME_NONNULL_END
