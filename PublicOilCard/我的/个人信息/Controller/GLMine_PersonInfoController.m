//
//  GLMine_PersonInfoController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_PersonInfoController.h"
#import "GLMine_PersonInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GLMine_PersonInfoCodeView.h"


@interface GLMine_PersonInfoController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    //假数据源
    NSArray *_keyArr;
//    NSArray *_vlaueArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic, strong)NSDictionary *dataDic;

@property (nonatomic, strong)NSMutableArray *canEditArr;

@property (nonatomic, strong)NSMutableArray *vlaueArr;

@property (nonatomic, copy)NSString *bankNum;

@property (nonatomic, copy)NSString *oilCardNum;

@property (strong, nonatomic)UIImage *picImage;//头像

//@property (strong, nonatomic)NSString *trueName;//真实姓名
//@property (strong, nonatomic)NSString *IDNum;//ID
@property (strong, nonatomic)UIImage *codeImage;//二维码
//@property (strong, nonatomic)NSString *shenfenCode;//身份证号
////@property (strong, nonatomic)NSString *bankNum;//银行卡号
//@property (strong, nonatomic)NSString *openBank;//开户行
////@property (strong, nonatomic)NSString *jyzSelfCardNum;//油卡号
//@property (strong, nonatomic)NSString *recommendName;//推荐人真名
//@property (strong, nonatomic)NSString *recommendID;//推荐人ID

@property (nonatomic, strong)UIView *maskV;
@property (nonatomic, strong)GLMine_PersonInfoCodeView *contentV;

@end

@implementation GLMine_PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self updateInfo];
    
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"修改" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn.titleLabel setTextAlignment:NSTextAlignmentRight];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_PersonInfoCell" bundle:nil] forCellReuseIdentifier:@"GLMine_PersonInfoCell"];
}

- (void)updateInfo{
    
    _keyArr = @[@"头像",@"真实姓名",@"ID",@"二维码",@"身份证号码",@"开户银行",@"银行卡号",@"加油站自办芯片卡号",@"全团ID",@"推荐人",@"推荐人ID"];

    self.vlaueArr = [NSMutableArray arrayWithObjects:
                     [UserModel defaultUser].pic,
                     [UserModel defaultUser].truename,
                     [UserModel defaultUser].username,
                     [UserModel defaultUser].username,
                     [UserModel defaultUser].IDCard,
                     [UserModel defaultUser].openbank,
                     [UserModel defaultUser].banknumber,
                     [UserModel defaultUser].jyzSelfCardNum,
                     [UserModel defaultUser].qtIdNum,
                     [UserModel defaultUser].recommendUser,
                     [UserModel defaultUser].recommendID, nil];
    
}
//MARK: 二维码中间内置图片,可以是公司logo
-(UIImage *)logoQrCode{
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性 (老油条)
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    NSData *qrImageData = [[UserModel defaultUser].username dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    
    //再把小图片画上去
    UIImage *sImage = [UIImage imageNamed:@""];
    
    CGFloat sImageW = 100;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //设置图片
    return finalyImage;
}

- (void)edit:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改信息" message:@"请输入要修改的信息" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入油卡卡号";
        textField.tag = 12;
        textField.delegate = self;
        
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入全团ID";
        textField.tag = 13;
        textField.delegate = self;
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        
    }];
    
    __weak typeof(self) weakself = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //            UITextField *openBankTF = alertController.textFields[0];
        //            UITextField *bankNumTF = alertController.textFields[1];
        UITextField *oilNumTF = alertController.textFields[0];
        UITextField *qtIdNumTF = alertController.textFields[1];

        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
//                [weakself modifyInfo:bankNumTF.text OilNum:oilNumTF.text andOpenbank:openBankTF.text qtIdNum:qtIdNumTF.text];
                [weakself modifyInfo:oilNumTF.text qtIdNum:qtIdNumTF.text];
            });
            
            
        }];
    
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
    
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"请输入开户银行名";
//        textField.tag = 10;
//        textField.delegate = self;
//
//    }];
//
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"请输入银行卡号";
//        textField.tag = 11;
//        textField.delegate = self;
//
//
//    }];
    
    [self presentViewController:alertController animated:YES completion:nil];

 }
- (void)modifyInfo:(NSString *)oilNum qtIdNum:(NSString *)qtIdNum{
  
    if ( oilNum.length == 0 && qtIdNum.length == 0) {
        
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
//    
//    if (openbank.length != 0) {
//        
//        if (![predicateModel IsChinese:openbank]) {
//            [MBProgressHUD showError:@"开户行只能是中文"];
//            return;
//        }
//        dict[@"openbank"] = openbank;
//    }
//    if(bankNum.length != 0){
//        
//        dict[@"banknumber"] = bankNum;
////        if (![predicateModel IsBankCard:bankNum]) {
////            [MBProgressHUD showError:@"请输入正确的银行卡号"];
////            return;
////        }
//    }
    if (oilNum.length != 0) {
        
        dict[@"jyzSelfCardNum"] = oilNum;
    }
    
    if (qtIdNum.length != 0) {
        
        dict[@"qtIdNum"] = qtIdNum;
    }
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:[UIApplication sharedApplication].keyWindow];
    [NetworkManager requestPOSTWithURLStr:@"UserInfo/user_info_in" paramDic:dict finish:^(id responseObject) {
        [_loadV removeloadview];
   
        if ([responseObject[@"code"] integerValue]==1) {
            
            [self updateData];
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
            
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
}
- (void)updateData {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:[UIApplication sharedApplication].keyWindow];
    [NetworkManager requestPOSTWithURLStr:@"user/refresh" paramDic:dict finish:^(id responseObject) {
        [_loadV removeloadview];
        
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            
//            [UserModel defaultUser].openbank = responseObject[@"data"][@"openbank"];
//            [UserModel defaultUser].banknumber = responseObject[@"data"][@"banknumber"];
            [UserModel defaultUser].jyzSelfCardNum = responseObject[@"data"][@"jyzSelfCardNum"];
            [UserModel defaultUser].qtIdNum = responseObject[@"data"][@"qtIdNum"];
            
            [usermodelachivar achive];
            [self updateInfo];
            [MBProgressHUD showSuccess:@"修改资料成功"];
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
            
        }
        [self.tableView reloadData];
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
}
#pragma UITextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.tag == 11 || textField.tag == 12) {//身份证号只能输入数字和X
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest){
            [MBProgressHUD showError:@"输入不合法"];
            return NO;
        }
        
    }else if (textField.tag == 13){
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest){
            [MBProgressHUD showError:@"输入不合法"];
            return NO;
        }
    }
    return YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return _keyArr.count - 2;
        
    }else{
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_PersonInfoCell"];
    cell.selectionStyle = 0;
    cell.index = indexPath.row;
    
    if (indexPath.section == 0) {
        
        cell.titleLabel.text = _keyArr[indexPath.row];
        cell.detailTF.text = _vlaueArr[indexPath.row];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            
            if (indexPath.row == 0) {
                cell.picImageV.layer.cornerRadius = cell.picImageV.width/2;
                cell.picImageV.clipsToBounds = YES;
                [cell.picImageV sd_setImageWithURL:[NSURL URLWithString:[UserModel defaultUser].pic] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
                
                if (!cell.picImageV.image) {
                    cell.picImageV.image = self.picImage;
                    if (self.picImage == nil) {
                        cell.picImageV.image = [UIImage imageNamed:PlaceHolderImage];
                    }
                }
                
            }else{
                cell.picImageV.layer.cornerRadius = 0;
                cell.picImageV.image = [self logoQrCode];
            }
            
            cell.picImageV.hidden = NO;
            cell.detailTF.hidden = YES;
        }else{

            cell.picImageV.hidden = YES;
            cell.detailTF.hidden = NO;
        }

    }else{
        cell.picImageV.hidden = YES;
        cell.detailTF.hidden = NO;
        cell.titleLabel.text = _keyArr[indexPath.row + 9];
        cell.detailTF.text = _vlaueArr[indexPath.row + 9];
        
    }

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
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
    }else if(indexPath.row == 3 && indexPath.section == 0){
        
        [self.view addSubview:self.maskV];
        [UIView animateWithDuration:0.2 animations:^{
            self.contentV.transform=CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {
            [self.maskV addSubview:self.contentV];
            
        }];
    }
}
- (void)maskViewTap {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentV.transform=CGAffineTransformMakeScale(0.1, 0.00001);
        
    } completion:^(BOOL finished) {
//        [self.contentV removeFromSuperview];
        [self.maskV removeFromSuperview];
    }];

}

- (UIView *)maskV{
    if (!_maskV) {
        _maskV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskV.backgroundColor = YYSRGBColor(184, 184, 184, 0.5);
        
        UITapGestureRecognizer *maskViewTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewTap)];
        [_maskV addGestureRecognizer:maskViewTap];
    }
    return _maskV;
}

- (GLMine_PersonInfoCodeView *)contentV{
    if (!_contentV) {
        _contentV = [[NSBundle mainBundle] loadNibNamed:@"GLMine_PersonInfoCodeView" owner:nil options:nil].lastObject;

        _contentV.layer.cornerRadius = 5.f;
        
        _contentV.frame = CGRectMake(20, (SCREEN_HEIGHT - 200)/2, SCREEN_WIDTH - 40, 200);
        _contentV.codeImageV.image = [self logoQrCode];

    }
    return _contentV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            
            return 60;
        }else{
            return 40;
        }
    }else{
        return 40;
    }
}
#pragma 调相机 相册
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
            
            data = UIImageJPEGRepresentation(image, 0.2);
        }else {
            data=    UIImageJPEGRepresentation(image, 0.2);
        }
        //#warning 这里来做操作，提交的时候要上传
        // 图片保存的路径
        self.picImage = [UIImage imageWithData:data];
        
        
        
        //拿到图片准备上传
         NSDictionary *dic;
         dic=@{@"token":[UserModel defaultUser].token ,
               @"uid":[UserModel defaultUser].uid};
        _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        manager.requestSerializer.timeoutInterval = 10;
        // 加上这行代码，https ssl 验证。
        [manager setSecurityPolicy:[NetworkManager customSecurityPolicy]];
        [manager POST:[NSString stringWithFormat:@"%@%@",URL_Base,@"UserInfo/save_picture"] parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //将图片以表单形式上传
            
            if (self.picImage) {
                
                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                formatter.dateFormat=@"yyyyMMddHHmmss";
                NSString *str=[formatter stringFromDate:[NSDate date]];
                NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
                NSData *data = UIImagePNGRepresentation(self.picImage);
                [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/png"];
            }
            
        }progress:^(NSProgress *uploadProgress){
            
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:[NSString stringWithFormat:@"上传中%.0f%%",(uploadProgress.fractionCompleted * 100)]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setCornerRadius:8.0];
            
            if (uploadProgress.fractionCompleted == 1.0) {
                [SVProgressHUD dismiss];
//                self.submit.userInteractionEnabled = YES;
            }

        }success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"]integerValue]==1) {
                
                [MBProgressHUD showError:dic[@"message"]];
                [self refresh];
            }else{
                [MBProgressHUD showError:dic[@"message"]];
            }
            [_loadV removeloadview];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [_loadV removeloadview];
            [MBProgressHUD showError:error.localizedDescription];
        }];
        
    }
    
    [self.tableView reloadData];

        
    [picker dismissViewControllerAnimated:YES completion:nil];
        
    
}

- (void)refresh {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    
    [NetworkManager requestPOSTWithURLStr:@"user/refresh" paramDic:dict finish:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==1) {
            [UserModel defaultUser].price = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"price"]];
            [UserModel defaultUser].mark = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"mark"]];
            [UserModel defaultUser].recNumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"recNumber"]];
            [UserModel defaultUser].yue = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"yue"]];
            [UserModel defaultUser].username = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"username"]];
            [UserModel defaultUser].truename = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"truename"]];
            [UserModel defaultUser].group_name = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"group_name"]];
            [UserModel defaultUser].isHaveOilCard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isHaveOilCard"]];
            [UserModel defaultUser].pic = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"pic"]];
            
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].price] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].price = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].mark] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].mark = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].recNumber] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].recNumber = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].username] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].username = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].truename] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].truename = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].group_name] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].group_name = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].isHaveOilCard] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].isHaveOilCard = @"";
            }
            
            [usermodelachivar achive];
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        
        [MBProgressHUD showError:error.localizedDescription];
    }];
}
- (NSMutableArray *)vlaueArr{
    if (!_vlaueArr) {
        _vlaueArr = [[NSMutableArray alloc] init];
        
    }
    return _vlaueArr;
}
@end
