//
//  Movie.h
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *posterpath;
@property (strong, nonatomic) NSNumber *movieId;
@property (strong, nonatomic) NSNumber *voteAverage;
@property (strong, nonatomic) NSArray *genres;

@end

NS_ASSUME_NONNULL_END
