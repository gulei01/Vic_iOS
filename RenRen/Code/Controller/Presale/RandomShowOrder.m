//
//  RandomShowOrder.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/20.
//
//

#import "RandomShowOrder.h"
#import "RandomShowOrderCell.h"
#import "RandomShowOrderHeader.h"
#import "HelpBuy.h"

@interface RandomShowOrder ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NSString* users;
@end

@implementation RandomShowOrder

static NSString * const reuseIdentifier = @"Cell";
static NSString * const headerIdentifier = @"header";


-(instancetype)init{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithCollectionViewLayout:layout];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.users =  @"";
    self.collectionView.alwaysBounceVertical = YES;
    // Register cell classes
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    [self.collectionView registerClass:[RandomShowOrderCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[RandomShowOrderHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    // Do any additional setup after loading the view.
    [self queryData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
       self.navigationItem.title =  @"大家都在用";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories randomNetConfirm:@{ @"ince": @"get_all_orderlist"} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            NSArray* data = [response objectForKey: @"data"];
            self.users = [response objectForKey: @"count"];
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else{
            [self alertHUD:message];
        }
        [self.collectionView reloadData];
    }];
}


#pragma mark ===================================================== <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RandomShowOrderCell *cell = (RandomShowOrderCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.item = self.arrayData[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RandomShowOrderHeader* header = (RandomShowOrderHeader*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        [header.btnHeader addTarget:self action:@selector(btnHeaderTouch:) forControlEvents:UIControlEventTouchUpInside];
        [header loadUsers:self.users];
        return header;
    }
    return nil;
}

#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HelpBuy* controller = [[HelpBuy alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  0.1f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 60);
}


#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:tipEmptyDataTitle attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
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


#pragma mark =====================================================  SEL
-(IBAction)btnHeaderTouch:(id)sender{
    HelpBuy* controller = [[HelpBuy alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  property package
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
