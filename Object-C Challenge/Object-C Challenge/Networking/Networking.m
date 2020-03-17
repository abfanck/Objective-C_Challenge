//
//  Networking.m
//  Object-C Challenge
//
//  Created by Marcus Vinicius Vieira Badiale on 17/03/20.
//

#import "Networking.h"

@implementation Networking

-(void)fetchNowPlayingMovies {
    
    NSString *urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1";
    
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
        
        //Passa por todos os dados do array results
        for (NSDictionary *testdic in fetchArray) {
            NSString *title = testdic[@"title"];
            NSLog(title);
        }
        
        NSLog(@"Terminou");
    }] resume];
}

-(void)fetchPopularMovies {
    
}

//PopularMoviesURL
//"https://api.themoviedb.org/3/movie/popular?api_key=4c86680eeadb3c625a7f347b2ce6e135&language=en-US&page=1"


@end
