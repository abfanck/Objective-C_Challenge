//
//  Networking.h
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Networking : NSObject

-(void)fetchMovieGenre:(NSNumber *)movieId;
-(void)fetchMovie:(BOOL *)isPopularMovie;

@end

NS_ASSUME_NONNULL_END