//
//  Networking.h
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import <Foundation/Foundation.h>
#import "NetworkingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Networking : NSObject <NetworkingProtocol>

-(void)fetchMovieGenre:(NSNumber *)movieId completionHandler:(void (^)(NSMutableArray *array))completionHandler;;
-(void)fetchMovie:(UrlType)urlType completionHandler:(void (^)(NSMutableArray *array))completionHandler;
+(NSData *)getImageData:(NSString *)posterPath;
-(void)fetchSearch:(NSString *)searchString completionHandler:(void (^)(NSMutableArray *array))completionHandler;

@end

NS_ASSUME_NONNULL_END
