//
//  MockNetworking.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 25/03/20.
//

#import "MockNetworking.h"
#import "Movie.h"
#import "Parsing.h"

// AMW: Será que isso precisa estar no target do projeto? Ou poderia só estar no target de teste? Assim como os mocks.
@implementation MockNetworking

- (void)fetchMovie:(UrlType)urlType completionHandler:(nonnull void (^)(NSMutableArray * _Nonnull))completionHandler { 
    
    // Convertendo JSON para Array
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *fetchArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSMutableArray <Movie *> *movies = NSMutableArray.new;
    
    //Parseando dados
    movies = [Parsing parseMovie:fetchArray];
    
    completionHandler(movies);
}

@end
