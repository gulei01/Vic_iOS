//
//  PresaleInfo.m
//  KYRR
//
//  Created by kyjun on 16/6/18.
//
//

#import "PresaleInfo.h"
#import "PresaleInfoHeader.h"
#import "PresaleInfoFooter.h"
#import "CustomerCell.h"
#import "WXApi.h"

@interface PresaleInfo ()<UMSocialUIDelegate>
//@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) PresaleInfoHeader* headerController;
@property(nonatomic,strong) PresaleInfoFooter* footerController;
@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* storeID;
@property(nonatomic,copy) NSString* storeName;

@property(nonatomic,strong) MPresale* entity;

@end

@implementation PresaleInfo

-(instancetype)initWithRowID:(NSString *)rowID storeID:(NSString *)storeID storeName:(NSString *)storeName{
    self =[super init];
    if(self){
        _rowID = rowID;
        _storeID = storeID;
        _storeName = storeName;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
    //[self layoutConstraints];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:NULL];
    
    //[[SDImageCache sharedImageCache] clearDisk];
    //[[SDImageCache sharedImageCache] cleanDisk];
    [self refreshDataSoruce];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrderPayStatusNotification:) name:NotificationChangeOrderPayStatus object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.headerController = [[PresaleInfoHeader alloc]init];
    [self addChildViewController:self.headerController];
    self.tableView.tableHeaderView = self.headerController.view;
    
    self.footerController = [[PresaleInfoFooter alloc]init];
    [self addChildViewController:self.footerController];
    self.tableView.tableFooterView = self.footerController.view;
}

-(void)layoutConstraints{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchPresale:@{@"ince":@"get_miaosha_foodinfo",@"fid":self.rowID} complete:^(NSInteger react, id obj, NSString *message){
        [self.arrayData removeAllObjects];
        if(react == 1){
            MPresaleInfo *empty =(MPresaleInfo*)obj;
            self.entity = empty.presale;
            self.entity.storeID = empty.store.rowID;
            self.entity.storeName = empty.store.storeName;
           
           // [self.headerController loadData:self.entity complete:nil];
            [self.headerController loadData:self.entity complete:^(CGSize size) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.headerController.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, size.height+150.f);
                    self.tableView.tableHeaderView = self.headerController.view;
                });

            }];
            
            [empty.arrayCustomer enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
      //  NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else{
        
    }
    
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/mobile/Yushou/foodinfo?id=%@",self.entity.rowID];
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
#pragma mark =====================================================  通知
-(void)changeOrderPayStatusNotification:(NSNotification*)notification{
        self.tabBarController.selectedIndex = 2;
}

#pragma mark =====================================================  property package
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}
/*
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}*/
@end
