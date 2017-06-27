//
//  GLMine_UploadController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/26.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_UploadController.h"
#import "GLMine_UploadRecordController.h"

@interface GLMine_UploadController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    LoadWaitView *_loadV;
}

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *oilCardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;


@property (nonatomic, strong)UIImage *picImage;

@end

@implementation GLMine_UploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //自定义右键
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"记录" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [btn addTarget:self  action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(0, 0, 80, 40);
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentViewWidth.constant = SCREEN_WIDTH;
    self.contentViewHeight.constant = 680;
    self.navigationItem.title = @"上传凭证";
    self.submitBtn.layer.cornerRadius = 5.f;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
//上传图片
- (IBAction)choosePicture:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"用相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getcamera];//获取照相机
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getpicture];//获取相册
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cameraAction];
    [alertVC addAction:albumAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];

}
#pragma mark 调相机 相册
-(void)getpicture{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //    // 设置选择后的图片可以被编辑
    //    picker.allowsEditing = YES;
    //    [self presentViewController:picker animated:YES completion:nil];
    //1.获取媒体支持格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.mediaTypes = @[mediaTypes[0]];
    //5.其他配置
    //allowsEditing是否允许编辑，如果值为no，选择照片之后就不会进入编辑界面
    picker.allowsEditing = YES;
    //6.推送
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)getcamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        // 设置拍照后的图片可以被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
//    if ([type isEqualToString:@"public.image"]) {
        // 先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            
            data = UIImageJPEGRepresentation(image, 0.2);
        }else {
            data=    UIImageJPEGRepresentation(image, 0.2);
        }
        //#warning 这里来做操作，提交的时候要上传
        // 图片保存的路径
        self.picImage = [UIImage imageWithData:data];
        
        self.imageV.image = self.picImage;
        
        //拿到图片准备上传
//        NSDictionary *dic;
//        dic=@{@"token":[UserModel defaultUser].token ,
//              @"uid":[UserModel defaultUser].uid};
//        _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
//        manager.requestSerializer.timeoutInterval = 10;
//        // 加上这行代码，https ssl 验证。
//        [manager setSecurityPolicy:[NetworkManager customSecurityPolicy]];
//        [manager POST:[NSString stringWithFormat:@"%@%@",URL_Base,@"UserInfo/save_picture"] parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            //将图片以表单形式上传
//            
//            if (self.picImage) {
//                
//                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//                formatter.dateFormat=@"yyyyMMddHHmmss";
//                NSString *str=[formatter stringFromDate:[NSDate date]];
//                NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
//                NSData *data = UIImagePNGRepresentation(self.picImage);
//                [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/png"];
//            }
//            
//        }progress:^(NSProgress *uploadProgress){
//            
//            [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:[NSString stringWithFormat:@"上传中%.0f%%",(uploadProgress.fractionCompleted * 100)]];
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//            [SVProgressHUD setCornerRadius:8.0];
//            
//            if (uploadProgress.fractionCompleted == 1.0) {
//                [SVProgressHUD dismiss];
//                //                self.submit.userInteractionEnabled = YES;
//            }
//            
//        }success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dic[@"code"]integerValue]==1) {
//                
//                [MBProgressHUD showError:dic[@"message"]];
//
//            }else{
//                [MBProgressHUD showError:dic[@"message"]];
//            }
//            [_loadV removeloadview];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [_loadV removeloadview];
//            [MBProgressHUD showError:error.localizedDescription];
//        }];
//        
//    }
//    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)submit:(id)sender {
    
}

- (void)record{
    
}
- (IBAction)record:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    GLMine_UploadRecordController *recordVC = [[GLMine_UploadRecordController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
