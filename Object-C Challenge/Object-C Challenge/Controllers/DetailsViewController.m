//
//  DetailsViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 18/03/20.
//

#import "DetailsViewController.h"
#import "Networking.h"
#import "Movie.h"
#import "Genre.h"

@interface DetailsViewController ()

@property (strong, nonatomic) Networking *networking;
@property (strong, nonatomic) NSMutableArray<Genre *> *genres;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.networking = Networking.new;
    [self.networking fetchMovieGenre:self.movieDetails.movieId completionHandler:^(NSMutableArray * _Nonnull array) {
        self.genres = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.genreLabel.text = [self arrayToString:self.genres];
        });
    }];
    
    self.titleLabel.text = [self.movieDetails title];
    self.voteAverageLabel.text = [[self.movieDetails voteAverage] stringValue];
    self.overviewTextView.text = [self.movieDetails overview];
    
    NSData *posterData = [self.movieDetails imageData];
    self.posterImage.image = [UIImage imageWithData:posterData];
    self.posterImage.layer.cornerRadius = 10;
    self.posterImage.layer.masksToBounds = YES;
    self.posterImage.clipsToBounds = YES;
}

- (NSString *)arrayToString: (NSMutableArray<Genre *> *) array {
    
    NSString *string = NSString.new;
    
    while (array.count > 0) {
        NSString *text = NSString.new;
        
        if (array.count == 1) {
            text = [NSString stringWithFormat:@"%@.", array.firstObject.name];
        } else {
            text = [NSString stringWithFormat:@"%@, ", array.firstObject.name];
        }
        
        string = [string stringByAppendingString: text];
        [array removeObjectAtIndex:0];
    }
    return string;
}

@end
