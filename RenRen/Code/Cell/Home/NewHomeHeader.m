//
//  NewHomeHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import "NewHomeHeader.h"
#import <MarqueeLabel/MarqueeLabel.h>
#import "HomeCategoryCell.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

@interface NewHomeHeader ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) SDCycleScrollView* bannerView;
@property(nonatomic,strong) UIView* locationView;
//@property(nonatomic,strong) UIImageView* imgLocate;
//@property(nonatomic,strong) UIImageView* iconLocate;
//@property(nonatomic,strong) UIButton* btnLocate;
@property(nonatomic,strong) UILabel* labelLocate;
//@property(nonatomic,strong) UIImageView* arrowBottom;
@property(nonatomic,strong) UIView* categoryView;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* noticeView;
@property(nonatomic,strong) MarqueeLabel* marqueeLabel;

@property(nonatomic,strong) NSArray* arrayCategory;
@property(nonatomic,strong) NSArray* arrayBanner;
@end

static NSString* const cellIdentifier =  @"HomeCategoryCell";
@implementation NewHomeHeader{
    NSInteger topHeight,locationHeight , categoryHeight ;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        //[self layoutConstraints];
    }
    return self;
}


#pragma mark =====================================================  user interface layout
//首页第一个轮播图 饕餮 自己更改1
-(void)layoutUI{
    
    topHeight = SCREEN_WIDTH*7/15;
    locationHeight = 0;//10
    categoryHeight = 0;//70
    self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, topHeight) imageURLStringsGroup:nil];
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.bannerView.delegate = self;
    self.bannerView.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.bannerView];
    
    
    [self addSubview:self.locationView];
    
//    [self.locationView addSubview:self.imgLocate];
//    [self.imgLocate addSubview:self.iconLocate];
//    
//    [self.locationView addSubview:self.btnLocate];
//    [self.btnLocate addSubview:self.labelLocate];
//    [self.btnLocate addSubview:self.arrowBottom];
    
    //[self addSubview:self.categoryView];
    [self addSubview:self.collectionView];
    [self addSubview:self.noticeView];
    [self.noticeView addSubview:self.marqueeLabel];
    
    NSArray* formats = @[@"H:|-defEdge-[bannerView]-defEdge-|",@"H:|-defEdge-[locationView]-defEdge-|",@"H:|-leftEdge-[collectionView]-leftEdge-|",@"H:|-defEdge-[noticeView]-defEdge-|",
                         @"V:|-defEdge-[bannerView(==topHeight)][locationView(==locationHeight)][collectionView(==categoryHeight)][noticeView]-defEdge-|",
                         @"H:|-defEdge-[marqueeLabel]-defEdge-|", @"V:|-defEdge-[marqueeLabel]-defEdge-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0),@"leftEdge":@(10), @"topHeight":@(topHeight), @"locationHeight":@(locationHeight),
                               @"categoryHeight":@(categoryHeight),@"arrowTopEdge":@((22-6)/2), @"arrowWidth":@(10), @"locateWidth":@(14), @"locateHeight":@(18)
                               };
    NSDictionary* views = @{  @"bannerView":self.bannerView,@"locationView":self.locationView, @"collectionView":self.collectionView, @"noticeView":self.noticeView,
                              @"marqueeLabel":self.marqueeLabel
                              };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @" %@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    
//    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.imgLocate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.locationView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
//    [self.locationView addConstraint:constraint];
//    constraint = [NSLayoutConstraint constraintWithItem:self.iconLocate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.imgLocate attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
//    [self.imgLocate addConstraint:constraint];
//    constraint = [NSLayoutConstraint constraintWithItem:self.btnLocate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.locationView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
//    [self.locationView addConstraint:constraint];
    
}

#pragma mark =====================================================  <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.arrayCategory){
        return 5;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCategoryCell* cell = (HomeCategoryCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.item = self.arrayCategory[indexPath.row];
    return  cell;
}
#pragma mark =====================================================  <UIcollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCategory:)]){
        [self.delegate didSelectedCategory:indexPath.row];
    }
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-21)/5, 70);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}

#pragma mark =====================================================  <CDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedBannerAtIndex:)]){
        [self.delegate didSelectedBannerAtIndex:index];
    }
}

#pragma mark =====================================================  SEL
////定位按钮
//-(IBAction)locationTouch:(id)sender{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedLocation)]){
//        [self.delegate didSelectedLocation];
//    }
//}

//更新五个按钮的数据
-(void)loadDataWithBanner:(NSArray *)banners loction:(NSString *)location category:(NSArray *)category notice:(NSDictionary *)notice{
    
    _arrayBanner = banners;
    
    NSMutableArray* photos = [[NSMutableArray alloc]init];
    [banners enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [photos addObject:((MAdv*)obj).photoUrl];
    }];
    [self.bannerView clearCache];
    [self.bannerView setImageURLStringsGroup:photos];
    
    self.arrayCategory = category;
    NSLog(@"garfunkel_log:category:%@",self.arrayCategory);
//    self.labelLocate.text = location;
    
    if(notice){
        self.marqueeLabel.backgroundColor = [UIColor colorWithRed:255/255.f green:144/255.f blue:0/255.f alpha:1.0];
        self.marqueeLabel.text =  [notice objectForKey: @"content"];
    }else{
        self.marqueeLabel.backgroundColor = [UIColor whiteColor];
        self.marqueeLabel.text =  @"";
    }
    
//    self.labelLocate.text = [MSingle shareAuhtorization].location.address;
    [self.collectionView reloadData];
}

#pragma mark =====================================================  property package

-(UIView *)locationView{
    if(!_locationView){
        _locationView = [[UIView alloc]init];
        _locationView.backgroundColor = [UIColor whiteColor];
        _locationView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _locationView;
}

//-(UIImageView *)imgLocate{
//    if(!_imgLocate){
//        _imgLocate = [[UIImageView alloc]init];
//        _imgLocate.image = [UIImage imageNamed: @"home_Banner_addressBack"];
//        _imgLocate.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    return _imgLocate;
//}

//-(UIImageView *)iconLocate{
//    if(!_iconLocate){
//        _iconLocate = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon-locate-home"]];
//        _iconLocate.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    return _iconLocate;
//}

//-(UIButton *)btnLocate{
//    if(!_btnLocate){
//        _btnLocate = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btnLocate.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
//        _btnLocate.layer.masksToBounds = YES;
//        _btnLocate.layer.cornerRadius = 11.f;
//        [_btnLocate addTarget:self action:@selector(locationTouch:) forControlEvents:UIControlEventTouchUpInside];
//        _btnLocate.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    return _btnLocate;
//}

//-(UILabel *)labelLocate{
//    if(!_labelLocate){
//        _labelLocate = [[UILabel alloc]init];
//        _labelLocate.font =  [UIFont fontWithName: @"Arial Rounded MT Bold" size:12.f];
//        _labelLocate.textColor = [UIColor colorWithRed:103/255.f green:103/255.f blue:103/255.f alpha:1.0];
//        _labelLocate.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    return _labelLocate;
//}

//-(UIImageView *)arrowBottom{
//    if(!_arrowBottom){
//        _arrowBottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"arrow-bottom-gay"]];
//        _arrowBottom.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    return _arrowBottom;
//}


-(UIView *)categoryView{
    if(!_categoryView){
        _categoryView = [[UIView alloc]init];
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _categoryView;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor colorWithRed:251/255.f green:255/255.f blue:255/255.f alpha:1.0];
        [_collectionView registerClass:[HomeCategoryCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

-(UIView *)noticeView{
    if(!_noticeView){
        _noticeView  = [[UIView alloc]init];
        _noticeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _noticeView;
}

-(MarqueeLabel *)marqueeLabel{
    if(!_marqueeLabel){
        _marqueeLabel = [[MarqueeLabel alloc]init];
        _marqueeLabel.marqueeType = MLContinuous;
        _marqueeLabel.scrollDuration = 20.0f;
        _marqueeLabel.fadeLength = 10.0f;
        _marqueeLabel.trailingBuffer = 30.0f;
        _marqueeLabel.textColor = [UIColor whiteColor];
        _marqueeLabel.font = [UIFont systemFontOfSize:14.f];
        _marqueeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _marqueeLabel;
}

@end
