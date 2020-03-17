//
//  MoviesTableViewCell.h
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 17/03/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *resume;
@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UILabel *rate;

- (void)setTitle: (NSString *)title resume:(NSString *)resume rate:(NSString *)rate posterData:(NSData *)posterData;

@end

NS_ASSUME_NONNULL_END
