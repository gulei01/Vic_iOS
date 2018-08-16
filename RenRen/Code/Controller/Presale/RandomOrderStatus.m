//
//  RandomOrderStatus.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/21.
//
//

#import "RandomOrderStatus.h"
#import "RandomOrderStatusCell.h"

@interface RandomOrderStatus ()
@property(nonatomic,strong) NSArray* arrayStatus;
@end

@implementation RandomOrderStatus

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithCollectionViewLayout:layout];
    if(self){
        
    }
    return self;
}

-(instancetype)initWithOrderID:(NSArray *)arrayStatus{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithCollectionViewLayout:layout];
    if(self){
        _arrayStatus = arrayStatus;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // Register cell classes
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[RandomOrderStatusCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        self.navigationItem.title =  @"订单状态";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

#pragma mark =====================================================  <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayStatus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RandomOrderStatusCell *cell = (RandomOrderStatusCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(indexPath.row == (self.arrayStatus.count-1)){
        cell.tag = 55;
    }else{
    cell.tag = indexPath.row;
    }
    cell.item = self.arrayStatus[indexPath.row];
    return cell;
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 80);
} 

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1f;
}
@end
