//
//  MovieDbAPI.m
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 20/03/20.
//

#import "MovieDbAPI.h"

@implementation MovieDbAPI

+(NSURL *)getUrl:(UrlType)urlType {
    
    //Alocando memoria pra urlString
    NSString *urlString = [NSString alloc];
    
    switch (urlType) {
        case POPULAR:
            //AMW: Não seria melhor que a nossa base URL (https://api.themoviedb.org/3) fosse uma constante? Assim, caso ela mude, não precisamos mudar em todos os lugares que estão usando ela. Faria o mesmo para a imagem.
            urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1"];
            break;
        case NOWPLAYING:
            urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/now_playing?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1"];
            break;
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
}

+(NSURL *)getUrl:(UrlType)urlType string:(NSString *)string {
    
    //Alocando memoria pra urlString
    NSString *urlString = [NSString alloc];
    
    switch (urlType) {
        case GENRE:
            urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US", string];
            break;
        case SEARCH:
            urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&query=%@&page=1&include_adult=false", string];
            break;
        case IMAGE:
            urlString = [NSString stringWithFormat:@"https:image.tmdb.org/t/p/w500/%@", string];
            break;
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
}

@end
