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
    
    self.poster.layer.cornerRadius = 10;
    self.poster.layer.masksToBounds = YES;
    self.poster.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle: (NSString *)title resume:(NSString *)resume rate:(NSString *)rate posterData:(NSData *)posterData {
    self.poster.image = [UIImage imageWithData:posterData];
    self.title.text = title;
    self.resume.text = resume;
    self.rate.text = rate;
}

@end
