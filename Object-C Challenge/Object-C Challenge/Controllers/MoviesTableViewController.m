//
//  MoviesTableViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 17/03/20.
//

#import "MoviesTableViewController.h"
#import "MoviesTableViewCell.h"
#import "DetailsViewController.h"

@interface MoviesTableViewController ()

@property (strong, nonatomic) NSMutableArray<NSMutableDictionary *> *populaeMovies;
@property (strong, nonatomic) NSMutableArray<NSMutableDictionary *> *nowPlaying;

@end

@implementation MoviesTableViewController

NSString *detailsSegue = @"movieDetails";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpPopularMovies];
    [self setUpNowPlaying];
    
    //UIStoryboard *moviesStoryboard = [UIStoryboard storyboardWithName:@"Movies" bundle:nil];
    self.navigationItem.searchController = UISearchController.new;
    self.definesPresentationContext = YES;
}

#pragma mark - Mock Up Data

- (void) setUpPopularMovies {
    
    self.populaeMovies = NSMutableArray.new;
    
    NSMutableDictionary *dict = NSMutableDictionary.new;
    [dict setObject:@"Spider-Man: Far from Home" forKey:@"title"];
    [dict setObject:@"Peter Parker and his friends go on a summer trip to Europe. However, they will hardly be able to rest - Peter will have to..." forKey:@"resume"];
    [dict setObject:@"7.8" forKey:@"rate"];
    
    UIImage *teste = [UIImage imageNamed:@"teste"];
    NSData *imageData = UIImagePNGRepresentation(teste);
    [dict setObject:imageData forKey:@"posterData"];
    
    [self.populaeMovies addObject:dict];
    
    NSMutableDictionary *dict02 = NSMutableDictionary.new;
    [dict02 setObject:@"Alladin" forKey:@"title"];
    [dict02 setObject:@"Peter Parker and his friends go on a summer trip to Europe. However, they will hardly be able to rest - Peter will have to..." forKey:@"resume"];
    [dict02 setObject:@"7.3" forKey:@"rate"];
    [dict02 setObject:imageData forKey:@"posterData"];
    
    [self.populaeMovies addObject:dict02];
}

- (void) setUpNowPlaying {
    
    self.nowPlaying = NSMutableArray.new;
    
    NSMutableDictionary *dict = NSMutableDictionary.new;
    [dict setObject:@"Fast & Furious" forKey:@"title"];
    [dict setObject:@"A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra..." forKey:@"resume"];
    [dict setObject:@"7.1" forKey:@"rate"];
    
    UIImage *teste = [UIImage imageNamed:@"teste"];
    NSData *imageData = UIImagePNGRepresentation(teste);
    [dict setObject:imageData forKey:@"posterData"];
    
    [self.nowPlaying addObject:dict];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.populaeMovies.count;
    } else {
        return self.nowPlaying.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    NSMutableArray *movies = NSMutableArray.new;
    
    if (indexPath.section == 0) {
        movies = self.populaeMovies;
    } else {
        movies = self.nowPlaying;
    }
    
    NSString *title = [movies[indexPath.row] valueForKey:@"title"];
    NSString *resume = [movies[indexPath.row] valueForKey:@"resume"];
    NSString *rate = [movies[indexPath.row] valueForKey:@"rate"];
    NSData *posterData = [movies[indexPath.row] valueForKey:@"posterData"];
    
    [cell setTitle:title resume:resume rate:rate posterData:posterData];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width, 35)];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    label.textColor = UIColor.blackColor;
    
    if (section == 0) {
        label.text = @"Popular Movies";
    } else {
        label.text = @"Now Playing";
    }
    
    [headerView addSubview:label];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *movies = NSMutableArray.new;
    
    if (indexPath.section == 0) {
        movies = self.populaeMovies;
    } else {
        movies = self.nowPlaying;
    }
    
    [self performSegueWithIdentifier:detailsSegue sender:movies[indexPath.row]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: detailsSegue]) {
        DetailsViewController *destination = segue.destinationViewController;
        NSMutableDictionary *dict = sender;
        destination.movieDetails = dict;
    }
}

@end
