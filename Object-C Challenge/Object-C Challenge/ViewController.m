//
//  ViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 16/03/20.
//

#import "ViewController.h"
#import "Networking.h"

@interface ViewController ()

@property (strong, nonatomic) Networking *networking;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
//     Isso em baixo inicializa a classe
    _networking = Networking.new;
    
//  Isso em baixo é como se chama a funcao da classe
//    [_networking fetchMovieGenre: [NSNumber numberWithInt:(475557)]];
}


@end
