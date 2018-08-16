//
//  Store.m
//  KYRR
//
//  Created by kyjun on 16/3/23.
//
//

#import "Store.h"
#import "VerticallyAlignedLabel.h"
#import "StoreGoodsController.h"
#import "StoreCommentController.h"
#import "StoreInfoController.h"
#import "TQStarRatingView.h"
#import "WXApi.h"

@interface Store ()<UMSocialUIDelegate>
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIView* storeView;
@property(nonatomic,strong) UIImageView* storeLogo;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UILabel* labelStoreName;
@property(nonatomic,strong) UILabel* labelShip;
@property(nonatomic,strong) UIImageView* iconHorn;
@property(nonatomic,strong) UILabel* labelNotice;
@property(nonatomic,strong) NSLayoutConstraint* activeConstraint;
@property(nonatomic,strong) UIView* activeView;
@property(nonatomic,strong) UILabel* labelIcon;
@property(nonatomic,strong) UILabel* labelActive;
@property(nonatomic,strong) UIView* menuView;
@property(nonatomic,strong) UIButton* btnMenu;
@property(nonatomic,strong) UIButton* btnComment;
@property(nonatomic,strong) UIButton* btnStore;
@property(nonatomic,strong) UILabel* labelSymbol;
@property(nonatomic,strong) NSLayoutConstraint* scrollConstraint;
@property(nonatomic,strong) UIScrollView* mainScroll;
@property(nonatomic,strong) UIView* goodsView;
@property(nonatomic,strong) StoreGoodsController* goodsController;
@property(nonatomic,strong) UIView* commentView;
@property(nonatomic,strong) UIView* storeInfoView;
@property(nonatomic,strong) StoreInfoController* storeInfoCotroller;

@property(nonatomic,strong) UIView* noticeView;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UILabel* labelScore;
@property(nonatomic,strong) TQStarRatingView* starService;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIImageView* line;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIImageView* iconStar;
@property(nonatomic,strong) VerticallyAlignedLabel* labelNotices;
@property(nonatomic,strong) NSMutableArray* arrayStar;
@property(nonatomic,strong) UIButton* btnClose;

@property(nonatomic,strong) MStore* entity;
@property(nonatomic,strong) MGoods* gEntity;

@property(nonatomic,strong) UILabel* labelNavTitle;
@property(nonatomic,strong) UIBarButtonItem* leftBarItem;

@end

@implementation Store
-(instancetype)initWithItem:(MStore *)item{
    self = [super init];
    if(self){
        _entity = item;
    }
    return self;
}
-(instancetype)initWithItem:(MStore *)item goods:(MGoods *)goods{
    self = [super init];
    if(self){
        _entity = item;
        _gEntity = goods;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"lALO0RuFbcy-zQKA_640_190.png_620x10000q90g.jpg"];
    UIImageView *bgView = [[UIImageView alloc]initWithImage:image];
    bgView.userInteractionEnabled = YES;
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 135);
    [self.view addSubview:bgView];
    
       // self.navigationItem.titleView =self.labelNavTitle;
    [self layoutUI];
    [self queryData];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *imageView = [self.navigationController.navigationBar viewWithTag:111];
    imageView.alpha = 0.0f;
    [self.navigationItem setHidesBackButton:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImageView *imageView = [self.navigationController.navigationBar viewWithTag:111];
    imageView.alpha = 1.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.navigationController.view addSubview:self.noticeView];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.storeView];
    [self.storeView addSubview:self.storeLogo];
    [self.storeView addSubview:self.rightView];
    //[self.rightView addSubview:self.labelStoreName];
    [self.rightView addSubview:self.labelShip];
    [self.rightView addSubview:self.iconHorn];
    [self.rightView addSubview:self.labelNotice];
    [self.topView addSubview:self.activeView];
    [self.activeView addSubview:self.labelIcon];
    [self.activeView addSubview:self.labelActive];
    [self.view addSubview:self.menuView];
    [self.menuView addSubview:self.btnMenu];
    [self.menuView addSubview:self.btnComment];
    [self.menuView addSubview:self.btnStore];
    [self.menuView addSubview:self.labelSymbol];
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:self.goodsView];
    [self.mainScroll addSubview:self.commentView];
    [self.mainScroll addSubview:self.storeInfoView];
    
    NSArray* formats = @[@"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[activeView]-defEdge-|",@"H:|-defEdge-[menuView]-defEdge-|", @"H:|-defEdge-[mainScroll]-defEdge-|",
                         @"V:|-defEdge-[topView(==topHeight)][activeView][menuView(==menuHeight)][mainScroll]-defEdge-|",
                         @"H:|-defEdge-[storeView]-defEdge-|",@"V:|-64-[storeView(==storeHeight)]-defEdge-|",
                         @"H:|-leftEdge-[storeLogo(==logoSize)]-leftEdge-[rightView]-defEdge-|", @"V:|-defEdge-[storeLogo(==logoSize)]-topEdge-|", @"V:|-defEdge-[rightView]-topEdge-|",
                         @"H:|-defEdge-[labelShip]-defEdge-|",@"H:|-defEdge-[iconHorn(==hornSize)]-leftEdge-[labelNotice]-defEdge-|",
                         @"V:|-topEdge-[labelShip(==shipHeight)][iconHorn(==hornSize)]-topEdge-|", @"V:|-topEdge-[labelShip][labelNotice(==hornSize)]-topEdge-|",
                         @"H:|-leftEdge-[labelIcon(==30)]-leftEdge-[labelActive]-defEdge-|", @"V:|-defEdge-[labelIcon]-defEdge-|", @"V:|-defEdge-[labelActive]-defEdge-|",
                         @"H:|-defEdge-[btnMenu][btnComment(btnMenu)][btnStore(btnMenu)]-defEdge-|", @"V:|-defEdge-[btnMenu]-defEdge-|", @"V:|-defEdge-[btnComment]-defEdge-|", @"V:|-defEdge-[btnStore]-defEdge-|",
                         @"H:|-defEdge-[labelSymbol(==symbolWidth)]", @"V:[labelSymbol(==3)]-defEdge-|",
                         @"H:|-defEdge-[goodsView(==defWidth)][commentView(goodsView)][storeInfoView(goodsView)]-defEdge-|", @"V:|-defEdge-[goodsView]-defEdge-|", @"V:|-defEdge-[commentView]-defEdge-|", @"V:|-defEdge-[storeInfoView]-defEdge-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"topHeight":@(64+70), @"logoSize":@(60), @"storeHeight":@(70),
                               @"storeNameHeight":@(30), @"shipHeight":@(20), @"hornSize":@(15), @"symbolWidth":@(SCREEN_WIDTH/3),
                               @"defWidth":@(SCREEN_WIDTH),@"menuHeight":@(40)};
    NSDictionary* views = @{ @"topView":self.topView, @"menuView":self.menuView, @"mainScroll":self.mainScroll,
                             @"storeView":self.storeView, @"activeView":self.activeView,
                             @"storeLogo":self.storeLogo, @"rightView":self.rightView,
                             @"labelShip":self.labelShip, @"iconHorn":self.iconHorn, @"labelNotice":self.labelNotice,
                             @"labelIcon":self.labelIcon, @"labelActive":self.labelActive,
                             @"btnMenu":self.btnMenu, @"btnComment":self.btnComment, @"btnStore":self.btnStore,
                             @"labelSymbol":self.labelSymbol,
                             @"goodsView":self.goodsView, @"commentView":self.commentView, @"storeInfoView":self.storeInfoView
                             };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
    self.activeConstraint =[NSLayoutConstraint constraintWithItem:self.activeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f];
    [self.activeView addConstraint:self.activeConstraint];
    
    
    [self.noticeView addSubview:self.labelName];
    [self.noticeView addSubview:self.labelScore];
    [self.noticeView addSubview:self.starService];
    [self.noticeView addSubview:self.labelSale];
    [self.noticeView addSubview:self.line];
    [self.noticeView addSubview:self.labelTitle];
    [self.noticeView addSubview:self.labelNotices];
    [self.noticeView addSubview:self.btnClose];
    
    formats = @[@"H:|-defEdge-[labelName]-defEdge-|",@"H:|-defEdge-[labelScore]-5-[starService(labelScore)]-defEdge-|",@"H:|-defEdge-[labelSale]-defEdge-|",
                @"H:|-leftEdge-[line]-leftEdge-|", @"H:|-defEdge-[labelTitle]-defEdge-|",@"H:|-leftEdge-[labelNotices]-leftEdge-|",
                @"V:|-64-[labelName(==30)]-topEdge-[labelScore(==20)]-topEdge-[labelSale(==20)]-topEdge-[line(==1)]-topEdge-[labelTitle(==30)]-topEdge-[labelNotices(==100)]",
                @"V:[labelName]-15-[starService]-topEdge-[labelSale]",
                @"H:[btnClose(==40)]", @"V:[btnClose(==40)]-40-|"
                ];
    metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10)};
    views = @{ @"labelName":self.labelName, @"labelScore":self.labelScore, @"starService":self.starService, @"labelSale":self.labelSale,
               @"line":self.line, @"labelTitle":self.labelTitle, @"labelNotices":self.labelNotices, @"btnClose":self.btnClose
               };
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.noticeView addConstraints:constraints];
    }];
    
    NSLayoutConstraint* constraint = [NSLayoutConstraint  constraintWithItem:self.btnClose attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.noticeView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.noticeView addConstraint:constraint];
}


#pragma mark =====================================================  DataSource
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_shop_info",@"sid":self.entity.rowID};
    
    NetRepositories* reposistories = [[NetRepositories alloc]init];
    [reposistories searchStore:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            MStore* item = (MStore*)obj;
            self.entity.shipFee =item.shipFee;
            self.entity.notice =item.notice;
            self.entity.phone =item.phone;
            self.entity.mobile =item.mobile;
            self.entity.storeName =item.storeName;
            self.entity.servicTimeBegin =item.servicTimeBegin;
            self.entity.serviceTimerEnd = item.serviceTimerEnd;
            self.entity.logo =item.logo;
            self.entity.address =item.address;
            self.entity.freeShip =item.freeShip;
            self.entity.send = item.send;
            self.entity.storeScore = item.storeScore;
            self.entity.sale = item.sale;
            self.entity.arrayActive = item.arrayActive;
            
            [self loadData:self.entity];
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
    
}

#pragma mark =====================================================  SEL

-(IBAction)changeOption:(UIButton*)sender{
    if(self.btnMenu == sender){
        self.btnMenu.selected = YES;
        self.btnComment.selected = NO;
        self.btnStore.selected = NO;
    }else if (self.btnComment == sender){
        self.btnMenu.selected = NO;
        self.btnComment.selected = YES;
        self.btnStore.selected = NO;
    }else{
        self.btnMenu.selected = NO;
        self.btnComment.selected = NO;
        self.btnStore.selected = YES;
    }
    [self changeMarkPosition:sender.tag];
}

#pragma mark =====================================================  private method
-(void)changeMarkPosition:(NSInteger)tag{
    [UIView animateWithDuration:0.5 animations:^{
        self.labelSymbol.frame = CGRectMake(SCREEN_WIDTH/3*tag, CGRectGetHeight(self.menuView.frame)-3, SCREEN_WIDTH/3, 3.f);
        CGRect arect =CGRectMake(SCREEN_WIDTH*tag, 0, SCREEN_WIDTH, CGRectGetHeight(self.mainScroll.frame));
        [self.mainScroll scrollRectToVisible:arect animated:YES];
    }];
}

-(void)loadData:(MStore*)item{
      self.goodsController.storeName = item.storeName;
    self.labelNavTitle.text = item.storeName;
    [self.storeLogo sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:kDefStoreLogo]];
    self.labelStoreName.text = item.storeName;
    self.labelShip.text = [NSString stringWithFormat:@"起步价 ￥%@ | 配送费 ￥%@ ",item.freeShip,item.shipFee];
    self.labelNotice.text = item.notice;
    
    self.storeInfoCotroller.entity = item;
    
    self.labelName.text = item.storeName;
    NSString* starTime =[NSString stringWithFormat:@"%ld:00",[item.servicTimeBegin integerValue]/60];
    NSString* endTime =[NSString stringWithFormat:@"%ld:00",[item.serviceTimerEnd integerValue]/60];
    self.labelSale.text =  [NSString stringWithFormat: @"月售单量: %@单 营业时间: %@-%@",item.sale,starTime,endTime];
    self.labelNotices.text = [NSString stringWithFormat: @"☆ %@",item.notice];
    NSInteger star = [item.storeScore integerValue];
    [self.starService setScore:star/5.0f withAnimation:YES];
    BOOL flag = NO;
    for (NSDictionary* sub in item.arrayActive) {
        if([sub objectForKey: @"满"]){
            self.labelIcon.text =  @"减";
            self.labelActive.text = [sub objectForKey: @"满"];
            flag = YES;
        }
        //        if([sub objectForKey: @"首"]){
        //            self.labelIcon.text =  @" 首 ";
        //            self.labelActive.text = [sub objectForKey: @"首"];
        //            flag = YES;
        //        }
    }
    if(flag){
        if(self.activeConstraint){
            [self.activeView removeConstraint:self.activeConstraint];
        }
        self.activeConstraint =[NSLayoutConstraint constraintWithItem:self.activeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f];
        self.activeConstraint.priority = 999;
        [self.activeView addConstraint:self.activeConstraint];
        
        self.scrollConstraint =[NSLayoutConstraint constraintWithItem:self.goodsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(SCREEN_HEIGHT-204)];
        self.scrollConstraint.priority = 999;
        [self.goodsView addConstraint: self.scrollConstraint];
        
    }else{
        if(self.activeConstraint){
            [self.activeView removeConstraint:self.activeConstraint];
        }
        self.activeConstraint =[NSLayoutConstraint constraintWithItem:self.activeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f];
        self.activeConstraint.priority = 999;
        [self.activeView addConstraint:self.activeConstraint];
        if(self.scrollConstraint){
            [self.goodsView removeConstraint:self.scrollConstraint];
        }
        self.scrollConstraint =[NSLayoutConstraint constraintWithItem:self.goodsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(SCREEN_HEIGHT-174)];
        self.scrollConstraint.priority = 999;
        [self.goodsView addConstraint: self.scrollConstraint];
        
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
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/Mobile/Shop/index?sid=%@",self.entity.rowID];
    if (platformName==UMShareToWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.logo]]];
        
    }
    else if (platformName==UMShareToWechatSession)
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.logo]]];
    }
    else if (platformName==UMShareToQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.logo]]];
    }
    else if (platformName==UMShareToQzone)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.logo]]];
        
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
    
    [UMSocialData defaultData].extConfig.title = self.entity.storeName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.storeName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
}


-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)tapStoreTouch:(id)sender{
    [UIView animateWithDuration:0.7 animations:^{
        self.noticeView.alpha = 0.8;
        [self.view bringSubviewToFront:self.noticeView];
    }];
    
}

-(IBAction)closeTouch:(id)sender{
    [UIView animateWithDuration:0.7 animations:^{
        self.noticeView.alpha = 0.0;
        [self.view bringSubviewToFront:self.noticeView];
    }];
}

#pragma mark =====================================================  property packge
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIView *)storeView{
    if(!_storeView){
        _storeView = [[UIView alloc]init];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapStoreTouch:)];
        [_storeView addGestureRecognizer:tap];
        _storeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _storeView;
}


-(UIImageView *)storeLogo{
    if(!_storeLogo){
        _storeLogo = [[UIImageView alloc]init];
        _storeLogo.layer.cornerRadius = 30.f;
        _storeLogo.layer.masksToBounds = YES;
        _storeLogo.layer.borderColor = [UIColor colorWithRed:220/255.f green:160/255.f blue:148/255.f alpha:1.0].CGColor;
        _storeLogo.layer.borderWidth = 2.f;
        _storeLogo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _storeLogo;
}

-(UIView *)rightView{
    if(!_rightView){
        _rightView = [[UIView alloc]init];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}

-(UILabel *)labelStoreName{
    if(!_labelStoreName){
        _labelStoreName = [[UILabel alloc]init];
        _labelStoreName.textColor = [UIColor whiteColor];
        _labelStoreName.font = [UIFont systemFontOfSize:16.f];
        _labelStoreName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStoreName;
}

-(UILabel *)labelShip{
    if(!_labelShip){
        _labelShip = [[ UILabel alloc]init];
        _labelShip.textColor = [UIColor whiteColor];
        _labelShip.font = [UIFont systemFontOfSize:14.f];
        _labelShip.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShip;
}

-(UIImageView *)iconHorn{
    if(!_iconHorn){
        _iconHorn = [[UIImageView alloc]init];
        [_iconHorn setImage:[UIImage imageNamed:@"icon-horn"]];
        _iconHorn.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconHorn;
}

-(UILabel *)labelNotice{
    if(!_labelNotice){
        _labelNotice = [[ UILabel alloc]init];
        _labelNotice.textColor = [UIColor whiteColor];
        _labelNotice.font = [UIFont systemFontOfSize:14.f];
        _labelNotice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelNotice;
}

-(UILabel *)labelIcon{
    if(!_labelIcon){
        _labelIcon = [[UILabel alloc]init];
        _labelIcon.backgroundColor = theme_Color(255, 0, 255);
        _labelIcon.font = [UIFont systemFontOfSize:14.f];
        _labelIcon.textColor = [UIColor whiteColor];
        _labelIcon.layer.masksToBounds = YES;
        _labelIcon.layer.cornerRadius = 3.f;
        _labelIcon.layer.borderWidth = 5.f;
        _labelIcon.layer.borderColor = theme_navigation_color.CGColor;
        _labelIcon.textAlignment = NSTextAlignmentCenter;
        _labelIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelIcon;
}

-(UILabel *)labelActive{
    if(!_labelActive){
        _labelActive = [[UILabel alloc]init];
        _labelActive.font = [UIFont systemFontOfSize:14.f];
        _labelActive.textColor = [UIColor whiteColor];
        _labelActive.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelActive;
}

-(UIView *)activeView{
    if(!_activeView){
        _activeView = [[UIView alloc]init];
        _activeView.backgroundColor = theme_navigation_color;
        _activeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _activeView;
}

-(UIView *)menuView{
    if(!_menuView){
        _menuView = [[UIView alloc]init];
        _menuView.backgroundColor = theme_table_bg_color;
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 39, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_menuView.layer addSublayer:border];
        _menuView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _menuView;
}


-(UIButton *)btnMenu{
    if(!_btnMenu){
        _btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMenu.tag = 0;
        [_btnMenu setTitleColor:[UIColor colorWithRed:48/255.f green:48/255.f blue:48/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnMenu setTitle:@"商品" forState:UIControlStateNormal];
        [_btnMenu addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventTouchUpInside];
        _btnMenu.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnMenu;
}

-(UIButton *)btnComment{
    if(!_btnComment){
        _btnComment =[UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.tag = 1;
        [_btnComment setTitleColor:[UIColor colorWithRed:48/255.f green:48/255.f blue:48/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnComment setTitle:@"评论" forState:UIControlStateNormal];
        [_btnComment addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventTouchUpInside];
        _btnComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnComment;
}

-(UIButton *)btnStore{
    if(!_btnStore){
        _btnStore = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStore.tag =2;
        [_btnStore setTitleColor:[UIColor colorWithRed:48/255.f green:48/255.f blue:48/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnStore setTitle:@"商家" forState:UIControlStateNormal];
        [_btnStore addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventTouchUpInside];
        _btnStore.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnStore;
}

-(UILabel *)labelSymbol{
    if(!_labelSymbol){
        _labelSymbol = [[UILabel alloc]init];
        _labelSymbol.backgroundColor = theme_navigation_color;
        _labelSymbol.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSymbol;
}

-(UIScrollView *)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.bounces = YES;
        _mainScroll.pagingEnabled = YES;
        _mainScroll.userInteractionEnabled = YES;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.backgroundColor= theme_table_bg_color;
        _mainScroll.scrollEnabled=NO;
        _mainScroll.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainScroll;
}

-(UIView *)goodsView{
    if(!_goodsView) {
        if(self.gEntity){
            _goodsController = [[StoreGoodsController alloc]initWithStoreID:self.entity.rowID goodsID:self.gEntity.rowID];
        }else{
            _goodsController = [[StoreGoodsController alloc]initWithStoreID:self.entity.rowID];
        }
        [self addChildViewController:_goodsController];
        _goodsView = _goodsController.view;
        _goodsView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _goodsView;
}

-(UIView *)commentView{
    if(!_commentView){
        StoreCommentController* controller = [[StoreCommentController alloc]initWithStoreID:self.entity.rowID];
        [self addChildViewController:controller];
        _commentView = controller.view;
        _commentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _commentView;
}

-(UIView *)storeInfoView{
    if(!_storeInfoView){
        StoreInfoController* controller = [[StoreInfoController alloc]init];
        _storeInfoCotroller = controller;
        [self addChildViewController:controller];
        _storeInfoView = controller.view;
        _storeInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _storeInfoView;
}


-(UIView *)noticeView{
    if(!_noticeView){
        _noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noticeView.backgroundColor = [UIColor blackColor];
        _noticeView.alpha = 0.0f;
    }
    return _noticeView;
}

-(UILabel *)labelName{
    if(!_labelName){
        _labelName = [[UILabel alloc]init];
        _labelName.textColor = [UIColor whiteColor];
        _labelName.textAlignment = NSTextAlignmentCenter;
        _labelName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelName;
}

-(UILabel *)labelScore{
    if(!_labelScore){
        _labelScore = [[UILabel alloc]init];
        _labelScore.text =  @"店铺评分: ";
        _labelScore.textColor = [UIColor whiteColor];
        _labelScore.textAlignment = NSTextAlignmentRight;
        _labelScore.font = [UIFont systemFontOfSize:12.f];
        _labelScore.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelScore;
}


-(TQStarRatingView *)starService{
    if(!_starService){
        _starService = [[TQStarRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 10) numberOfStar:5];
        _starService.userInteractionEnabled = NO;
        _starService.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _starService;
}

-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.textColor = [UIColor whiteColor];
        _labelSale.textAlignment = NSTextAlignmentCenter;
        _labelSale.font = [UIFont systemFontOfSize:10.f];
        _labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSale;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc ]init];
        [_line setImage:[UIImage imageNamed: @"line-near-store"]];
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.text =  @"店铺公告";
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UIImageView *)iconStar{
    if(!_iconStar){
        _iconStar = [[UIImageView alloc]init];
        [_iconStar setImage:[UIImage imageNamed: @""]];
        _iconStar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconStar;
}

-(UILabel *)labelNotices{
    if(!_labelNotices){
        _labelNotices = [[VerticallyAlignedLabel alloc]init];
        _labelNotices.textColor = [UIColor whiteColor];
        _labelNotices.font = [UIFont systemFontOfSize:14.f];
        _labelNotices.numberOfLines = 0;
        _labelNotices.verticalAlignment = VerticalAlignmentTop;
        _labelNotices.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelNotices;
}

-(UIButton *)btnClose{
    if(!_btnClose){
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setImage:[UIImage imageNamed: @"icon-close-white"] forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(closeTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnClose.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnClose;
}

-(UILabel *)labelNavTitle{
    if(!_labelNavTitle){
    _labelNavTitle = [[UILabel alloc]init];
        _labelNavTitle.frame = CGRectMake(-110, 0, SCREEN_WIDTH, 40);
    _labelNavTitle.font = [UIFont systemFontOfSize:15.f];
    _labelNavTitle.textColor = [UIColor whiteColor];
    }
    return _labelNavTitle;
}

-(UIBarButtonItem *)leftBarItem{
    if(!_leftBarItem){
        UIButton* btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(-200, 0, 200, 40);
        [btn setImage:[UIImage imageNamed: @"icon-back-white"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:self.entity.storeName forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        _leftBarItem =  [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    }
    return _leftBarItem;
}

-(NSMutableArray *)arrayStar{
    if(!_arrayStar){
        _arrayStar = [[NSMutableArray alloc]init];
    }
    return _arrayStar;
}
@end
