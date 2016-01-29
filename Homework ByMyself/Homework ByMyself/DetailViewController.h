//
//  DetailViewController.h
//  Homework ByMyself
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(void);

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *inforTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (nonatomic,copy) Block block;

-(void)setBlock:(Block)block;

@end
