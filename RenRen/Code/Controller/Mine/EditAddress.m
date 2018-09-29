//
//  EditAddress.m
//  KYRR
//
//  Created by kyjun on 15/11/3.
//
//

#import "EditAddress.h"
#import "AppDelegate.h"
#import "EditAddressMap.h"
#import "EmptyAddressMap.h"
#import <GooglePlaces/GooglePlaces.h>

@interface EditAddress ()
@property(nonatomic,strong) UIView* headerView;

@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIButton* btnArea;
@property(nonatomic,strong) UIImageView* iconLocation;
@property(nonatomic,strong) UILabel* labelMapAddress;
@property(nonatomic,strong) UIImageView* arrow;
@property(nonatomic,strong) UITextField* txtMapNumber;
@property(nonatomic,strong) UITextField* txtZipcode;
@property(nonatomic,strong) UITextField* txtUserName;
@property(nonatomic,strong) UITextField* txtPhone;

@property(nonatomic,strong) UIButton* btnConfirm;
/**
 *  对应 AMapPOI.address
 */
@property(nonatomic,copy) NSString* mapName;
/**
 *  目前不需要对应
 */
@property(nonatomic,copy) NSString* mapAddress;
/**
 *  目前不徐亚对应
 */
@property(nonatomic,strong) NSString* mapNumber;
@property(nonatomic,strong) NSString* mapLat;
@property(nonatomic,strong) NSString* mapLng;
/**
 *  对应搜索出来的 address
 */
@property(nonatomic,strong) NSString* mapLocation;

@property(nonatomic,strong) MAddress* entity;

@end

@implementation EditAddress

-(instancetype)initWithItem:(MAddress *)item{
    self = [super init];
    if(self){
        _entity = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    [self layoutUI];
    [self layoutConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editAddressMap:) name:NotificationSelecteMapAddress object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.entity && self.firstLoad){
        self.labelMapAddress.text = self.entity.mapAddress;
        self.txtMapNumber.text = self.entity.mapLocation;
        self.txtZipcode.text = self.entity.mapNumber;
        self.txtUserName.text = self.entity.userName;
        self.txtPhone.text = self.entity.phoneNum;
        self.mapName = self.entity.mapAddress;
        self.mapLat = self.entity.mapLat;
        self.mapLng = self.entity.mapLng;
        self.mapLocation = self.entity.mapLocation;
        self.firstLoad = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =self.entity ? Localized(@"Edit_address"): Localized(@"Add_address");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  试图布局
-(void)layoutUI{
    self.headerView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.f)];
    [self.headerView addSubview:self.labelTitle];
    [self.headerView addSubview:self.btnArea];
    [self.btnArea addSubview:self.iconLocation];
    [self.btnArea addSubview:self.labelMapAddress];
    [self.btnArea addSubview:self.arrow];
    [self.headerView addSubview:self.txtMapNumber];
    [self.headerView addSubview:self.txtZipcode];
    [self.headerView addSubview:self.txtUserName];
    [self.headerView addSubview:self.txtPhone];
    [self.headerView addSubview:self.btnConfirm];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)layoutConstraints{
    
    NSArray* formats = @[ @"H:|-0-[titleView(==titleWidth)]",
                          @"H:[titleView]-0-[btnArea]-0-|",
                          @"H:|-0-[txtMapNumber]-0-|",
                          @"H:|-0-[txtZipcode]-0-|",
                          @"H:|-0-[txtUserName]-0-|",
                          @"H:|-0-[txtPhone]-0-|",
                          @"H:[btnConfirm(==confirmWidth)]",
                          @"V:|-0-[titleView(==titleHeight)]",
                          @"V:|-0-[btnArea(==titleView)]",
                          @"V:[btnArea(==titleView)]-1-[txtMapNumber(==titleView)]-1-[txtZipcode(==titleView)]-1-[txtUserName(==titleView)]-1-[txtPhone(==titleView)]-20-[btnConfirm(==confirmHeight)]",
                          @"H:|-0-[iconLocation(==20)]-0-[labelMapAddress]-0-[arrow(==8)]-10-|",
                          @"V:|-10-[iconLocation]-10-|",
                          @"V:|-0-[labelMapAddress]-0-|",
                          @"V:|-13-[arrow]-13-|",
                          ];
    
    NSDictionary* metorics = @{ @"titleWidth": @(80.f), @"titleHeight":@(40.f), @"confirmWidth":@(SCREEN_WIDTH/2), @"confirmHeight":@(40.f)};
    NSDictionary* views = @{ @"titleView":self.labelTitle, @"btnArea":self.btnArea, @"txtMapNumber":self.txtMapNumber,@"txtZipcode":self.txtZipcode, @"txtUserName":self.txtUserName, @"txtPhone":self.txtPhone, @"btnConfirm":self.btnConfirm, @"iconLocation":self.iconLocation, @"labelMapAddress":self.labelMapAddress, @"arrow":self.arrow};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self.headerView addConstraints:constraints];
    }
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.btnConfirm attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.headerView addConstraint:constraint];
}



#pragma mark =====================================================  SEL
-(IBAction)btnConfirmTouch:(id)sender{
    [self showHUD];
    if([self checkForm]){
        [self editAddress];
    }
}

-(IBAction)mapSelectAddress:(id)sender{
    if(self.entity && ![WMHelper isEmptyOrNULLOrnil:self.entity.mapLat] && ![WMHelper isEmptyOrNULLOrnil:self.entity.mapLng]) {
        CLLocationCoordinate2D d2 = CLLocationCoordinate2DMake([self.entity.mapLat doubleValue], [self.entity.mapLng doubleValue]);
        if(IOS_VERSION<8.0){// 适配 iOS7
            EmptyAddressMap* controller = [[EmptyAddressMap alloc]initWith:[[CLLocation alloc]initWithLatitude:d2.latitude longitude:d2.longitude]];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            EditAddressMap* controller = [[EditAddressMap alloc]initWith:[[CLLocation alloc]initWithLatitude:d2.latitude longitude:d2.longitude]];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }else{
        if(IOS_VERSION<8.0){// 适配 iOS7
            EmptyAddressMap* controller = [[EmptyAddressMap alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            EditAddressMap* controller = [[EditAddressMap alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark =====================================================  Notification
-(void)editAddressMap:(NSNotification*)notification{
    GMSPlace* item = (GMSPlace*)[notification object];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapName = item.name;
        self.mapAddress =  @"";
        self.mapNumber =  @"";
        self.mapLocation = item.formattedAddress;
        self.mapLat = [[NSString alloc]initWithFormat: @"%.6f",item.coordinate.latitude];
        self.mapLng = [NSString stringWithFormat: @"%.6f",item.coordinate.longitude];
        self.labelMapAddress.text = item.name;
    });
}

#pragma mark =====================================================  私有方法
-(void)editAddress{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            if([self checkForm]){
                //NSMutableDictionary* arg = [[NSMutableDictionary alloc]initWithDictionary:@{@"ince":@"add_user_addr_ince_map",@"uid":self.Identity.userInfo.userID,@"uname":self.txtUserName.text,@"phone":self.txtPhone.text, @"map_addr":self.mapName, @"map_number":self.txtZipcode.text, @"lat": self.mapLat, @"lng": self.mapLng, @"map_location":self.mapLocation}];
                NSString *de = [NSString stringWithFormat:@"%@",self.entity.isDefault ? @"1" : @"0"];
                NSMutableDictionary* arg = [[NSMutableDictionary alloc]initWithDictionary:@{@"a":@"addUserAddress",@"uid":self.Identity.userInfo.userID,@"uname":self.txtUserName.text,@"phone":self.txtPhone.text, @"map_addr":self.mapName, @"map_number":self.txtZipcode.text, @"lat": self.mapLat, @"lng": self.mapLng, @"map_location":self.txtMapNumber.text, @"default":de}];
                if (self.entity) {
                    [arg setObject:self.entity.rowID forKey:@"itemid"];
                }else{
                    [arg setObject:@"0" forKey:@"itemid"];
                }
                NetRepositories* repositories = [[NetRepositories alloc]init];
                [repositories updateAddres:arg complete:^(NSInteger react, id obj, NSString *message) {
                    if(react == 1){
                        [self hidHUD];
                        [self alertHUD: Localized(@"Success_txt") complete:^{
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }else if(react == 400){
                        [self alertHUD:message];
                    }else{
                        [self alertHUD:message];
                    }
                }];
            }
        }
    }];
}

-(BOOL)checkForm{
    if([WMHelper isEmptyOrNULLOrnil:self.txtMapNumber.text]){
        [self hidHUD];
        [self alertHUD:Localized(@"Address_not_empty")];
        return NO;
    }else if([WMHelper isEmptyOrNULLOrnil:self.txtZipcode.text]){
        [self hidHUD];
        [self alertHUD:Localized(@"Zipcode_not_empty")];
        return NO;
    }else if ([WMHelper isEmptyOrNULLOrnil:self.txtUserName.text]){
        [self hidHUD];
        [self alertHUD:Localized(@"Rece_person_not_empty")];
        return NO;
    }else if (![WMHelper isValidateMobile:self.txtPhone.text]){
        [self hidHUD];
        [self alertHUD:Localized(@"Phone_error")];
        return NO;
    }else if ([WMHelper isEmptyOrNULLOrnil:self.labelMapAddress.text]){
        [self hidHUD];
        [self alertHUD:Localized(@"Rece_addr_not_empty")];
        return NO;
    }
    return YES;
}



#pragma mark =====================================================  property package
-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.text = [NSString stringWithFormat:@"    %@",Localized(@"Rece_addr_not_empty")] ;
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.textColor = theme_Fourm_color;
        _labelTitle.backgroundColor = [UIColor whiteColor];
        _labelTitle.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _labelTitle;
}

-(UIButton *)btnArea{
    if(!_btnArea){
        _btnArea = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnArea.backgroundColor = [UIColor whiteColor];
        [_btnArea addTarget:self action:@selector(mapSelectAddress:) forControlEvents:UIControlEventTouchUpInside];
        _btnArea.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnArea;
}

-(UIImageView *)iconLocation{
    if(!_iconLocation){
        _iconLocation = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"locate"]];
        _iconLocation.backgroundColor = [UIColor  clearColor];
        _iconLocation.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconLocation;
}

-(UILabel *)labelMapAddress{
    if(!_labelMapAddress){
        _labelMapAddress = [[UILabel alloc]init];
        _labelMapAddress.font = [UIFont systemFontOfSize:14.f];
        _labelMapAddress.textColor = [UIColor blackColor];
        _labelMapAddress.backgroundColor = [UIColor clearColor];
        _labelMapAddress.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _labelMapAddress;
}


-(UIImageView *)arrow{
    if(!_arrow){
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon-arrow-right"]];
        _arrow.backgroundColor = [UIColor clearColor];
        _arrow.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _arrow;
}

-(UITextField *)txtMapNumber{
    if(!_txtMapNumber){
        _txtMapNumber = [[UITextField alloc]init];
        _txtMapNumber.backgroundColor = theme_default_color;
        _txtMapNumber.borderStyle = UITextBorderStyleNone;
        _txtMapNumber.leftView = [self leftView:[NSString stringWithFormat:@"    %@",Localized(@"Address_detail")]];
        _txtMapNumber.leftViewMode =UITextFieldViewModeAlways;
        _txtMapNumber.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtMapNumber.placeholder = @"";
        _txtMapNumber.font = [UIFont systemFontOfSize:14.f];
        _txtMapNumber.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtMapNumber;
}

-(UITextField *)txtZipcode{
    if(!_txtZipcode){
        _txtZipcode = [[UITextField alloc]init];
        _txtZipcode.backgroundColor = theme_default_color;
        _txtZipcode.borderStyle = UITextBorderStyleNone;
        _txtZipcode.leftView = [self leftView:[NSString stringWithFormat:@"    %@",Localized(@"Zipcode_txt")]];
        _txtZipcode.leftViewMode = UITextFieldViewModeAlways;
        _txtZipcode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtZipcode.placeholder = Localized(@"Zipcode_txt");
        _txtZipcode.font = [UIFont systemFontOfSize:14.f];
        _txtZipcode.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtZipcode;
}

-(UITextField *)txtUserName{
    if(!_txtUserName){
        _txtUserName = [[UITextField alloc]init];
        _txtUserName .backgroundColor = theme_default_color;
        _txtUserName.borderStyle = UITextBorderStyleNone;
        _txtUserName.leftView = [self leftView:[NSString stringWithFormat:@"    %@",Localized(@"Receiver_txt")]];
        _txtUserName.leftViewMode =UITextFieldViewModeAlways;
        _txtUserName.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtUserName.placeholder = Localized(@"Name_txt");
        _txtUserName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtUserName;
}

-(UITextField *)txtPhone{
    if(!_txtPhone){
        _txtPhone = [[UITextField alloc]init];
        _txtPhone.backgroundColor = theme_default_color;
        _txtPhone.borderStyle = UITextBorderStyleNone;
        _txtPhone.leftView = [self leftView:[NSString stringWithFormat:@"    %@",Localized(@"Mobile_num")]];
        _txtPhone.leftViewMode =UITextFieldViewModeAlways;
        _txtPhone.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtPhone.placeholder = Localized(@"Mobile_num");
        _txtPhone.keyboardType = UIKeyboardTypeNumberPad;
        _txtPhone.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtPhone;
}

-(UIButton *)btnConfirm{
    if(!_btnConfirm){
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.backgroundColor =theme_navigation_color;
        [_btnConfirm setTitleColor:theme_default_color forState:UIControlStateNormal];
        [_btnConfirm setTitle:Localized(@"Save_txt") forState:UIControlStateNormal];
        _btnConfirm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_btnConfirm addTarget:self action:@selector(btnConfirmTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _btnConfirm;
}

-(UILabel*)leftView:(NSString*)title{
    UILabel* leftView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40.f)];
    leftView.textColor = theme_Fourm_color;
    leftView.font = [UIFont systemFontOfSize:14.f];
    leftView.text = title;
    return leftView;
}

@end
