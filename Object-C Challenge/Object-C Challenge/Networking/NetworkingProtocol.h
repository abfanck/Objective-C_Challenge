//
//  NetworkingProtocol.h
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 25/03/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    POPULAR,
    NOWPLAYING,
    SEARCH,
    GENRE,
    IMAGE
} UrlType;

@protocol NetworkingProtocol <NSObject>

@required
-(void)fetchMovie:(UrlType)urlType completionHandler:(void (^)(NSMutableArray *array))completionHandler;

@end

NS_ASSUME_NONNULL_END
