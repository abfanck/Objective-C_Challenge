//
//  Networking.m
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import "Networking.h"
#import "Movie.h"
#import "Genre.h"

@implementation Networking

-(void)fetchMovie:(BOOL *)isPopularMovie {
    //PopularMoviesURL
    //"https://api.themoviedb.org/3/movie/popular?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1"
    
    NSString *urlString = [NSString alloc];
    
    if (isPopularMovie) {
        urlString = @"https://api.themoviedb.org/3/movie/popular?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1";
    } else {
        urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1";
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        
        //Pega todo o json
        NSArray *teste = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
        //Pega só o array dos results
        NSArray *fetchArray = [teste valueForKey:@"results"];
        
        if (err) {
            NSLog(@"Failed serialization json with error: %@", err);
            return;
        }
        
        NSMutableArray <Movie *> *movies = NSMutableArray.new;
        
        //Passa por todos os dados do array results
        for (NSDictionary *movieDic in fetchArray) {
            Movie *movie = Movie.new;
            NSString *title = movieDic[@"title"];
            NSString *overview = movieDic[@"overview"];
            NSString *posterPath = movieDic[@"poster_path"];
            NSNumber *movieId = movieDic[@"id"];
            NSNumber *voteAverage = movieDic[@"vote_average"];
            
            movie.title = title;
            movie.movieId = movieId;
            movie.overview = overview;
            movie.posterpath = posterPath;
            movie.voteAverage = voteAverage;
            
            [movies addObject:movie];
        }
        
        NSLog(@"%lu", movies.count);
        NSLog(@"Terminou");
        
//        return movies;
        
    }] resume];
}

-(void)fetchMovieGenre:(NSNumber *)movieId {
    
    //Genres url
//    "https://api.themoviedb.org/3/movie/\(movieId)?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US"
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US", movieId.stringValue];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        
        //Pega todo o json
        NSArray *teste = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
        //Pega só o array dos results
        NSArray *fetchArray = [teste valueForKey:@"genres"];
        
        if (err) {
            NSLog(@"Failed serialization json with error: %@", err);
            return;
        }
        
        NSMutableArray <Genre *> *genres = NSMutableArray.new;
        
        //Passa por todos os dados do array results
        for (NSDictionary *genreDic in fetchArray) {
            Genre *genre = Genre.new;
            NSString *name = genreDic[@"name"];
            NSNumber *genreId = genreDic[@"id"];
            
            genre.name = name;
            genre.genreId = genreId;
            
            [genres addObject:genre];
        }
        
        NSLog(@"Terminou");
    }] resume];
    
}

@end
