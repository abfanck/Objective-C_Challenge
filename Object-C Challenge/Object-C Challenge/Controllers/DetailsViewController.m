//
//  DetailsViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 18/03/20.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.movieDetails valueForKey:@"title"];
    self.rateLabel.text = [self.movieDetails valueForKey:@"rate"];
    self.overviewLabel.text = [self.movieDetails valueForKey:@"resume"];
    
    NSData *posterData = [self.movieDetails valueForKey:@"posterData"];
    self.posterImage.image = [UIImage imageWithData:posterData];
    self.posterImage.layer.cornerRadius = 10;
    self.posterImage.layer.masksToBounds = YES;
    self.posterImage.clipsToBounds = YES;
}

@end