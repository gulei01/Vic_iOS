//
//  MyTuanInfo.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/29.
//
//

#import "MyTuanInfo.h"
#import "GroupBuyCell.h"
#import "GroupBuyItemCell.h"
#import "GroupBuyFooter.h"
#import "MyTuanInfoHeader.h"
#import "MyTuanInfoFooter.h"
#import "OrderInfo.h"
#import "WXApi.h"
#import <SVWebViewController/SVWebViewController.h>

@interface MyTuanInfo ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UMSocialUIDelegate,MyTuanInfoFooterDelegate>

@property(nonatomic,strong) UICollectionView* collectionView;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIButton* btnJoin;

@property(nonatomic,strong) NSString* rowID;
@property(nonatomic,copy) NSString* orderID;
@property(nonatomic,copy) NSString* tuanStatus;
@property(nonatomic,strong) MFightGroupInfo* entity;

@end

@implementation MyTuanInfo

static NSString * const reuseIdentifier = @"GroupBuyCell";
static NSString * const reuseIdentifierItem = @"GroupBuyItemCell";
static NSString * const reuseIdentifierHeader = @"MyTuanInfoHeader";
static NSString * const reuseIdentifierFooter = @"GroupBuyFooter";
static NSString * const reuseIdentifierTuanInfoFooter = @"MyTuanInfoFooter";




-(instancetype)initWithRowID:(NSString *)rowID orderID:(NSString *)orderID tuanStatus:(NSString *)tuanStatus{
    self = [super init];
    if(self){
        _rowID = rowID;
        _orderID = orderID;
        _tuanStatus = tuanStatus;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self layoutContraints];
    [self queryData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"拼团购";
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
    [self.collectionView registerClass:[MyTuanInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    [self.collectionView registerClass:[GroupBuyFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
      [self.collectionView registerClass:[MyTuanInfoFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierTuanInfoFooter];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.btnJoin]; 
}

-(void)layoutContraints{
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnJoin.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f ]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnJoin attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    
    
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchPintuangouVC:@{@"ince":@"own_tuaninfo",@"tuanid":self.rowID} complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MFightGroupInfo*)obj;
            self.entity.tuanItem.tuanStatus = self.tuanStatus;
            NSInteger status = [self.entity.tuanItem.tuanStatus integerValue];
        
            if( status == 1){
                [self.btnJoin setTitle: @"查看订单" forState:UIControlStateNormal];
            }else if ( status == 0){
                [self.btnJoin setTitle: @"邀人参团" forState:UIControlStateNormal];
            }else{
                self.bottomView.hidden = YES;
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
                [self.collectionView updateConstraints];
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
    return nil;
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
            MyTuanInfoHeader* header = (MyTuanInfoHeader*)reusableView;
            header.entity = self.entity;
            return reusableView;
        }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
            GroupBuyFooter* footer = (GroupBuyFooter*)reusableView;
            footer.entity = self.entity.tuanItem;
            return reusableView;
        }
    }else if (indexPath.section == 1){
        if([kind isEqualToString:UICollectionElementKindSectionFooter]){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifierTuanInfoFooter forIndexPath:indexPath];
            MyTuanInfoFooter* footer = (MyTuanInfoFooter*)reusableView;
           footer.delegate = self;
            return reusableView;
        }

    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(SCREEN_WIDTH,SCREEN_WIDTH+100);
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
    }else if (section == 1){
        return CGSizeMake(SCREEN_WIDTH, 90.f);
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f; //相邻两个 item 间距
}

#pragma mark =====================================================  <MyTuanInfoFooterDelegate>
-(void)tuanInfoRule:(id)sender{
    NSURL *URL = [NSURL URLWithString:self.entity.tuanInfoUrl];
    SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:controller animated:YES];
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
    [UMSocialData defaultData].extConfig.title = self.entity.fightGroup.goodsName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.fightGroup.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
}

#pragma mark =====================================================  SEL
-(IBAction)joinTouch:(id)sender{
    NSInteger status = [self.entity.tuanItem.tuanStatus integerValue];
    if( status == 1){
        MOrder* order = [[MOrder alloc]init];
        order.rowID = self.orderID;
        order.status =  @"3";
        OrderInfo* controller = [[OrderInfo alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.orderID = order.rowID;
        controller.entity = order;
        [self.navigationController pushViewController:controller animated:YES];
    }else if ( status == 0){
        [self shareFightGroup];
    }
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


@end
