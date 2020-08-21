//
//  MovieDbAPI.h
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 20/03/20.
//

#import <Foundation/Foundation.h>
#import "Networking.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDbAPI : NSObject

+(NSURL *)getUrl:(UrlType)urlType;
+(NSURL *)getUrl:(UrlType)urlType string:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
