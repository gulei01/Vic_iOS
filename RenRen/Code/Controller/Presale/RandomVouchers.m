//
//  RandomVouchers.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import "RandomVouchers.h"
#import "RandomVouchersCell.h"

@interface RandomVouchers ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource>

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) NSMutableArray* arrayData;

@end

static NSString* const cellIdentfier =  @"cell";
@implementation RandomVouchers

-(void)viewDidLoad{
    [super viewDidLoad];     
    
    [self.view addSubview:self.collectionView];
    for (NSString* format in @[@"H:|-defEdge-[collectionView]-defEdge-|", @"V:|-defEdge-[collectionView]-defEdge-|"]) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:@{ @"defEdge":@(0)} views:@{ @"collectionView":self.collectionView}];
        [self.view addConstraints:constraints];
    }
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"代金券";
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* respositores = [[NetRepositories alloc]init];
    NSDictionary* arg = @{ @"ince": @"get_user_bonus", @"uid":self.Identity.userInfo.userID};
    [respositores queryRandomVouchers:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayData removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrayData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RandomVouchersCell* cell = (RandomVouchersCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentfier forIndexPath:indexPath];
    cell.item = self.arrayData[indexPath.row];
    return cell;
}


#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return CGSizeMake(SCREEN_WIDTH,80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  0.1f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark =====================================================  <UICollectionViewDeleate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSelectedVouchers object:self.arrayData[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString: @"暂无可使用优惠券" attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString:tipEmptyDataDescription attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return roundf(self.collectionView.frame.size.height/10.0);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  property package

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout* block = [[UICollectionViewFlowLayout alloc]init];
        block.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:block];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[RandomVouchersCell class] forCellWithReuseIdentifier:cellIdentfier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

@end
