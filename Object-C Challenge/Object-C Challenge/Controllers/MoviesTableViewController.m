//
//  MoviesTableViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 17/03/20.
//

#import "MoviesTableViewController.h"
#import "MoviesTableViewCell.h"
#import "DetailsViewController.h"
#import "Networking.h"
#import "Movie.h"

@interface MoviesTableViewController ()

@property (strong, nonatomic) NSMutableArray<Movie *> *popularMovies;
@property (strong, nonatomic) NSMutableArray<Movie *> *nowPlaying;
@property (strong, nonatomic) Networking *networking;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation MoviesTableViewController

NSString *detailsSegue = @"movieDetails";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.hidden = YES;
    
    [self setUpIndicator];
    
    self.networking = Networking.new;
    
    [self setUpMovies];
    
    //UIStoryboard *moviesStoryboard = [UIStoryboard storyboardWithName:@"Movies" bundle:nil];
    self.navigationItem.searchController = UISearchController.new;
    self.definesPresentationContext = YES;
}

#pragma mark - Receive data from api

- (void)setUpMovies {
    
    self.popularMovies = NSMutableArray.new;
    self.nowPlaying = NSMutableArray.new;
    
    [self.networking fetchMovie:YES completionHandler:^(NSMutableArray * _Nonnull array) {
        self.popularMovies = array;
    }];
    
    [self.networking fetchMovie:NO completionHandler:^(NSMutableArray * _Nonnull array) {
        self.nowPlaying = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.spinner stopAnimating];
            self.spinner.hidden = YES;
        });
    }];
}

- (void)setUpIndicator {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self.view addSubview:self.spinner];
    [self.spinner setCenter:CGPointMake(self.tableView.center.x, self.tableView.center.y - 150)];
    [self.spinner startAnimating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.nowPlaying.count == 0 && self.popularMovies.count == 0) {
        return 0;
    } else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.popularMovies.count > 2) {
            return 2;
        } else {
            return self.popularMovies.count;
        }
        
    } else {
        return self.nowPlaying.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    NSMutableArray *movies = NSMutableArray.new;
    
    if (indexPath.section == 0) {
        movies = self.popularMovies;
    } else {
        movies = self.nowPlaying;
    }
    
    NSString *title = [movies[indexPath.row] title];
    NSString *overview = [movies[indexPath.row] overview];
    NSString *voteAverage = [[movies[indexPath.row] voteAverage] stringValue];
    NSData *posterData = [movies[indexPath.row] imageData];
    
    [cell setTitle:title overview:overview voteAverage:voteAverage posterData:posterData];
    
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
        movies = self.popularMovies;
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
        Movie *movie = sender;
        destination.movieDetails = movie;
    }
}

@end
