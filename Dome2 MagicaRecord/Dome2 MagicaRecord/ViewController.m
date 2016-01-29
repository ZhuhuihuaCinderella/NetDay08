//
//  ViewController.m
//  Dome2 MagicaRecord
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "MagicalRecord.h"
#import "Person+CoreDataProperties.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
#pragma mark - 添加数据
- (IBAction)insertData:(id)sender {
    //创建一个新的Entity，类似sqlite新增一行数据
    Person *person = [Person MR_createEntity];
    person.name = @"dameinv";
    person.age = @18;
    
    
    //保存数据 上下文里面
    
    //表示这个数据保存是同步的  主线程UI线程
   // [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
   //  NSLog(@"保存成功");
    
    
    //这个数据保存时异步的 在子线程操作的
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        NSLog(@"保存成功");
    }];
    
}
#pragma mark - 删除数据
- (IBAction)deleteData:(id)sender {
    //删除所有匹配谓词的数据
    //NSPredicate *predicate = []
    [Person MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"dameinv"]];
    
    //保存数据 同步保存
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
}
#pragma mark - 修改数据
- (IBAction)updateData:(id)sender {
    //首先要先拿到数据 才能更新
    NSArray *persons = [Person MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"age > %@",@14]];
    //修改年龄为16
    for (Person*per in persons) {
        per.age = @17;
    }
    
    //保存]
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
}
#pragma mark - 查找数据
- (IBAction)seleceData:(id)sender {
    
    NSArray *persons = [Person MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"age > %@",@15]];
    
    for (Person*per in persons) {
        NSLog(@"%@",per.name);
        NSLog(@"%@",per.age);
    }

    //查找 排序
    //按照年龄升序排序 不设置谓词 查找所有的
    [Person MR_findAllSortedBy:@"age" ascending:YES];
    //+条件
    //根据条件查找 并且升序
    [Person MR_findAllSortedBy:@"age" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"age>%@",@15]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






































