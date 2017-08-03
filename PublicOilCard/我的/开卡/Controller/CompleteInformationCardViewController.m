//
//  CompleteInformationCardViewController.m
//  PublicOilCard
//
//  Created by 四川三君科技有限公司 on 2017/8/3.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "CompleteInformationCardViewController.h"
#import "QQPopMenuView.h"

@interface CompleteInformationCardViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *typeLb;
@property (weak, nonatomic) IBOutlet UIImageView *imagev;
@property (weak, nonatomic) IBOutlet UILabel *noticelb;
@property (weak, nonatomic) IBOutlet UIButton *submitBt;
@property(nonatomic , assign)NSInteger typeindex;
@end

@implementation CompleteInformationCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"补全信息";
    self.typeindex = 0;
    self.noticelb.text = @"方式一:通过推荐人获得油卡,请上传油卡照片\n方式二:通过平台邮寄获得油卡,请上传线下打款凭证";
}

- (IBAction)tapgestrueType:(UITapGestureRecognizer *)sender {
    
    QQPopMenuView *popview = [[QQPopMenuView alloc]initWithItems:@[@{@"title":@"推荐人处获得",@"imageName":@""}, @{@"title":@"平台邮寄",@"imageName":@""}] width:120 triangleLocation:CGPointMake([UIScreen mainScreen].bounds.size.width - 50, 90 ) action:^(NSInteger index) {
        
        if (index == 0) {
            self.typeLb.text = @"推荐人处获得";
            self.typeindex = 1;
            self.noticelb.text = @"请上传您的油卡的照片";
        }else{
            self.typeLb.text = @"平台邮寄";
            self.typeindex = 2;
            self.noticelb.text = @"请上传您购买油卡打款凭证的照片";
        }
       
    }];
    
    popview.isHideImage = YES;
    
    [popview show];
}
- (IBAction)tapgestrueimage:(UITapGestureRecognizer *)sender {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"去相册选择",@"用相机拍照", nil];
    [actionSheet showInView:self.view];
}
- (IBAction)clickSubmitBt:(UIButton *)sender {
    
    if (!self.imagev.image || [UIImagePNGRepresentation(self.imagev.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"照片框-拷贝-9"])]) {
        [MBProgressHUD showError:@"请上传图片"];
        return;
    }
    
    self.submitBt.userInteractionEnabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.requestSerializer.timeoutInterval = 20;
    // 加上这行代码，https ssl 验证。
    [manager setSecurityPolicy:[NetworkManager customSecurityPolicy]];
    [manager POST:[NSString stringWithFormat:@"%@UserInfo/card_pic",URL_Base] parameters:@{@"uid":[UserModel defaultUser].uid,@"token":[UserModel defaultUser].token,@"pic_type":@(self.typeindex),@"card_fun":@(self.card_fun)}  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //将图片以表单形式上传
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyyMMddHHmmss";
        NSString *str=[formatter stringFromDate:[NSDate date]];
        NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
        NSData *data = UIImagePNGRepresentation(self.imagev.image);
        [formData appendPartWithFileData:data name:@"my_pic" fileName:fileName mimeType:@"image/png"];
    
        
    }progress:^(NSProgress *uploadProgress){
        
        [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:[NSString stringWithFormat:@"上传中%.0f%%",(uploadProgress.fractionCompleted * 100)]];
        //        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        //        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        //        [SVProgressHUD setCornerRadius:8.0];
        
        if (uploadProgress.fractionCompleted == 1.0) {
            [SVProgressHUD dismiss];
            self.submitBt.userInteractionEnabled = YES;
        }
        
    }success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"code"]integerValue]==1) {
            
            [MBProgressHUD showError:dic[@"message"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:dic[@"message"]];
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.submitBt.userInteractionEnabled = YES;
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [self getpicture];//获取相册
        }break;
            
        case 1:{
            [self getcamera];//获取照相机
        }break;
        default:
            break;
    }
}

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
    if ([type isEqualToString:@"public.image"]) {
        // 先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            
            data = UIImageJPEGRepresentation(image, 0.3);
        }else {
            data=    UIImageJPEGRepresentation(image, 0.3);
        }
        //#warning 这里来做操作，提交的时候要上传
        // 图片保存的路径
       
        self.imagev.image = [UIImage imageWithData:data];
                
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.submitBt.layer.cornerRadius = 4;
    self.submitBt.clipsToBounds = YES;

}
@end
