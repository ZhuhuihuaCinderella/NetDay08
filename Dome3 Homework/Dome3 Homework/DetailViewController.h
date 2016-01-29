//
//  DetailViewController.h
//  Dome3 Homework
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明一个别名
typedef void(^BlockName)(void);


@interface DetailViewController : UIViewController

@property (nonatomic,copy) BlockName block;

//声明setter方法
- (void)setBlock:(BlockName)block;

@end
