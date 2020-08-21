//
//  Parsing.h
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 20/03/20.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "Genre.h"
#import "Networking.h"

NS_ASSUME_NONNULL_BEGIN

@interface Parsing : NSObject

+(NSMutableArray<Movie *> *)parseMovie: (NSArray *)fetchArray;
+(NSMutableArray<Genre *> *)parseGenres: (NSArray *)fetchArray;

@end

NS_ASSUME_NONNULL_END
