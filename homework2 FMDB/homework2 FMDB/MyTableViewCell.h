//
//  MyTableViewCell.h
//  homework2 FMDB
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
-(void)configData;


@end
