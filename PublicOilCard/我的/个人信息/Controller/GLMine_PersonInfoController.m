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

@interface GLMine_PersonInfoController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //假数据源
    NSArray *_keyArr;
//    NSArray *_vlaueArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic, strong)NSDictionary *dataDic;

@property (nonatomic, strong)NSMutableArray *canEditArr;

@property (nonatomic, strong)NSMutableArray *vlaueArr;

@property (nonatomic, copy)NSString *bankNum;

@property (nonatomic, copy)NSString *oilCardNum;

@property (strong, nonatomic)UIImage *picImage;//头像

//@property (strong, nonatomic)NSString *trueName;//真实姓名
//@property (strong, nonatomic)NSString *IDNum;//ID
//@property (strong, nonatomic)UIImage *codeImage;//二维码
//@property (strong, nonatomic)NSString *shenfenCode;//身份证号
////@property (strong, nonatomic)NSString *bankNum;//银行卡号
//@property (strong, nonatomic)NSString *openBank;//开户行
////@property (strong, nonatomic)NSString *jyzSelfCardNum;//油卡号
//@property (strong, nonatomic)NSString *recommendName;//推荐人真名
//@property (strong, nonatomic)NSString *recommendID;//推荐人ID

@end

@implementation GLMine_PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    
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
    [self getPersonInfo];
}

- (void)updateInfo{
    
    _keyArr = @[@"头像",@"真实姓名",@"ID",@"二维码",@"身份证号码",@"银行卡号",@"开户银行",@"加油站自办芯片卡号",@"推荐人",@"推荐人ID"];

    self.vlaueArr = [NSMutableArray arrayWithObjects:
                     [UserModel defaultUser].pic,
                     [UserModel defaultUser].truename,
                     [UserModel defaultUser].username,
                     [UserModel defaultUser].IDCard,
                     [UserModel defaultUser].pic,
                     [UserModel defaultUser].banknumber,
                     [UserModel defaultUser].openbank,
                     [UserModel defaultUser].jyzSelfCardNum,
                     [UserModel defaultUser].recommendUser,
                     [UserModel defaultUser].recommendID, nil];
    
//    self.picImage = [UserModel defaultUser].pic;
//    self.trueName = [UserModel defaultUser].truename;
//    self.IDNum = [UserModel defaultUser].username;
//    self.shenfenCode = [UserModel defaultUser].IDCard;
//    self.picImage = [UserModel defaultUser].pic;
//    self.bankNum = [UserModel defaultUser].banknumber;
//    self.openBank = [UserModel defaultUser].openbank;
//    self.oilCardNum = [UserModel defaultUser].jyzSelfCardNum;
//    self.recommendName = [UserModel defaultUser].recommendUser;
//    self.recommendID = [UserModel defaultUser].recommendID;
    
    
    self.tableViewHeight.constant = 8 * 40 + 2 * 60 + 30;

}

- (void)edit:(UIButton *)sender {
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改信息" message:@"请输入要修改的信息" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            
        }];
        __weak typeof(self) weakself = self;
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UITextField *openBankTF = alertController.textFields[0];
            UITextField *bankNumTF = alertController.textFields[1];
            UITextField *oilNumTF = alertController.textFields[2];
            
            [weakself modifyInfo:bankNumTF.text OilNum:oilNumTF.text andOpenbank:openBankTF.text];
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入开户银行名";
        
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入银行卡号";
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入油卡卡号";
        
    }];
    
        [self presentViewController:alertController animated:YES completion:nil];

        
        
        NSLog(@"可以编辑了");
 
}
- (void)modifyInfo:(NSString *)bankNum OilNum:(NSString *)oilNum andOpenbank:(NSString *)openbank{
  
    if (bankNum.length == 0 && oilNum.length == 0 && openbank.length == 0) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    if(bankNum.length == 0){
//        dict[@"banknumber"] = @"";
    }else{
        
        dict[@"banknumber"] = bankNum;
    }
    if (oilNum.length == 0) {
//        dict[@"jyzSelfCardNum"] = @"";

    }else{
        
        dict[@"jyzSelfCardNum"] = oilNum;
    }

    if (openbank.length == 0) {
//        dict[@"openbank"] = @"";
        
    }else{
        
        dict[@"openbank"] = openbank;
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
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            
            [UserModel defaultUser].openbank = responseObject[@"data"][@"openbank"];
            [UserModel defaultUser].banknumber = responseObject[@"data"][@"banknumber"];
            [UserModel defaultUser].jyzSelfCardNum = responseObject[@"data"][@"jyzSelfCardNum"];
            
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
- (void)getPersonInfo{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"token"] = [UserModel defaultUser].token;
//    dict[@"uid"] = [UserModel defaultUser].uid;
// 
//    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
//    [NetworkManager requestPOSTWithURLStr:@"UserInfo/info_go" paramDic:dict finish:^(id responseObject) {
//        
//        [_loadV removeloadview];
//   
//        if ([responseObject[@"code"] integerValue]==1) {
//            self.dataDic = responseObject[@"data"];
//            
//        }else{
//            [MBProgressHUD showError:responseObject[@"message"]];
//        }
//        [self.tableView reloadData];
//    } enError:^(NSError *error) {
//        [_loadV removeloadview];
//        [MBProgressHUD showError:error.localizedDescription];
//        
//    }];
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
        
        return 8;
        
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
        cell.detailTF.enabled = [self.canEditArr[indexPath.row] boolValue];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.picImageV.image = [UIImage imageNamed:_vlaueArr[indexPath.row]];
            cell.picImageV.hidden = NO;
            cell.detailTF.hidden = YES;
            
            if (indexPath.row == 0) {
                cell.picImageV.layer.cornerRadius = cell.picImageV.width/2;
                
            }else{
                cell.picImageV.layer.cornerRadius = 0;
            }
        }else{

            cell.picImageV.hidden = YES;
            cell.detailTF.hidden = NO;
        }

    }else{
        cell.picImageV.hidden = YES;
        cell.detailTF.hidden = NO;
        cell.titleLabel.text = _keyArr[indexPath.row + 8];
        cell.detailTF.text = _vlaueArr[indexPath.row + 8];
        
    }

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
       
        UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"去相册选择",@"用相机拍照", nil];
        [actionSheet showInView:self.view];

        
    }

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
            
            data = UIImageJPEGRepresentation(image, 0.2);
        }else {
            data=    UIImageJPEGRepresentation(image, 0.2);
        }
        //#warning 这里来做操作，提交的时候要上传
        // 图片保存的路径
        self.picImage = [UIImage imageWithData:data];
        [self.tableView reloadData];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}
- (NSMutableArray *)vlaueArr{
    if (!_vlaueArr) {
        _vlaueArr = [[NSMutableArray alloc] init];
        
    }
    return _vlaueArr;
}
@end
