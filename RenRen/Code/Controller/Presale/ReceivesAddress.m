//
//  ReceivesAddress.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/10.
//
//

#import "ReceivesAddress.h"
#import "ReceivesAddressCell.h"
#import "ReceivesAddressSection.h"
#import "EditAddress.h"

@interface ReceivesAddress ()<RecevicesAddressCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,assign) KYRandomAddressCategory addressCategory;
@end

@implementation ReceivesAddress

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseSection =  @"Section";

-(instancetype)initWithCategory:(KYRandomAddressCategory)category{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithCollectionViewLayout:layout];
    if(self){
        _addressCategory = category;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    [self.collectionView registerClass:[ReceivesAddressCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[ReceivesAddressSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseSection];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"增加" style:UIBarButtonItemStylePlain target:self action:@selector(addAddress:)];
    switch (self.addressCategory) {
        case RandomAddressCategoryTake:{
              self.navigationItem.title =  @"选择取货地址";
        }
            break;
       case RandomAddressCategoryReceive:{
            self.navigationItem.title =  @"选择收货地址";
        }
            break;
       case RandomAddressCategorySend:{
            self.navigationItem.title =  @"选择发货地址";
        }
            break;
            
        default:
            break;
    }
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_user_addr",@"uid":self.Identity.userInfo.userID,@"is_default":@"0"};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryRandomAddress:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayData removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            // [self alertHUD:message];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark ===================================================== <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReceivesAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.item = self.arrayData[indexPath.row];
    cell.delegate = self;
    return cell;
}
/*
 -(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
 if([kind isEqualToString:UICollectionElementKindSectionHeader]){
 ReceivesAddressSection* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseSection forIndexPath:indexPath];
 NSString* key = self.arrayData.allKeys[indexPath.section];
 [header setTitleVal: [key isEqualToString: @"validAddress"]? @"可选收货地址": @"不在服务方位内"];
 return header;
 }
 return nil;
 }
 */
#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
/*
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
 return  CGSizeMake(SCREEN_WIDTH, 60);
 }
 */


#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString: @"暂无可使用收货地址" attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
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
    return -roundf(self.collectionView.frame.size.height/10);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  <UICollectionViewDelgate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MAddress* item = self.arrayData[indexPath.row];
    switch (self.addressCategory) {
        case RandomAddressCategorySend:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSelectedRandomAddressSend object:item];
        }
            break;
        case RandomAddressCategoryReceive:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSelectedRandomAddressReceive object:item];
        }
            break;
        case RandomAddressCategoryTake:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSelectedRandomAddressTake object:item];
        }
            break;
            
        default:
            break;
    }
    [self setDefaultAddress:item];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark =====================================================  <ReceivesAddressCellDelegate>
-(void)editRecevicesAddress:(MAddress *)item{
    EditAddress* controller = [[EditAddress alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  SEL
-(IBAction)addAddress:(id)sender{
    EditAddress * controller = [[EditAddress alloc]initWithItem:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark =====================================================  私有方法
-(void)setDefaultAddress:(MAddress*)item{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            NSDictionary* arg = @{@"ince":@"set_default_map",@"uid":self.Identity.userInfo.userID,@"itemid":item.rowID};
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories updateAddres:arg complete:^(NSInteger react, id obj, NSString *message) {
                if(react == 1){
                    //[self hidHUD:@"操作成功!"];
                    
                }else if(react == 400){
                    //[self hidHUD:message];
                }else{
                    //[self hidHUD:message];
                }
            }];
        }
    }];
    
}


#pragma mark =====================================================  property package
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return  _arrayData;
}
@end
