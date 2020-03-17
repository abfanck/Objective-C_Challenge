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

// Chame o metodo assim: [_networking fetchMovie2:YES];
// YES se esta buscando popular movies e NO se esta buscando Now Playing Movies

/// Movies Fetch Function, use this method for fetch popular and now playing movies
/// @param isPopularMovie If you want to fetch popular movies use YES and if you wanna fetch now playing movies use NO
-(void)fetchMovie:(BOOL *)isPopularMovie {
    
    //Alocando memoria pra urlString
    NSString *urlString = [NSString alloc];
    
    //Verificando qual url usar pelo booleano da funcao
    if (isPopularMovie) {
        urlString = @"https://api.themoviedb.org/3/movie/popular?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1";
    } else {
        urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1";
    }

    //Objeto de local da busca (Remoto)
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Data handle
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
        
        //Aloca memoria pro array de filmes
        NSMutableArray <Movie *> *movies = NSMutableArray.new;
        
        //Passa por todos os dados do array results
        for (NSDictionary *movieDic in fetchArray) {
            
            //Aloca memoria para o filme
            Movie *movie = Movie.new;
            
            //Salva em variaveis
            NSString *title = movieDic[@"title"];
            NSString *overview = movieDic[@"overview"];
            NSString *posterPath = movieDic[@"poster_path"];
            NSNumber *movieId = movieDic[@"id"];
            NSNumber *voteAverage = movieDic[@"vote_average"];
            
            //Cria o filme
            movie.title = title;
            movie.movieId = movieId;
            movie.overview = overview;
            movie.posterpath = posterPath;
            movie.voteAverage = voteAverage;
            
            //Adiciona filme no array
            [movies addObject:movie];
        }
        NSLog(@"Terminou");
        
    }] resume];
}

/// Fetch the genres using movie ID
/// @param movieId Pass the movie id to get movie's genres
-(void)fetchMovieGenre:(NSNumber *)movieId {
    
    //Cria a url string com o movie id
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US", movieId.stringValue];
    
    //Objeto de local da busca (Remoto)
    NSURL *url = [NSURL URLWithString:urlString];
    
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
        
        //Passa por todos os dados do array results
        for (NSDictionary *genreDic in fetchArray) {
            
            //Aloca memoria para o filme
            Genre *genre = Genre.new;
            
            //Salva em variaveis
            NSString *name = genreDic[@"name"];
            NSNumber *genreId = genreDic[@"id"];
            
            //Cria o genero
            genre.name = name;
            genre.genreId = genreId;
            
            //Adiciona o genero no array
            [genres addObject:genre];
        }
        
        NSLog(@"Terminou");
    }] resume];
    
}

@end