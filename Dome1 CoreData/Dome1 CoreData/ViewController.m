//
//  ViewController.m
//  Dome1 CoreData
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "Person+CoreDataProperties.h"
#import <CoreData/CoreData.h>//导入头文件
@interface ViewController ()
//声明一个属性 方便使用 coredata上下文
@property (nonatomic,strong)NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createContext];
    [self insertData];
    [self selectData];
    [self deleData];
}
#pragma mark - 创建CoreData  上下文Context
-(void)createContext {
    /*
     1.先从资源中加载模型文件（模型文件:可以在创建项目的时候 自动生成 也可以自己创建 DataModel）
     
     */
    //先找到模型文件的url
    NSURL *modelUrl = [[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"];
    //创建模型  并初始化模型文件
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    
    //添加数据库支持 支持我们就默认选中sqlite
    //NSPersistentStoreCoordinator 把我们的模型文件 映射到数据库中
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    //设置数据库路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString * sqlPath = [path stringByAppendingPathComponent:@"coreData.sqlite"];
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    
    //添加持久化存储器 这里使用sqlite作为存储库
    //用协调器 去添加一个持久化存储器 2.类型 就选择sqlite作为存储库 3.nil 4.sqlite数据库的地址 5 nil 6.错误信息
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    if (error) {
        NSLog(@"创建数据库失败了");
        //oc中抛出异常很少用
        [NSException raise:@"添加数据库错误" format:@"%@",[error localizedDescription]];
    }else {
        NSLog(@"创建数据库成功");
    }
    
    
    //创建CoreData上下文
     NSManagedObjectContext *context = [[NSManagedObjectContext alloc]init];
    context.persistentStoreCoordinator = psc;
    self.context = context;//赋值
    
    NSLog(@"%@",NSHomeDirectory());
    
    
}
#pragma mark - 增加
-(void)insertData{
    //NSManagedObject 数据模型
    //NSEntityDescription 用来描述模型文件
    //1.实体名称    2.上下文
//    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
//    //给要插入的数据赋值 KVC 键值编码
//    [obj setValue:@"xiaoming" forKey:@"name"];
//    [obj setValue:@11 forKey:@"age"];
   
    
    
    Person *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
    //给要插入的数据赋值 KVC 键值编码
//    [obj setValue:@"xiaoming" forKey:@"name"];
//    [obj setValue:@11 forKey:@"age"];
        obj.name = @"xiaoming";
        obj.age= @11;
    
    //必须保存 context save
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"插入成功");
    }else {
        NSLog(@"插入失败%@",error);
    }
}

#pragma mark - 查询
-(void)selectData {
    //NSFetchRequest 是专门用来查询的类
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //查询的条件 和 要查询的实体
    
    //1.要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    //2.查询的条件  谓词
    //先创建一个谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",@"*aomi*"];
    //设置谓词
    request.predicate = predicate;
    
    //获取结果
    NSError *error = nil;
    NSArray *results = [_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }else {
        NSLog(@"%@",results);
        //枚举器 类似于循环
        [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@ ",[obj valueForKey:@"name"]);
            NSLog(@"%@ ",[obj valueForKey:@"age"]);
        }];
    }
}
#pragma mark - 删除 要先找到要删除的对象 然后再删除 最后保存一下
-(void)deleData {
    //查询请求 （先找到）
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //设置要查找的实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    //设置查询条件 %K表示要查询的key
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",@"name",@"xiaoming"];
    request.predicate = predicate;
    NSArray *result = [_context executeFetchRequest:request error:nil];

    
//    //删除
//    for (NSManagedObject *item in result) {
//        //使用上下文删除数据
//        [_context delete:item];
//    }
//    //删完之后 要保存
//
    
 
//    //删除
        for (Person *item in result) {
        //使用上下文删除数据
        [_context deleteObject:item];
        }
   

//    //删完之后 要保存
   
   [_context save:nil];
    
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end








                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          



































