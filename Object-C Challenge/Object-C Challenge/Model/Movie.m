//
//  Movie.m
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title posterPath:(NSString *)posterPath movieId:(NSNumber *)movieId voteAverage:(NSNumber *)voteAverage;
{
    self = [super init];
    if (self) {
        self.title = title;
        self.posterpath = posterPath;
        self.movieId = movieId;
        self.voteAverage = voteAverage;
    }
    return self;
}

@end
