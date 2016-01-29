//
//  DetailViewController.m
//  Homework ByMyself
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "DetailViewController.h"
#import "Student+CoreDataProperties.h"
#import "MagicalRecord.h"
@interface DetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIImagePickerController *picker;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HeadImageViewTap)];
    [self.headImageView addGestureRecognizer:tap];
    self.headImageView.userInteractionEnabled = YES;
    
    [self addRightItem];
}
//实现手势的方法
-(void)HeadImageViewTap {
    //UIImagePickerController 系统选择图片视图控制器
    
    _picker = [[UIImagePickerController alloc]init];
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _picker.delegate = self;
    [self presentViewController:_picker animated:YES completion:nil];
    
}

-(void)addRightItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnPressed)];
}

-(void)rightBtnPressed {
    //首先要先拿到值
    NSString *name = self.nameTextField.text;
    NSString *infor = self.inforTextField.text;
    NSNumber * age = @(self.ageTextField.text.integerValue);
    UIImage *image = self.headImageView.image;
    
    //把图片转化成二进制
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //把拿到的数据放到数据库中
    Student *student = [Student MR_createEntity];
    student.name = name;
    student.information = infor;
    student.age = age;
    student.headImageData = imageData;
    
    //保存
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    //需要传值给上一个界面
    if (self.block) {
        self.block();
    }
    
    
    //让页面消失
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //NSLog(@"****%@",info);
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.headImageView.image = image;
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
