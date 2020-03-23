//
//  Networking.m
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import "Networking.h"
#import "Movie.h"
#import "Genre.h"
#import "Parsing.h"
#import "MovieDbAPI.h"

@implementation Networking

//MARK:- FetchMovies

/// Movies Fetch Function, use this method for fetch popular and now playing movies
/// @param completionHandler The completion handler array is the movie array
-(void)fetchMovie:(UrlType)urlType completionHandler:(void (^)(NSMutableArray *array))completionHandler {

    //Objeto de local da busca (Remoto)
    NSURL *url = [MovieDbAPI getUrl:urlType];
    
    //Data handle
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        
        //Pega todo o json
        NSArray *teste = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
        //Pega só o array dos results
        NSArray *fetchArray = [teste valueForKey:@"results"];
        
        if (err) {
            NSLog(@"Failed serialization json with error: %@", err);
//            return;
        }
        
        //Aloca memoria pro array de filmes
        NSMutableArray <Movie *> *movies = NSMutableArray.new;
        
        //Parseando dados
        movies = [Parsing parseMovie:fetchArray];
        
        completionHandler(movies);
        
    }] resume];
}

//MARK:- FetchMovieGenres

/// Fetch the genres using movie ID
/// @param movieId Pass the movie id to get movie's genres
-(void)fetchMovieGenre:(NSNumber *)movieId completionHandler:(void (^)(NSMutableArray *array))completionHandler{
    
    NSURL *url = [MovieDbAPI getUrl:GENRE string:movieId.stringValue];
    
    //Data handle
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
        
        //Aloca memoria pro array de generos
        NSMutableArray <Genre *> *genres = NSMutableArray.new;
        
        genres = [Parsing parseGenres:fetchArray];
        
        completionHandler(genres);
    }] resume];
}

//MARK:- FetchImageData

/// Use this to get the image data and return a NSData
/// @param posterPath Is the movie posterpath (movie.posterpath)
+(NSData *)getImageData:(NSString *)posterPath {
    
    NSURL *url = [MovieDbAPI getUrl:IMAGE string:posterPath];
    
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    return imageData;
}

//MARK:- FetchSearch

-(void)fetchSearch:(NSString *)searchString completionHandler:(void (^)(NSMutableArray *array))completionHandler {
    
    NSURL *url = [MovieDbAPI getUrl:SEARCH string:searchString];
    
    //Data handle
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        
        //Pega todo o json
        NSArray *teste = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
        //Pega só o array dos results
        NSArray *fetchArray = [teste valueForKey:@"results"];
        
        if (err) {
            NSLog(@"Failed serialization json with error: %@", err);
        }
        
        //Aloca memoria pro array de filmes
        NSMutableArray <Movie *> *movies = NSMutableArray.new;

        movies = [Parsing parseMovie:fetchArray];
        
        completionHandler(movies);
        
    }] resume];
}



//TESTE

-(BOOL)testandoOTeste: (BOOL)boolean {
    
    return boolean;
}


@end
