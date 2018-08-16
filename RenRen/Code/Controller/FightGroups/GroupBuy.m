//
//  GroupBuy.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "GroupBuy.h"
#import "GroupBuyHeader.h"
#import "GroupBuyFooter.h"
#import "GroupBuyCell.h"
#import "GroupBuyItemCell.h"
#import "OrderConfirm.h"
#import "PintuangouVC.h"
#import "WXApi.h"



@interface GroupBuy ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UMSocialUIDelegate>

@property(nonatomic,strong) UICollectionView* collectionView;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIButton* btnMore;
@property(nonatomic,strong) UIButton* btnJoin;

@property(nonatomic,strong) NSString* rowID;
@property(nonatomic,strong) MFightGroupInfo* entity;

@property(nonatomic,strong)  UIView* shawView;
@property(nonatomic,strong) UILabel* labelShare;

@end

@implementation GroupBuy

static NSString * const reuseIdentifier = @"GroupBuyCell";
static NSString * const reuseIdentifierItem = @"GroupBuyItemCell";
static NSString * const reuseIdentifierHeader = @"GroupBuyHeader";
static NSString * const reuseIdentifierFooter = @"GroupBuyFooter";


-(instancetype)initWithRowID:(NSString *)rowID{
    self = [super init];
    if(self){
        _rowID = rowID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
    [self layoutContraints];
    [self queryData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PintuangouVCuccess:) name:NotificationPintuangouVCuccess object:nil ];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"拼团购";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[GroupBuyCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[GroupBuyItemCell class] forCellWithReuseIdentifier:reuseIdentifierItem];
    [self.collectionView registerClass:[GroupBuyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    [self.collectionView registerClass:[GroupBuyFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.btnMore];
    [self.bottomView addSubview:self.btnJoin];
    
    [self.view addSubview:self.shawView];
    [self.shawView addSubview:self.labelShare];
}

-(void)layoutContraints{
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnMore.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnJoin.translatesAutoresizingMaskIntoConstraints = NO;
    self.shawView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelShare.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnMore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMore attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMore attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f ]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMore attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMore attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f ]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnMore attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.shawView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.shawView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.shawView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.shawView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    
    [self.labelShare addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShare attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.labelShare addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShare attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShare attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.shawView attribute:NSLayoutAttributeTop multiplier:1.0 constant:100.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShare attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.shawView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchPintuangouVC:@{@"ince":@"tuaninfo",@"tuanid":self.rowID} complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MFightGroupInfo*)obj;
            if(self.showShare && [self.entity.tuanItem.lastNum integerValue]>0){
                [self shareTouch:nil];
            }else if(self.showShare && [self.entity.tuanItem.lastNum integerValue] == 0){
                [self alertHUD: @"拼团成功!"];
            }
            if([self.entity.fightGroup.goodsStock integerValue] == 0){
                self.btnJoin.userInteractionEnabled = NO;
                [self.btnJoin setTitle: @"没货啦" forState:UIControlStateNormal];
                self.btnJoin.backgroundColor = [UIColor grayColor];
            }
            if(self.entity.arrayCustomer.count > 0){
                MCustomer* customer = [self.entity.arrayCustomer firstObject];
                if(customer){
                    if([self.Identity.userInfo.userID isEqualToString:customer.userID]){
                        [self.btnJoin setTitle: @"邀人参团" forState:UIControlStateNormal];
                        [self.btnJoin removeTarget:self action:@selector(shareTouch:) forControlEvents:UIControlEventTouchUpInside];
                        [self.btnJoin addTarget:self action:@selector(shareTouch:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }
            
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.showShare = NO;
        [weakSelf queryData];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.entity){
        return 2;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.entity){
        return self.entity.arrayCustomer.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        GroupBuyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.entity = self.entity.arrayCustomer[indexPath.row];
        return cell;
    }else{
        GroupBuyItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierItem forIndexPath:indexPath];
        cell.entity = self.entity.arrayCustomer[indexPath.row];
        return cell;
    }
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return  CGSizeMake(50, 50);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 50.f);
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
            GroupBuyHeader* header = (GroupBuyHeader*)reusableView;
            header.entity = self.entity;
            return reusableView;
        }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
            GroupBuyFooter* footer = (GroupBuyFooter*)reusableView;
            footer.entity = self.entity.tuanItem;
            return reusableView;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(SCREEN_WIDTH,90.f);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section ==0){
        return UIEdgeInsetsMake(1.0f,10.f, 1.f, 10.f);
    }
    return UIEdgeInsetsMake(1.0f, 0.5f, 1.f, 0.5f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(SCREEN_WIDTH, 50.f);
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f; //相邻两个 item 间距
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
    self.shawView.hidden = YES;
}
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    self.shawView.hidden = YES;
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/mobile/Pintuan/tuaninfo?tuanid=%@",self.entity.tuanItem.rowID];
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

#pragma mark =====================================================  private method
-(void)shareFightGroup{
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
    
    [UMSocialData defaultData].extConfig.title =self.entity.fightGroup.goodsName;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.fightGroup.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
}

#pragma mark =====================================================  SEL
-(IBAction)shareTouch:(id)sender{
    self.labelShare.text = [NSString stringWithFormat: @"还差%@人能组团成功\n快邀请更多小伙伴参团吧!",self.entity.tuanItem.lastNum];
    self.shawView.hidden = NO;
    [self shareFightGroup];
}
-(IBAction)moreTouch:(id)sender{
    PintuangouVC* controller = [[PintuangouVC alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)joinTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
        [self showHUD];
        NSDictionary* arg = @{@"ince":@"pintuan_order_sure_ship_fee",@"fid":self.entity.fightGroup.rowID,@"uid":self.Identity.userInfo.userID,@"tuanid":self.entity.tuanItem.rowID};
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
            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
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

#pragma mark =====================================================  Notification
-(void)PintuangouVCuccess:(NSNotification*)notification{
    self.showShare =YES;
    [self queryData];
}

#pragma mark =====================================================  property package
-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor colorWithRed:129/255.f green:129/255.f blue:129/255.f alpha:1.0];
    }
    return _bottomView;
}

-(UIButton *)btnMore{
    if(!_btnMore){
        _btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMore.backgroundColor = [UIColor colorWithRed:78/255.f green:78/255.f blue:78/255.f alpha:1.0];
        [_btnMore setTitle:@"更多拼团" forState:UIControlStateNormal];
        _btnMore.layer.masksToBounds = YES;
        _btnMore.layer.cornerRadius = 5.f;
        [_btnMore addTarget:self action:@selector(moreTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMore;
}

-(UIButton *)btnJoin{
    if(!_btnJoin){
        _btnJoin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnJoin.backgroundColor = [UIColor colorWithRed:215/255.f green:29/255.f blue:30/255.f alpha:1.0];
        [_btnJoin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnJoin setTitle:@"我也要参团" forState:UIControlStateNormal];
        _btnJoin.layer.masksToBounds = YES;
        _btnJoin.layer.cornerRadius = 5.f;
        [_btnJoin addTarget:self action:@selector(joinTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnJoin;
}

-(UIView *)shawView{
    if(!_shawView){
        _shawView = [[UIView alloc]init];
        _shawView.backgroundColor = [UIColor colorWithRed:40/255.f green:40/255.f blue:40/255.f alpha:1.0];
        _shawView.hidden =YES;
        _shawView.alpha = 0.7;
    }
    return _shawView;
}

-(UILabel *)labelShare{
    if(!_labelShare){
        _labelShare = [[UILabel alloc]init];
        _labelShare.textColor = [UIColor whiteColor];
        _labelShare.textAlignment = NSTextAlignmentCenter;
        _labelShare.numberOfLines = 0;
    }
    return _labelShare;
}

@end
