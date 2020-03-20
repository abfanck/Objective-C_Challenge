//
//  Parsing.m
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 20/03/20.
//

#import "Parsing.h"

static @implementation Parsing

+(NSMutableArray<Movie *> *)parseMovie: (NSArray *)fetchArray {
    
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
        movie.imageData = [Networking getImageData:movie.posterpath];
        
        //Adiciona filme no array
        [movies addObject:movie];
    }
    
    return movies;
}

+(NSMutableArray<Genre *> *)parseGenres: (NSArray *)fetchArray {
    
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
    
    return genres;
}
@end
