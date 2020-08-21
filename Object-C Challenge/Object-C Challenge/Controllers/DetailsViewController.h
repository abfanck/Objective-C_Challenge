//
//  DetailsViewController.h
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 18/03/20.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;

@property Movie *movieDetails;

@end

NS_ASSUME_NONNULL_END
