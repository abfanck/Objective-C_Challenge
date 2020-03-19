//
//  MoviesTableViewCell.h
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 17/03/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;

- (void)setTitle: (NSString *)title overview:(NSString *)resume voteAverage:(NSString *)rate posterData:(NSData *)posterData;

@end

NS_ASSUME_NONNULL_END
