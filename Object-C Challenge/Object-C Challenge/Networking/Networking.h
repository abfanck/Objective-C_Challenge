//
//  Networking.h
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import <Foundation/Foundation.h>
#import "MockURLSession.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    POPULAR,
    NOWPLAYING,
    SEARCH,
    GENRE,
    IMAGE
} UrlType;

@interface Networking : NSObject

@property (strong, nonatomic) MockURLSession *session;

-(void)fetchMovieGenre:(NSNumber *)movieId completionHandler:(void (^)(NSMutableArray *array))completionHandler;;
-(void)fetchMovie:(UrlType)urlType completionHandler:(void (^)(NSMutableArray *array))completionHandler;
+(NSData *)getImageData:(NSString *)posterPath;
-(void)fetchSearch:(NSString *)searchString completionHandler:(void (^)(NSMutableArray *array))completionHandler;

@end

NS_ASSUME_NONNULL_END
