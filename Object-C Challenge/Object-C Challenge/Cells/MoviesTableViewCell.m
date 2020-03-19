//
//  MoviesTableViewCell.m
//  Object-C Challenge
//
//  Created by Arthur Bastos Fanck on 17/03/20.
//

#import "MoviesTableViewCell.h"

@implementation MoviesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.posterImage.layer.cornerRadius = 10;
    self.posterImage.layer.masksToBounds = YES;
    self.posterImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle: (NSString *)title overview:(NSString *)overview voteAverage:(NSString *)voteAverage posterData:(NSData *)posterData {
    self.posterImage.image = [UIImage imageWithData:posterData];
    self.titleLabel.text = title;
    self.overviewLabel.text = overview;
    self.voteAverageLabel.text = voteAverage;
}

@end
