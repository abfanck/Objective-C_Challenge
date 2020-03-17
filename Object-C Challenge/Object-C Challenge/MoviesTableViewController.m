//
//  MoviesTableViewController.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 17/03/20.
//

#import "MoviesTableViewController.h"
#import "MoviesTableViewCell.h"

@interface MoviesTableViewController ()

@property (strong, nonatomic) NSMutableArray<NSMutableDictionary *> *populaeMovies;
@property (strong, nonatomic) NSMutableArray<NSMutableDictionary *> *nowPlaying;

@end

@implementation MoviesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpPopularMovies];
    [self setUpNowPlaying];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    
    if (section == 0) {
        title = @"Popular Movies";
    } else {
        title = @"Now Playing";
    }
    
    return title;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
