//
//  BuyNowInfo.m
//  DTCoreText
//
//  Created by kyjun on 16/6/14.
//  Copyright © 2016年 Drobnik.com. All rights reserved.
//

#import "BuyNowInfo.h"
#import "BuyNowItemHeader.h"
#import "BuyNowInfoFooter.h"
#import "CustomerCell.h"
#import "Car.h"
#import "WXApi.h"


@interface BuyNowInfo ()<UMSocialUIDelegate>
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) BuyNowItemHeader* itemHeader;
@property(nonatomic,strong) BuyNowInfoFooter* footerController;
@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* storeID;
@property(nonatomic,copy) NSString* goodsName;
@property(nonatomic,copy) NSString* storeStatus;

@property(nonatomic,strong) MBuyNow* entity;

@property(nonatomic,strong) UIView* carView;

@end

@implementation BuyNowInfo

-(instancetype)initWithItem:(MBuyNow *)item{
    self =[super init];
    if(self){
        _rowID = item.rowID;
        _storeID = item.storeID;
        _storeName = item.storeName;
        _storeStatus = item.storeStatus;
        _goodsName = item.goodsName;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSoruce];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.goodsName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.itemHeader = [[BuyNowItemHeader alloc]init];
    [self addChildViewController: self.itemHeader];
    self.itemHeader.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH+170.f);
    self.tableView.tableHeaderView = self.itemHeader.view;
    
    self.footerController = [[BuyNowInfoFooter alloc]init];
    [self addChildViewController:self.footerController];
    self.footerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.f);
    self.tableView.tableFooterView = self.footerController.view;
    
    [self.view addSubview:self.tableView];
    Car* car = [[Car alloc]init];
    [self addChildViewController:car];
    self.carView = car.view;
    [self.view addSubview:self.carView];
    
}

-(void)layoutConstraints{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.carView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.carView addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.carView addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.carView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchBuyNow:@{@"ince":@"get_miaosha_foodinfo",@"fid":self.rowID} complete:^(NSInteger react, NSArray *list, id model, NSString *message) {
        [self.arrayData removeAllObjects];
        if(react == 1){
            self.entity = (MBuyNow*)model;
            self.entity.storeID = self.storeID;
            self.entity.storeName = self.storeName;
            self.entity.storeStatus = self.storeStatus;
            [self.itemHeader loadData:self.entity complete:^(CGSize size) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.itemHeader.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, size.height+170.f);
                    self.tableView.tableHeaderView = self.itemHeader.view;
                });
            }];
            
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
            
            [self.footerController loadData:self.entity array:self.arrayData  complete:^(CGSize size) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.footerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,  size.height+30+40*self.arrayData.count);
                    self.tableView.tableFooterView = self.footerController.view;
                    self.footerController.contentView.scrollEnabled = NO;
                    self.footerController.contentView.showsVerticalScrollIndicator = NO;
                });
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSoruce{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark =====================================================  <UMSocialUIDelegate>
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        //NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else{
        
    }
    
}


-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/mobile/Miaosha/foodinfo?id=%@",self.entity.rowID];
    if (platformName==UMShareToWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.thumbnails]]];
        
    }
    else if (platformName==UMShareToWechatSession)
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.thumbnails]]];
    }
    else if (platformName==UMShareToQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.thumbnails]]];
    }
    else if (platformName==UMShareToQzone)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.thumbnails]]];
        
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
    [UMSocialData defaultData].extConfig.title = self.entity.goodsName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
}


#pragma mark =====================================================  property package
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
