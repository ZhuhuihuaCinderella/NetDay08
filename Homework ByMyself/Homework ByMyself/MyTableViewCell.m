//
//  MyTableViewCell.m
//  Homework ByMyself
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configData:(Student*)student {
    
    
    self.nameLabel.text = student.name;
    self.inforLabel.text = student.information;
    self.ageLabel.text = student.age.stringValue;
    self.headImageView.image = [UIImage imageWithData:student.headImageData];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
