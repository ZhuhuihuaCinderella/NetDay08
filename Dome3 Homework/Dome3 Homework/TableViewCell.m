//
//  TableViewCell.m
//  Dome3 Homework
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)configData:(Student*)student {
    
    self.nameLabel.text = student.name;
    self.ageLabel.text = student.age.stringValue;
    self.ImageView.image = [UIImage imageWithData:student.headImageData];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
