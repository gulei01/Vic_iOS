//
//  NewHome.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import "NewHome.h"
#import "NewHomeHeader.h"
#import "NewHomeFooter.h"
#import "NewHomeSection.h"
#import "NewHomeSection2.h"
#import "NewHomeSectionFooter.h"
#import "NewHomeCell.h"
#import "MapLocation.h"
#import "Store.h"
#import "BuyNow.h"
#import "RandomBuy.h"
#import "PintuangouVC.h"
#import "StoreList.h"
#import "WineList.h"
#import "FruitList.h"
#import "GoodsList.h"
#import "SpecialGoods.h"
#import "SearchGoods.h"
#import "SupermarketAndFruit.h"
#import "Empty2Controller.h"
//记号
@interface NewHome ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NewHomeDelegate,UITextFieldDelegate> 
@property(nonatomic,strong) AMapLocationManager* locationManager;
@property(nonatomic,strong) UIView* titleView;
@property(nonatomic,strong) NSLayoutConstraint* searchConstraint;
@property(nonatomic,strong) UITextField* txtSearch;
@property(nonatomic,strong) UIButton* btnTitle;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIImageView* arrow;
@property(nonatomic,strong) UIButton* btnSearch;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* emptyDataView;

/**
 网络异常提示
 */
@property(nonatomic,strong) UIView* netException;

@property(nonatomic,strong) NSArray* arrayCategory;
@property(nonatomic,strong) NSArray* arrayBanner;
@property(nonatomic,strong) NSArray* arrayTopic;
@property(nonatomic,strong) NSDictionary* dictNotice;
@property(nonatomic,strong) NSDictionary* dictMiaoSha;
@property(nonatomic,strong) NSDictionary* dictManJian;
@property(nonatomic,strong) NSDictionary* dictTuan;
@property(nonatomic,strong) NSMutableArray* arrayStore;
@property(nonatomic,strong) MLcation* mapLocation;
@property(nonatomic,strong) UIView* currentNavigationBarBackgroundView;
@property(nonatomic,strong) UIButton* btnLeft;
@property(nonatomic,strong) UIBarButtonItem* leftBarItem;

@property(nonatomic,strong) UIButton *changeCity;

@end


static NSString* const reuseHeaderIdentifier =  @"NewHomeHeader";
static NSString* const reuseFooterIdentifier =  @"NewHomeFooter";
static NSString* const reuseSectionIdentifier =  @"NewHomeSection";
static NSString* const reuseSection2Identifier =  @"NewHomeSection2";
static NSString* const reuseSectionFooterIdentifier =  @"NewHomeSectionFooter";

@implementation NewHome{
    CGSize titleSize;
}

-(instancetype)init{
    
    self = [super init];
    if(self){
        //设置分栏按钮样式（选中及未选中） 标题及tag
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab-home-default"]];
        [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-home-enter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self.tabBarItem setTitle:@"首页"];

        self.tabBarItem.tag=0;
    }
    return self;
}


//自己更改3
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    titleSize = CGSizeMake((SCREEN_WIDTH-20), 30);
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = self.titleView;
    
    _changeCity = [[UIButton alloc]initWithFrame:CGRectMake( SCREEN_WIDTH - 100, 0, 80, 30)];
    [_changeCity setTitle:@"切换城市" forState:UIControlStateNormal];
    _changeCity.titleLabel.textColor = [UIColor blackColor];
    _delegate = self;
    [_changeCity addTarget:self action:@selector(changeMyCity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleView addSubview:_changeCity];

    

    [self layoutUI];
    
    [self responseData];
    if(self.Identity.userInfo.isLogin){
        NSUserDefaults* config = [NSUserDefaults standardUserDefaults];
        if([[config objectForKey: kisBindingJPushTag]boolValue]){
            
        }else{
            [config setObject:@(YES) forKey:kisBindingJPushTag];
            [config synchronize];
            [self registerTagsWithAlias:self.Identity.userInfo.userID];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePositionNotification:) name:NotificationMapLocationChangePosition object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseData) name:NotificationGuidanceViewFinished object:nil];
    self.firstLoad = YES;
}

//自己更改4
- (void)changeMyCity {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedLocation)]){
        [self.delegate didSelectedLocation];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.firstLoad){
        [self changeNavigationBarBackgroundColor:theme_navigation_color];
        self.firstLoad = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    if(self.Identity.location.isOpen){
        if(self.arrayCategory){
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat empty = self.collectionView.contentOffset.y/100;
            self.currentNavigationBarBackgroundView.alpha = empty;
        }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.currentNavigationBarBackgroundView.alpha = 1.0;
                self.txtSearch.alpha = 0.f;
                _changeCity.alpha = 1.f;
                self.btnSearch.alpha = 1.0;
                self.btnTitle.alpha = 1.0;
            }];
        }
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.currentNavigationBarBackgroundView.alpha = 1.0;
            self.txtSearch.alpha = 0.f;
            _changeCity.alpha = 1.f;
            self.btnSearch.alpha = 1.0;
            self.btnTitle.alpha = 1.0;
        }];
    }
self.navigationItem.leftBarButtonItem = self.leftBarItem;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeNavigationBarBackgroundColor:(UIColor *)barBackgroundColor{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *subviews =self.navigationController.navigationBar.subviews;
        for (id viewObj in subviews) {
            if (ISIOS10) {
                //iOS10,改变了状态栏的类为_UIBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UIBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                }
            }else{
                //iOS9以及iOS9之前使用的是_UINavigationBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                }
            }
        }
        UIImageView *imageView = [self.navigationController.navigationBar viewWithTag:111];
        if (!imageView) {
            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 64)];
            _currentNavigationBarBackgroundView = imageView;
            imageView.tag = 111;
            [imageView setBackgroundColor:barBackgroundColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController.navigationBar insertSubview:imageView atIndex:0];
            });
        }else{
            [imageView setBackgroundColor:barBackgroundColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController.navigationBar sendSubviewToBack:imageView];
            });
            
        }
        
    }
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.txtSearch];
    
    NSArray* formats = @[
                         @"H:|-defEdge-[collectionView]-defEdge-|", @"V:|-defEdge-[collectionView][bottomView]"
                         ];
    NSDictionary* metrics = @{
                              @"defEdge":@(0)
                              };
    NSDictionary* views = @{
                            @"collectionView":self.collectionView, @"bottomView":self.bottomLayoutGuide
                            };
    
    for (NSString* format in formats) {
        //NSLog( @" %@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
    
    [self.titleView addSubview:self.txtSearch];
    [self.titleView addSubview:self.btnSearch];
    [self.titleView addSubview:self.btnTitle];
    [self.btnTitle addSubview:self.labelTitle];
    [self.btnTitle addSubview:self.arrow];
    
    formats = @[@"H:|-defEdge-[btnSearch(==btnLeftWidth)]", @"V:[btnSearch(==btnLeftHeight)]",
                @"H:[txtSearch]-defEdge-|", @"V:|-defEdge-[txtSearch]-defEdge-|",
                @"H:[btnTitle(<=titleMaxWidth)]", @"V:|-defEdge-[btnTitle]-defEdge-|",
                @"H:|-defEdge-[labelTitle]-2-[arrow(==arrowWidth)]-defEdge-|", @"V:|-defEdge-[labelTitle]-defEdge-|", @"V:|-arrowTopEdge-[arrow]-arrowTopEdge-|"
                ];
   //  CGRectMake(0, 0, SCREEN_WIDTH/4, 41*SCREEN_WIDTH/4/169);
    metrics = @{ @"defEdge":@(0), @"iconSize":@(30), @"arrowWidth":@(14),  @"titleMaxWidth":@(SCREEN_WIDTH/2-20),@"arrowHeight":@(8), @"arrowTopEdge":@((30-8)/2), @"btnLeftWidth":@(SCREEN_WIDTH/4),
                 @"btnLeftHeight":@(41*SCREEN_WIDTH/4/169) };
    views = @{@"btnSearch":self.btnSearch,
              @"txtSearch":self.txtSearch,  @"btnTitle":self.btnTitle, @"labelTitle":self.labelTitle, @"arrow":self.arrow
              };
    for (NSString* format in formats) {
        //NSLog( @" %@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.titleView addConstraints:constraints];
    }
    
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.btnSearch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f];
    [self.titleView addConstraint:constraint];
    
    self.searchConstraint = [NSLayoutConstraint constraintWithItem:self.txtSearch attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:titleSize.width];
    [self.txtSearch addConstraint:self.searchConstraint];
    
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories requestPost:@{ @"long": @"-123.364257", @"lat":@"48.430707"} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react ==1){
            NSDictionary* data = [response objectForKey: @"data"];
            
            self.arrayCategory = [data objectForKey: @"nav"];
            
            NSDictionary* banner = [data objectForKey: @"banner"];
            if([[banner objectForKey: @"status"] integerValue]==1){
                NSArray* empty = [banner objectForKey: @"info"];
                NSMutableArray* emptyMutable = [NSMutableArray new];
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAdv* item = [[MAdv alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [emptyMutable addObject:item];
                }];
                self.arrayBanner = emptyMutable;
            }else{
                self.arrayBanner = nil;
            }
//            饕餮
            NSDictionary* topic = [data objectForKey: @"zt"];
            if([[topic objectForKey: @"status"] integerValue]==1){
                NSArray* empty = [topic objectForKey: @"info"];
                NSMutableArray* emptyMutable = [NSMutableArray new];
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAdv* item = [[MAdv alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [emptyMutable addObject:item];
                }];
                
                self.arrayTopic = nil;
//                NSLog(@"！！！！！！！！！%@！！！！！！！！！！！！！！！",self.Identity.location.circleID);

            }else{
                self.arrayTopic = nil;
            }
            NSDictionary* notice = [data objectForKey: @"msg"];
            if([[notice objectForKey: @"status"] integerValue]==1){
                self.dictNotice = [notice objectForKey: @"info"];
//                NSLog(@"*******我是信息%@******",self.dictNotice);
            }else{
                self.dictNotice = nil;

            }
            
            NSDictionary* miaoSha = [data objectForKey: @"miao"];
            if([[miaoSha objectForKey: @"status"] integerValue]==1){
                self.dictMiaoSha = [miaoSha objectForKey: @"info"];
//                NSLog(@"*******我是秒杀信息%@******",self.dictMiaoSha);

            }else{
                self.dictMiaoSha = nil;
            }
            NSDictionary* manJian = [data objectForKey: @"ttmj"];
            if([[manJian objectForKey: @"status"] integerValue]==1){
                self.dictManJian = [manJian objectForKey: @"info"];
//                NSLog(@"*******我是满减信息%@******",self.dictManJian);

            }else{
                self.dictManJian = nil;
            }
            
            NSDictionary* tuan = [data objectForKey: @"tuan"];
            if([[tuan objectForKey: @"status"] integerValue]==1){
                self.dictTuan = [tuan objectForKey: @"info"];
            }else{
                self.dictTuan = nil;
            }
            
            NSDictionary* best = [data objectForKey: @"best"];
            [self.arrayStore removeAllObjects];
            if([[best objectForKey: @"status"] integerValue]==1){
                NSArray *empty = [best objectForKey: @"info"];
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.arrayStore addObject:obj];
                }];
            }
            self.collectionView.scrollEnabled = YES;
            self.collectionView.backgroundView = nil;
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        }else if(react == 400){
            [self netWifiOrLocationFail];
        }else{
             [self emptyOrZoneNotOpen];
        }
    }];
}
//garfunkel 设置下拉刷新
-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    self.collectionView.mj_header =  header;
    [self.collectionView.mj_header beginRefreshing];
}

//-(void)locationFailOrZoneClose{
//    self.arrayCategory = nil;
//     [self.collectionView.mj_header endRefreshing];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0.3 animations:^{
//            self.currentNavigationBarBackgroundView.alpha = 1.0;
//            self.txtSearch.alpha = 0.f;
//            self.btnSearch.alpha = 1.0;
//            self.btnTitle.alpha = 1.0;
//        }];
//        
//        self.labelTitle.text = self.Identity.location.address;
//        self.collectionView.scrollEnabled = NO;
//        self.collectionView.mj_header = nil;
//        self.collectionView.backgroundView = self.emptyDataView;
//        [self.collectionView reloadData];
//    });
//  
//}

#pragma mark =====================================================  <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.Identity.location.isOpen){
//        NSLog(@"garfunkel________log:%ld",self.arrayStore.count);
//        if(self.arrayCategory){
//        if(self.arrayStore.count>0){
//            return self.arrayStore.count+1;
//        }
//        return 1;
//        }else{
//            return 0;
//        }
        if(self.arrayStore.count > 0){
            return self.arrayStore.count+1;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"garfunkel_log:loadKind:%@",kind);
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
//        设置置顶轮播图和五个商店按钮
        if(indexPath.section == 0){
            UICollectionReusableView* reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
            NewHomeHeader* header = (NewHomeHeader*)reuseView;
            header.delegate = self;
//            数据更新五个按钮
            [header loadDataWithBanner:self.arrayBanner loction: self.Identity.location.address category:self.arrayCategory notice:self.dictNotice];
            return reuseView;
        }else{
            NSDictionary* empty =  self.arrayStore[indexPath.section-1];
            NSString* str = [empty objectForKey: @"full_discount"];
//            设置附近的商铺里面的值
            if([WMHelper isEmptyOrNULLOrnil:str]){
                NSLog(@"garfunkel_log:NewHomeSection2");
                UICollectionReusableView* reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseSection2Identifier forIndexPath:indexPath];
                NewHomeSection2* header = (NewHomeSection2*)reuseView;
                header.delegate = self;
                header.item = self.arrayStore[indexPath.section-1];
                return reuseView;
            }else{
                UICollectionReusableView* reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseSectionIdentifier forIndexPath:indexPath];
                NewHomeSection* header = (NewHomeSection*)reuseView;
                header.delegate = self;
                header.item = self.arrayStore[indexPath.section-1];
                return reuseView;
            }
        }
    }else {
//        设置第二个轮播图和秒杀活动等
        if(indexPath.section == 0){
            UICollectionReusableView* reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
            NewHomeFooter* footer = (NewHomeFooter*)reuseView;
            footer.delegate = self;
            [footer loadDataWithTopic:self.arrayTopic miaoSha:self.dictMiaoSha manJian:self.dictManJian tuan:self.dictTuan];
            return reuseView;
        }
        else{
            UICollectionReusableView* reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseSectionFooterIdentifier forIndexPath:indexPath];
            
            return reuseView;
        }
    }
    
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-20-1)/4, 90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}

//自己更改2 garfunkel collectionView中的元素高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        CGFloat topHeight = SCREEN_WIDTH*7/15;
        CGFloat locateHeight = 0;//10
        CGFloat categoryHeight = 0;//70
        if(self.dictNotice){
            return CGSizeMake(SCREEN_WIDTH, topHeight+locateHeight+categoryHeight+30);
        }else{
            return CGSizeMake(SCREEN_WIDTH, topHeight+locateHeight+categoryHeight);
        }
    }else{
        //NSLog(@"llllllllll---%ld",section);
        NSDictionary* empty = self.arrayStore[section-1];
        NSArray *foods = [empty objectForKey: @"foods"];
        CGFloat height = 100;
        NSString* str = [empty objectForKey: @"full_discount"];
        if(![WMHelper isEmptyOrNULLOrnil:str]){
            height+=25;
        }
        if(foods>0){
            CGFloat emptyHeight = 60;// (SCREEN_WIDTH-20-1)/4;
            emptyHeight = emptyHeight+30;
            /*if(foods.count%4==0){
             height+=emptyHeight*(foods.count/4);
             }else{
             height+=emptyHeight*((foods.count/4)+1);
             }*/
            height+=emptyHeight*1;
        }
        return CGSizeMake(SCREEN_WIDTH, height);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 0){
        if(self.arrayTopic){
            //return CGSizeMake(SCREEN_WIDTH, 260);
            return CGSizeMake(SCREEN_WIDTH, 150);
        }else{
            //return CGSizeMake(SCREEN_WIDTH, 170);
            return CGSizeMake(SCREEN_WIDTH, 60);
        }
    }else{
        return CGSizeMake(SCREEN_WIDTH, 20);
    }
}

#pragma mark =====================================================  <UICollectionViewDelegate>


#pragma mark =====================================================  <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //NSLog( @"%.2f %.2f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    if(scrollView.contentOffset.y<0.00){
        [UIView animateWithDuration:0.3 animations:^{
            self.txtSearch.hidden = YES;
            self.txtSearch.alpha = 1.0;
            _changeCity.alpha = 0;
        }];
    }else if (scrollView.contentOffset.y >= 0.00){
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat empty = scrollView.contentOffset.y/100;
            self.txtSearch.hidden = NO;
            _changeCity.alpha = empty;
            self.btnSearch.alpha = empty;
            self.txtSearch.alpha = 1.0-empty;
            if(empty>0.4){
                self.btnTitle.alpha = empty;
                _changeCity.alpha = empty;

            }else{
                self.btnTitle.alpha = 0.f;
                _changeCity.alpha = 0.f;
            }
            self.currentNavigationBarBackgroundView.alpha = empty;
            if(self.searchConstraint)
                [ self.txtSearch removeConstraint:self.searchConstraint];
            CGFloat width = titleSize.width*(1.0-empty);
            self.searchConstraint = [NSLayoutConstraint constraintWithItem:self.txtSearch attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width>titleSize.width?titleSize.width:width];
            self.searchConstraint.priority = 999;
            [self.txtSearch addConstraint:self.searchConstraint];
        }];
    }
}
#pragma mark =====================================================  <UITextFeildDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([WMHelper isEmptyOrNULLOrnil:textField.text]){
        [textField resignFirstResponder];
        [self alertHUD:@"请输入关键词!"];
        return NO;
    }
   [self currentNavigationBarBackgroundView].alpha = 1.0;
    SearchGoods* controller = [[SearchGoods alloc]initWithKeyword:textField.text];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:NO];
    [self cancelEdit];
    
    return YES;
}
#pragma mark =====================================================  <NewHomeDelegate>
-(void)didSelectedTopicAtIndex:(NSInteger)index imgSize:(CGSize)imgSize{
    [self currentNavigationBarBackgroundView].alpha = 1.0;
    MAdv* item = self.arrayTopic[index];
    CGSize headerSize = CGSizeMake(SCREEN_WIDTH, imgSize.height/imgSize.width*SCREEN_WIDTH);
    SpecialGoods* controller = [[SpecialGoods alloc]initWithItem:item headerSize:headerSize];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

-(void)didSelectedBannerAtIndex:(NSInteger)index{
    [self currentNavigationBarBackgroundView].alpha = 1.0;
    MAdv* item = self.arrayBanner[index];
    NSURL *URL = [NSURL URLWithString:item.bannerUrl];
    SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}
-(void)didSelectedLocation{
    MapLocation* controller = [[MapLocation alloc]init];
    //Empty2Controller* controller = [[Empty2Controller alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
    [self currentNavigationBarBackgroundView].alpha = 1.0;
}
//设置五个按钮的跳转
-(void)didSelectedCategory:(NSInteger)index{

    NSInteger categoryID,isSelf;
    categoryID = 0;
    isSelf = 0;
    switch (index) {
        case 0://美食
        {
            categoryID = 3;
            StoreList* controller = [[StoreList alloc]initWithCategory:categoryID];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1://超市
        {
           
            categoryID = 1;
            SupermarketAndFruit* controller = [[SupermarketAndFruit alloc]initWithCategory:categoryID];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2://鲜果
        {
            
            categoryID = 2;
            SupermarketAndFruit* controller = [[SupermarketAndFruit alloc] initWithCategory:categoryID];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3://鲜花
        {
            
            categoryID = 4;
            StoreList* controller = [[StoreList alloc]initWithCategory:categoryID];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        case 4://跑腿
        {
//            categoryID =25;
//            WineList* controller = [[WineList alloc]initWithCategoryID:categoryID];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            
            if(self.Identity.location.mapLat && self.Identity.location.mapLng){
                if(self.Identity.userInfo.isLogin){
                    categoryID =62;
                    RandomBuy* controller = [[RandomBuy alloc]init];
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }else{
                    
                    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
                    [nav.navigationBar setBackgroundColor:theme_navigation_color];
                    [nav.navigationBar setBarTintColor:theme_navigation_color];
                    [nav.navigationBar setTintColor:theme_default_color];
                    [self presentViewController:nav animated:YES completion:nil];
                    
                }
                
            }else{
                [self selectLocation:nil];
            }
            
        }
            break;
        default:
            break;
    }
 
    [self cancelEdit];
    [self currentNavigationBarBackgroundView].alpha = 1.0;
}

-(void)didSelectedMiaoSha{
    BuyNow* conroller = [[BuyNow alloc]init];
    conroller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conroller animated:YES];
    [self cancelEdit];
    [self currentNavigationBarBackgroundView].alpha = 1.0;
}

-(void)didSelectedManJian{
    if(self.dictManJian){
        NSURL *URL = [NSURL URLWithString:[self.dictManJian objectForKey: @"href"]];
        SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        [self cancelEdit];
        [self currentNavigationBarBackgroundView].alpha = 1.0;
    }
}

-(void)didSelectedTuan{
    PintuangouVC* controller = [[PintuangouVC alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
    [self currentNavigationBarBackgroundView].alpha = 1.0;
}

-(void)didSelectedStore:(id)sender{
    MStore* item = [[MStore alloc]init];
    [item setValuesForKeysWithDictionary:sender];
 
    Store* controller = [[Store alloc]initWithItem:item];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

-(void)didSelectedGoods:(id)store goods:(id)goods{
    MStore* sItem = [[MStore alloc]init];
    [sItem setValuesForKeysWithDictionary:store];
    MGoods* gItem = [[MGoods alloc]init];
    [gItem setValuesForKeysWithDictionary:goods];
    Store* controller = [[Store alloc]initWithItem:sItem goods:gItem];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

#pragma mark =====================================================  SEL
-(IBAction)btnSearchTouch:(id)sender{
    
}

-(void)selectLocation:(UIButton*)sender{
    self.firstLoad = YES;
    MapLocation* controller = [[MapLocation alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

-(void)cancelEdit{
    self.txtSearch.text =  @"";
    [self.view endEditing:YES];
}
-(void)changePositionNotification:(NSNotification*)notification{
    if(self.Identity.location.isOpen){
        self.labelTitle.text = self.Identity.location.address;
        [self refreshDataSource];
    }else{
        [self emptyOrZoneNotOpen];
    }
}

#pragma mark =====================================================  绑定极光推送

-(void)registerTagsWithAlias:(NSString*)userID{
    
    __autoreleasing NSMutableSet *tags = [NSMutableSet set];
    __autoreleasing NSString *alias = userID;
    [self analyseInput:&alias tags:&tags];
    
    [JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
       // NSLog(@"TagsAlias回调:\n iResCode:%d  iAlias:%@",iResCode,iAlias);
        if(iResCode == 0){
            
        }else{
            /* UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:@"消息推送注册失败,请退出后再登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alert show];*/
        }
    }];
}

- (void)setTags:(NSMutableSet **)tags addTag:(NSString *)tag {
    [*tags addObject:tag];
}

- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    // alias analyse
    if (![*alias length]) {
        // ignore alias
        *alias = nil;
    }
    // tags analyse
    if (![*tags count]) {
        *tags = nil;
    } else {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
            if ([tag isEqualToString:@""]) {
                emptyStringCount++;
            } else {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count]) {
            *tags = nil;
        }
    }
}
#pragma mark =====================================================  private method
-(void)responseData{
    NSLog( @"%s",__FUNCTION__);
    
    [self hidHUD];
      [self showHUD];
    if(self.Identity.location){
        self.labelTitle.text = self.Identity.location.address;
//        NSLog(@"garfunkel_log:%@",self.Identity.location.isOpen);
        if(self.Identity.location.isOpen){
            [self refreshDataSource];
        }else{
            [self emptyOrZoneNotOpen];
        }
    }else{
        NSLog(@"garfunkel_log:%@",@"init address");
        self.labelTitle.text =  @"";
        [self startLocation];
    }
}

-(void)startLocation{
    if ([CLLocationManager locationServicesEnabled]) {
       
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                //NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                NSLog( @"%@",error);
                [self hidHUD];
                [self netWifiOrLocationFail];
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }NSLog( @"%s",__FUNCTION__);
            
            //NSLog(@"location:%@", location);
            
            if (regeocode)
            {
                NSLog(@"reGeocode:%@", regeocode);
                self.mapLocation.address = regeocode.POIName;
                self.mapLocation.cityName = regeocode.city;
                [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",location.coordinate.latitude] lng:[NSString stringWithFormat:@"%.6f",location.coordinate.longitude] addresID:@""];
            }else{
                [self hidHUD];
                [self netWifiOrLocationFail];
                NSLog( @" [self hidHUD];");
            }
        }];
    }else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle: @"定位服务未开启" message: @"请在系统设置中开启定位服务\n设置->隐私->定位服务->外卖郎" delegate:self cancelButtonTitle: @"设置" otherButtonTitles: @"确认",nil];
        [alert show];
        
    }
    
}
-(void)uploadLocationWithLat:(NSString*)lat lng:(NSString*)lng addresID:(NSString*)addressID{
    NSDictionary* arg = @{@"ince":@"select_user_addr",@"lng":lng,@"lat":lat,@"addr":addressID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            self.mapLocation.circleID = [response objectForKey:@"zone_id"];
            self.mapLocation.areaID = [response objectForKey:@"area_id"];
            self.mapLocation.mapLng = lng;
            self.mapLocation.mapLat = lat;
            self.mapLocation.isOpen = YES;
            
            Boolean flag= [NSKeyedArchiver archiveRootObject:self.mapLocation toFile:[WMHelper archiverMapLocationPath]];
            if(flag){
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self alertHUD: @"定位失败请重试!"];
            }
            [self refreshDataSource];
        }else if(react == 400){
            self.mapLocation.isOpen = NO;
            [self hidHUD];
            [self emptyOrZoneNotOpen];
        }else{
            [self hidHUD];
            self.mapLocation.isOpen = NO;
            Boolean flag= [NSKeyedArchiver archiveRootObject:self.mapLocation toFile:[WMHelper archiverMapLocationPath]];
            if(flag){
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                [self alertHUD: @"定位失败请重试!"];
            }
            [self emptyOrZoneNotOpen];
        }        
    }];
}

-(void)netWifiOrLocationFail{
    [self hidHUD];
    self.arrayCategory = nil;
   [self.collectionView.mj_header endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.currentNavigationBarBackgroundView.alpha = 1.0;
            self.txtSearch.alpha = 0.f;
            _changeCity.alpha = 1.0f;
            self.btnSearch.alpha = 1.0;
            self.btnTitle.alpha = 1.0;
        }];
        if(self.Identity.location){
           self.labelTitle.text = self.Identity.location.address;
        }else{
            self.labelTitle.text = @"无网络,请重试";
        }
        self.collectionView.scrollEnabled = NO;
        self.collectionView.mj_header = nil;
        self.collectionView.backgroundView = self.netException;
        [self.collectionView reloadData];
    });

}
-(void)emptyOrZoneNotOpen{
    [self hidHUD];
    self.arrayCategory = nil;
    [self.collectionView.mj_header endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.currentNavigationBarBackgroundView.alpha = 1.0;
            self.txtSearch.alpha = 0.f;
            _changeCity.alpha = 1.0;
            self.btnSearch.alpha = 1.0;
            self.btnTitle.alpha = 1.0;
        }];
        
        self.labelTitle.text = self.Identity.location.address;
        self.collectionView.scrollEnabled = NO;
        self.collectionView.mj_header = nil;
        self.collectionView.backgroundView = self.emptyDataView;
        [self.collectionView reloadData];
    });

}

#pragma mark =====================================================  <UIAlertViewDelegate>{
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        // UIApplicationOpenSettingsURLString
        NSURL *url = [NSURL URLWithString: @"prefs:root=LOCATION_SERVICES"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark =====================================================  property package

-(AMapLocationManager *)locationManager{
    if(!_locationManager){
        _locationManager = [[AMapLocationManager alloc] init];
        //   定位超时时间，最低2s，此处设置为10s
        _locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为10s
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}

-(UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    }
    return _titleView;
}

-(UITextField *)txtSearch{
    if(!_txtSearch){
        _txtSearch = [[UITextField alloc]init];
        _txtSearch.layer.masksToBounds = YES;
        _txtSearch.layer.cornerRadius = 15.f;
        _txtSearch.borderStyle = UITextBorderStyleNone;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setImage:[UIImage imageNamed: @"icon-search"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        _txtSearch.leftView = btn;
        _txtSearch.delegate = self;
        _txtSearch.returnKeyType=UIReturnKeySearch;
        _txtSearch.placeholder = @"搜索附近的商品";
        _txtSearch.font = [UIFont systemFontOfSize:14.f];
        _txtSearch.backgroundColor =[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
       // [_txtSearch setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _txtSearch.leftViewMode =UITextFieldViewModeAlways;
        _txtSearch.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtSearch;
}

-(UIButton *)btnTitle{
    if(!_btnTitle){
        _btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTitle.alpha = 0.f;
        [_btnTitle addTarget:self action:@selector(selectLocation:) forControlEvents:UIControlEventTouchUpInside];
        _btnTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnTitle;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UIImageView *)arrow{
    if(!_arrow){
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon-arrow-bottom"]];
        _arrow.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _arrow;
}

-(UIButton *)btnSearch{
    if(!_btnSearch){
//        首页图片
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSearch setImage:[UIImage imageNamed: @"icon-logo"] forState:UIControlStateNormal];
       _btnSearch.alpha = 0.1;
        
        _btnSearch.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        _btnSearch.userInteractionEnabled = NO;
//        [_btnSearch addTarget:self action:@selector(btnSearchTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnSearch;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1.0];
        [_collectionView registerClass:[NewHomeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
        [_collectionView registerClass:[NewHomeFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier];
        [_collectionView registerClass:[NewHomeSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseSectionIdentifier];
        [_collectionView registerClass:[NewHomeSection2 class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseSection2Identifier];
        [_collectionView registerClass:[NewHomeSectionFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseSectionFooterIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}


-(UIView *)emptyDataView{
    if(!_emptyDataView){
        _emptyDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImageView* icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon-not-stores"]];
        icon.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*10/13);
        icon.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        icon.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshDataSource)];
        [icon addGestureRecognizer:tap];
        [_emptyDataView addSubview:icon];
    }
    return _emptyDataView;
}

-(UIView *)netException{
    if(!_netException){
        _netException = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _netException.backgroundColor = [UIColor whiteColor];
        UIImageView* icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"net-exception-wifi"]];
        icon.frame = CGRectMake(0, 0, 86, 64);
        icon.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-80);
        icon.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshDataSource)];
        [icon addGestureRecognizer:tap];
        [_netException addSubview:icon];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame)+20, SCREEN_WIDTH, 50)];
        label.text =  @"未能连接到互联网\n或未开启定位服务";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        [_netException addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake((SCREEN_WIDTH-80)/2, CGRectGetMaxY(label.frame)+20, 80, 36);
        btn.backgroundColor = theme_navigation_color;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle: @"刷新重试" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 13.f;
        [btn addTarget:self action:@selector(responseData) forControlEvents:UIControlEventTouchUpInside];
        [_netException addSubview:btn];
    }
    return _netException;
}


-(NSMutableArray *)arrayStore{
    if(_arrayStore == nil ){
        _arrayStore = [[NSMutableArray alloc]init];
    }
    return _arrayStore;
}


-(MLcation *)mapLocation{
    if(!_mapLocation){
        MLcation* empty = self.Identity.location;
        if(empty){
            _mapLocation = empty;
        }else{
            _mapLocation = [[MLcation alloc]init];
        }
    }
    return _mapLocation;
}


@end

