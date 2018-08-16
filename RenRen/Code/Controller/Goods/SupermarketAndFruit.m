//
//  SupermarketAndFruit.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/26.
//
//

#import "SupermarketAndFruit.h"
#import "StoreListCell.h"
#import "StoreListFooter.h"
#import "emptyHeader.h"
#import "FruitList.h"
#import "GoodsList.h"

@interface SupermarketAndFruit ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView* collecctionView;
@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,assign) NSInteger categoryID;

@end

static NSString* const cellIdentifier =  @"StoreListCell";
static NSString* const footerIdentifier =  @"StoreListFooter";
static NSString* const headerIdentifier =  @"emptyHeader";

@implementation SupermarketAndFruit

-(instancetype)initWithCategory:(NSInteger)categoryID{
    self = [super init];
    if(self){
        _categoryID = categoryID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutUI];
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"超市水果";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.collecctionView];
    NSArray* formats = @[@"H:|-defEdge-[collectionView]-defEdge-|", @"V:|-defEdge-[collectionView]-defEdge-|"];
    NSDictionary*metrics = @{ @"defEdge":@(0)};
    NSDictionary* views = @{ @"collectionView":self.collecctionView};
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @" %@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositroies = [[NetRepositories alloc]init];
    [repositroies requestPost:@{ @"ince": @"get_shop_by_cate", @"zoneid":self.Identity.location.circleID,@"shopcategory":[WMHelper integerConvertToString:self.categoryID]} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react ==1){
            
            NSArray* emptyArray = [response objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MStore* item = [[MStore alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [self.arrayData addObject:item];
                }];

        }else{
            [self alertHUD:message];
        }
        [self.collecctionView reloadData];
        [self.collecctionView.mj_header endRefreshing];
    }];
    
    
//        NetRepositories* repositroies = [[NetRepositories alloc]init];
//        [repositroies requestPost:@{@"cate":[WMHelper integerConvertToString:self.categoryID]} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
//            if(react ==1){
//    
//                NSLog(@"我的识别号码是：%ld",(long)self.categoryID);
//    
//                NSArray* emptyArray = [response objectForKey:@"info"];
//                if(![WMHelper isNULLOrnil:emptyArray])
//                    [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        MStore* item = [[MStore alloc]init];
//                        [item setValuesForKeysWithDictionary:obj];
//                        [self.arrayData addObject:item];
//                    }];
//    
//            }else{
//                [self alertHUD:message];
//            }
//            [self.collecctionView reloadData];
//            [self.collecctionView.mj_header endRefreshing];
//        }];

}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.collecctionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.arrayData removeAllObjects];
        [weakSelf queryData];
    }];
    [self.collecctionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return self.arrayData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreListCell* cell = (StoreListCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView* footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        return  footer;
    }else{
        UICollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        return  header;
    }
}
#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MStore* empty = self.arrayData[indexPath.row];
    if([empty.categoryID isEqualToString: @"2"]){
        FruitList* controller = [[FruitList alloc]initWithCategoryID:[empty.categoryID integerValue] storeID:empty.rowID];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        GoodsList* controller = [[GoodsList alloc]initWithCategoryID:[empty.categoryID integerValue] storeID:empty.rowID];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MStore* item = self.arrayData[indexPath.row];
    CGFloat height = 105.f+item.arrayActive.count*25+5;
    
    return CGSizeMake(SCREEN_WIDTH, height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 0.1);
}


#pragma mark =====================================================  property packge
-(UICollectionView *)collecctionView{
    if(!_collecctionView){
        _collecctionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collecctionView.dataSource = self;
        _collecctionView.delegate = self;
        [_collecctionView registerClass:[StoreListCell class] forCellWithReuseIdentifier:cellIdentifier];
        [_collecctionView registerClass:[emptyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [_collecctionView registerClass:[StoreListFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
        _collecctionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collecctionView;
}

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
