//
//  MyTableViewCell.h
//  Homework ByMyself
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+CoreDataProperties.h"
@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

//配置数据
-(void)configData:(Student*)student;

@end
