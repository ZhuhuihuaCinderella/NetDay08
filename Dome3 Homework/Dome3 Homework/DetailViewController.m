//
//  DetailViewController.m
//  Dome3 Homework
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "DetailViewController.h"

#import "Student+CoreDataProperties.h"
#import "MagicalRecord.h"

@interface DetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (nonatomic,strong)UIImagePickerController *pickerVC;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //点击手势  添加事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView)];
    self.headImage.userInteractionEnabled = YES;
    [self.headImage addGestureRecognizer:tap];
    [self addRightItem];
}
#pragma mark - 创建右边按钮
-(void)addRightItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemPressed)];
}
//实现方法
-(void)rightItemPressed{
    //首先拿到三个值 name age
    NSString *name = _nameTF.text;
    NSNumber *age = @(_ageTF.text.integerValue);
    UIImage *image = self.headImage.image;
    
    //把图片转化成二进制
    NSData *imageData = UIImagePNGRepresentation(image);
    
    
    
   //第一个参数 图片 第二个参数 压缩质量（一般0-1之间）
    //UIImageJPEGRepresentation(image, 0.5);
    
    //把拿到的值存入数据库
    Student *student = [Student MR_createEntity];
    student.name = name;
    student.age = age;
    student.headImageData = imageData;
    
    //保存数据需要上下文
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    //需要传值给上一个界面
    if (self.block) {
        self.block();
    }
    
    //页面消失
    [self dismissViewControllerAnimated:YES completion:nil];
}

//实现手势方法
-(void)tapImageView {
    //系统图片选择试图控制器
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    self.pickerVC = pickerVC;
    //设置代理
    pickerVC.delegate = self;
    /*
     UIImagePickerControllerSourceTypePhotoLibrary,图片资源库
     UIImagePickerControllerSourceTypeCamera,相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum相册
     */
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //弹出试图控制器
    [self presentViewController:pickerVC animated:YES completion:nil];
    
    
}

#pragma mark - 实现协议方法

//选择了一张图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //info里面存的就是 图片的信息

     NSLog(@"*******%@",info);//info是个字典
    
    //
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    _headImage.image = image;
    
    
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
   
    
}
//取消选择
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
