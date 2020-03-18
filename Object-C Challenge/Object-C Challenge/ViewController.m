//
//  ViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 16/03/20.
//

#import "ViewController.h"
#import "Networking.h"
#import "Movie.h"

@interface ViewController ()

@property (strong, nonatomic) Networking *networking;
@property (strong, nonatomic) NSMutableArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     Isso em baixo inicializa a classe
    _networking = Networking.new;
    _movies = NSMutableArray.new; // Mesma coisa que [NSMutableArray Alloc]
    
//    EU ACHO QUE ISSO TA FUNCIONANDO KKK
//    É só colocar isso numa queue
//    NSData *imageData = [_networking getImageData:@"/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg"];
//    UIImage *image = [UIImage imageWithData:imageData];

}
@end
