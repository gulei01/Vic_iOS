//
//  FightGroupItem.m
//  KYRR
//
//  Created by kyjun on 16/6/17.
//
//

#import "FightGroupItem.h"
#import "FightGroupItemHeader.h"
#import "FightGroupItemFooter.h"
#import "TuanCell.h"
#import "GroupBuy.h"
#import "OrderConfirm.h"
#import "WXApi.h"

@interface FightGroupItem ()<UMSocialUIDelegate>//<UITableViewDelegate,UITableViewDataSource,TuanCellDelegate,UMSocialUIDelegate>

@property(nonatomic,copy) NSString* rowID;

@property(nonatomic,strong) FightGroupItemHeader* headerView;
@property(nonatomic,strong) FightGroupItemFooter* footerView;

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelMarktPrice;
@property(nonatomic,strong) UIButton* btnTuanPrice;
@property(nonatomic,strong) MFightGroupInfo* entity;

@property(nonatomic,copy) NSString* cellIdentifier;

@end

@implementation FightGroupItem

-(instancetype)initWithRowID:(NSString *)rowID{
    self = [super init];
    if(self){
        _rowID = rowID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellIdentifier = @"TuanCell";
    [self layoutUI];
    [self layoutConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createTuanNotification:) name:NotificationFightGroupCreateTuanSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuanEndNotification:) name:NotificationFightGroupTuanEnd object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrderPayStatusNotification:) name:NotificationChangeOrderPayStatus object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshDataSource];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"拼团详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    
    self.headerView = [[FightGroupItemHeader alloc]init];
    [self addChildViewController:self.headerView];
    self.tableView.tableHeaderView = self.headerView.view;
    self.footerView = [[FightGroupItemFooter alloc]init];
    [self addChildViewController:self.footerView];
    self.footerView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 500+SCREEN_WIDTH);
    self.tableView.tableFooterView = self.footerView.view;
    
    self.tableView.backgroundColor =[ UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelMarktPrice];
    [self.bottomView addSubview:self.btnTuanPrice];
}

-(void)layoutConstraints{
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelMarktPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnTuanPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelMarktPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.btnTuanPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchPintuangouVC:@{@"ince":@"get_pintuan_foodinfo",@"fid":self.rowID} complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MFightGroupInfo*)obj;
            if(self.entity.arrayTuan.count>0){
                self.headerView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 285+SCREEN_WIDTH+self.entity.arrayTuan.count*50);
                self.tableView.tableHeaderView = self.headerView.view;
            }else{
                self.headerView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 285+SCREEN_WIDTH);
                self.tableView.tableHeaderView = self.headerView.view;
            }
            [self.footerView loadData:self.entity.fightGroup array:self.entity.arrayCustomer complete:^(CGSize size) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.footerView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30+self.entity.arrayCustomer.count*40+size.height);
                    self.tableView.tableFooterView = self.footerView.view;
                    self.footerView.contentView.scrollEnabled = NO;
                    self.footerView.contentView.showsVerticalScrollIndicator = NO;
                });
            }];
            
             [self.headerView loadData:self.entity complete:nil];
            NSAttributedString* attributeStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@\n单独购买",self.entity.fightGroup.marketPrice]];
            [self.labelMarktPrice setAttributedText:attributeStr];
            if([self.entity.fightGroup.goodsStock integerValue]>0){
                attributeStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@\n%@人团,我也要开团",self.entity.fightGroup.tuanPrice,self.entity.fightGroup.pingNum]];
                [self.btnTuanPrice setAttributedTitle:attributeStr forState:UIControlStateNormal];
                self.btnTuanPrice.backgroundColor = [UIColor redColor];
                self.btnTuanPrice.userInteractionEnabled = YES;
            }else{
                attributeStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@\n没货啦",self.entity.fightGroup.tuanPrice]];
                self.btnTuanPrice.backgroundColor = [UIColor grayColor];
                [self.btnTuanPrice setAttributedTitle:attributeStr forState:UIControlStateNormal];
                self.btnTuanPrice.userInteractionEnabled = NO;
            }
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <TuanCellDelegate>
-(void)tuanEndNotification:(NSNotification*)notification{
    MTuan* tuan = (MTuan*)[notification object];
    if(tuan){
        [self.entity.arrayTuan removeObject:tuan];
        if(self.entity.arrayTuan.count>0){
            self.headerView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 285+SCREEN_WIDTH+self.entity.arrayTuan.count*50);
            self.tableView.tableHeaderView = self.headerView.view;
        }else{
            self.headerView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 285+SCREEN_WIDTH);
            self.tableView.tableHeaderView = self.headerView.view;
        }
        [self.headerView loadData:self.entity complete:nil];
    }
}

#pragma mark =====================================================  <UMSocialUIDelegate>
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
       // NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else{
        
    }
    
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/Mobile/Pintuan/foodinfo?id=%@",self.entity.fightGroup.rowID];
    if (platformName==UMShareToWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
        
    }
    else if (platformName==UMShareToWechatSession)
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
    }
    else if (platformName==UMShareToQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
    }
    else if (platformName==UMShareToQzone)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
        
    }else if (platformName==UMShareToEmail){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }else if (platformName == UMShareToSms){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }
    
}
#pragma mark =====================================================  SEL
-(IBAction)shareTouch:(id)sender{
    NSArray* arrayShare = nil;
    if(![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToEmail,UMShareToSms];
    }else  if (![WXApi isWXAppInstalled] && [QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms];
    }else if ([WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms];
    }else{
        arrayShare = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms];
    }
    [UMSocialData defaultData].extConfig.title = self.entity.fightGroup.goodsName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.fightGroup.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
    
}

#pragma mark =====================================================  Notification
-(void)createTuanNotification:(NSNotification*)notification{
    NSString* tuanID = [notification object];
    GroupBuy *controller = [[GroupBuy alloc]initWithRowID:tuanID];
    controller.showShare = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)changeOrderPayStatusNotification:(NSNotification*)notification{
    self.tabBarController.selectedIndex = 2;
}

#pragma mark =====================================================  SEL
-(IBAction)openTuanCheckTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
        [self showHUD];
        NSDictionary* arg = @{@"ince":@"pintuan_order_sure_ship_fee",@"fid":self.entity.fightGroup.rowID,@"uid":self.Identity.userInfo.userID,@"tuanid":@""};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories netConfirm:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                MCheckOrder* empty = [[MCheckOrder alloc]initWithFightGroup:obj];
                [self hidHUD:@"" complete:^{
                    OrderConfirm* controller = [[OrderConfirm alloc]initWithItem:empty];
                    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
                    [nav.navigationBar setBackgroundColor:theme_navigation_color];
                    [nav.navigationBar setBarTintColor:theme_navigation_color];
                    [nav.navigationBar setTintColor:theme_default_color];
                    [self presentViewController:nav animated:YES completion:nil];
                }];
            }else{
                [self hidHUD:message complete:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark =====================================================  property package
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = theme_default_color;
    }
    return _bottomView;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //_tableView.delegate = self;
        // _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TuanCell class] forCellReuseIdentifier:self.cellIdentifier];
    }
    return _tableView;
}

-(UILabel *)labelMarktPrice{
    if(!_labelMarktPrice){
        _labelMarktPrice = [[UILabel alloc]init];
        _labelMarktPrice.backgroundColor = [UIColor colorWithRed:63/255.f green:38/255.f blue:41/255.f alpha:1.0];
        _labelMarktPrice.textColor = [UIColor whiteColor];
        _labelMarktPrice.textAlignment = NSTextAlignmentCenter;
        _labelMarktPrice.numberOfLines = 0;
        _labelMarktPrice.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelMarktPrice;
}

-(UIButton *)btnTuanPrice{
    if(!_btnTuanPrice){
        _btnTuanPrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTuanPrice.backgroundColor = [UIColor redColor];
        [_btnTuanPrice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnTuanPrice.titleLabel.numberOfLines = 0;
        _btnTuanPrice.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnTuanPrice.titleLabel.textColor = [UIColor whiteColor];
        [_btnTuanPrice addTarget:self action:@selector(openTuanCheckTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTuanPrice;
}
@end
