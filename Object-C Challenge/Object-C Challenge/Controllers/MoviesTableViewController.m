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
@property (strong, nonatomic) NSMutableArray<Movie *> *searchMovies;
@property (nonatomic) BOOL isSearching;

@end

@implementation MoviesTableViewController

NSString *detailsSegue = @"movieDetails";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSearching = NO;

    [self setUpIndicator];
    
    self.networking = Networking.new;
    
    [self setUpMovies];
    
    self.navigationItem.searchController = UISearchController.new;
    self.navigationItem.searchController.searchResultsUpdater = self;
    self.navigationItem.searchController.delegate = self;
    self.navigationItem.searchController.searchBar.delegate = self;
    self.navigationItem.searchController.obscuresBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
}

#pragma mark - Receive data from api

- (void)setUpMovies {
    
    self.popularMovies = NSMutableArray.new;
    self.nowPlaying = NSMutableArray.new;
    
    [self.networking fetchMovie:POPULAR completionHandler:^(NSMutableArray * _Nonnull array) {
        self.popularMovies = array;
    }];
    
    [self.networking fetchMovie:NOWPLAYING completionHandler:^(NSMutableArray * _Nonnull array) {
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
    
    if (self.isSearching) {
        return 1;
    } else {
        // AMW: 🤔 Se não tem movies em um dos dois, não mostra nenhum?
        if (self.nowPlaying.count == 0 || self.popularMovies.count == 0) {
            return 0;
        } else {
            return 2;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearching) {
        return self.searchMovies.count;
    } else {
        // AMW: Será que para identificar as seções poderíamos usar um enum para ficar mais legível?
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    NSMutableArray *movies = NSMutableArray.new;
    
    if (self.isSearching) {
        movies = self.searchMovies;
    } else {
        if (indexPath.section == 0) {
            movies = self.popularMovies;
        } else {
            movies = self.nowPlaying;
        }
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
    
    if (self.isSearching) {
        // AMW: return nil?
        label.text = @"";
    } else {
        if (section == 0) {
            label.text = @"Popular Movies";
        } else {
            label.text = @"Now Playing";
        }
    }
    
    [headerView addSubview:label];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *movies = NSMutableArray.new;
    
    if (self.isSearching) {
        movies = self.searchMovies;
    } else {
        if (indexPath.section == 0) {
            movies = self.popularMovies;
        } else {
            movies = self.nowPlaying;
        }
    }
    
    [self performSegueWithIdentifier:detailsSegue sender:movies[indexPath.row]];
}

#pragma mark - Search Extension

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.isSearching = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.isSearching = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLHostAllowedCharacterSet];
    
    [self.networking fetchSearch:searchText completionHandler:^(NSMutableArray * _Nonnull array) {
        self.searchMovies = array;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
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
