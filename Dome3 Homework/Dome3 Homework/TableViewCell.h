//
//  TableViewCell.h
//  Dome3 Homework
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+CoreDataProperties.h"
@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

-(void)configData:(Student*)student;

@end
