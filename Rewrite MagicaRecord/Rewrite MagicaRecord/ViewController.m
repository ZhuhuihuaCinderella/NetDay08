//
//  ViewController.m
//  Rewrite MagicaRecord
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "MagicalRecord.h"
#import "Student+CoreDataProperties.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)insertData:(id)sender {
    //先创建
    Student *student = [Student MR_createEntity];
    student.name = @"xiaobai";
    student.age = @5;
    
    //保存  用上下文
    //表示这个保存是同步的 主线程
    //[[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSLog(@"保存成功");
    }];
}
//删除
- (IBAction)deleteData:(id)sender {
    //删除 最后保存一下
    [Student MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"xiaobai"]];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
}

- (IBAction)updateData:(id)sender {
    NSArray *student = [Student MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"age > %@",@1]];
    
    for (Student *stu in student) {
        //stu.name = @"dabai";
        stu.age = @8;
    }
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSLog(@"succeed");
    }];
}

- (IBAction)selectData:(id)sender {
    
    NSArray *students = [Student MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"xiaobai"]];
    for (Student *stu in students) {
        NSLog(@"name=%@ age=%@",stu.name,stu.age);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
