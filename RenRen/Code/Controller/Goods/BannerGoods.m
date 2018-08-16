//
//  BannerGoods.m
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import "BannerGoods.h"
#import "Pager.h"
#import "GoodsCell.h"
#import "SpecialGoodsHeader.h"
#import "AppDelegate.h"

@interface BannerGoods ()<UICollectionViewDelegateFlowLayout,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelSum;
@property(nonatomic,strong) UIButton* btnBuy;

/**
 *  购物车图标
 */
@property(nonatomic,strong) UIImageView* photoCar;
/**
 *  商品数量
 */
@property(nonatomic,strong) UILabel* labelNum;

@property(nonatomic,strong) Pager* page;


@end

@implementation BannerGoods


-(instancetype)init{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SpecialGoodsHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpecialGoodsHeader"];
    
    self.bottomView = [[UIView alloc]init];
    
    [self.view addSubview:self.bottomView];
    
    self.labelSum = [[UILabel alloc]init];
    self.labelSum.backgroundColor = [UIColor blackColor];
    self.labelSum.alpha=0.7f;
    self.labelSum.textColor = [UIColor whiteColor];
    self.labelSum.text =@"共￥0.00 元  ";
    self.labelSum.textAlignment = NSTextAlignmentRight;
    self.labelSum.font = [UIFont systemFontOfSize:15.f];
    [self.bottomView addSubview:self.labelSum];
    
    self.btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBuy.backgroundColor = [UIColor darkGrayColor];
    self.btnBuy.alpha = 0.7f;
    [self.btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBuy setTitle:@"差9.00元送货" forState:UIControlStateNormal];
    self.btnBuy.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.bottomView addSubview:self.btnBuy];
    
    self.photoCar = [[UIImageView alloc]init];
    [self.photoCar setImage:[UIImage imageNamed:@"icon-shop-car"]];
    [self.view addSubview:self.photoCar];
    
    self.labelNum = [[UILabel alloc]init];
    self.labelNum.layer.masksToBounds = YES;
    self.labelNum.layer.cornerRadius = 10;
    self.labelNum.backgroundColor = [UIColor redColor];
    self.labelNum.textColor = [UIColor whiteColor];
    self.labelNum.text = @"0";
    self.labelNum.textAlignment = NSTextAlignmentCenter;
    self.labelNum.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:self.labelNum];
}

-(void)layoutConstraints{
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelNum.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSum.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoCar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelSum attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    
    [self.photoCar addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.photoCar addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f+50/2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-45.f]];
    
    
    
}

#pragma mark =====================================================  数据源
-(void)queryData{
    AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary* arg = @{@"ince":@"get_zt_food",@"zoneid":self.Identity.location.circleID,@"ztid":self.bannerID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    [mgr POST:kHost parameters:arg success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [WMHelper outPutJsonString:responseObject];
        if(self.page.pageIndex==1)
            [self.page.arrayData removeAllObjects];
        NSInteger flag = [[responseObject objectForKey:@"status"]integerValue];
        if(flag ==1){
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict]){
                NSArray* emptyArray = [emptyDict objectForKey:@"foods"];
                if(![WMHelper isNULLOrnil:emptyArray])
                    [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        MGoods* item = [[MGoods alloc]initWithItem:obj];
                        [self.page.arrayData addObject:item];
                    }];
            }
        }else {
           // [self alertHUD:[responseObject objectForKey:@"fail"]];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self alertHUD:@"网络异常"];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryAdvertisement:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        
    }];
    
}
-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.page.pageIndex = 1;
                [weakSelf queryData];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.page.pageIndex++;
                [weakSelf queryData];
            }else
                [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  UICollectionView 协议实现
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.page.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell *cell = (GoodsCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    cell.entity = self.page.arrayData[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SpecialGoodsHeader" forIndexPath:indexPath];
            SpecialGoodsHeader* emptyHeader = (SpecialGoodsHeader*)reusableView;
            emptyHeader.photoUrl = self.photoUrl;
            return reusableView;
        }
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-4)/3;
    CGFloat imgHeight = width - 20;
    CGFloat height  = 10+imgHeight+5+40+20+20;
    return CGSizeMake(width, height);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1.0f, 0.5f, 0.f, 0.5f);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 120);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f; //相邻两个 item 间距
}

#pragma mark =====================================================  属性封装
-(Pager *)page{
    if(!_page)
        _page = [[Pager alloc]init];
    return _page;
}

@end
