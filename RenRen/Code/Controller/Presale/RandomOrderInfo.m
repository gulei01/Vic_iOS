//
//  RandomOrderInfo.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import "RandomOrderInfo.h"
#import "RandomOrderInfoHeader.h"
#import "RandomOrderInfoFooter.h"
#import "RandomBuy.h"
#import "RandomOrderStatus.h"
#import "RandomOrderPay.h"

@interface RandomOrderInfo ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property(nonatomic,strong) NSString* orderID;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) NSDictionary* dictData;

@end

static NSString* const headerIdentifier =  @"RandomOrderInfoHeader";
static NSString* const footerIdentifier =  @"RandomOrderInfoFooter";

@implementation RandomOrderInfo

-(instancetype)initWithOrderID:(NSString *)orderID{
    self = [super init];
    if(self){
        _orderID = orderID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.collectionView];
    
    for (NSString* format in @[@"H:|-defEdge-[collectionView]-defEdge-|", @"V:|-defEdge-[collectionView]-defEdge-|"]) {
        //NSLog( @"%@ %@",[self class], format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:@{ @"defEdge":@(0)} views:@{ @"collectionView":self.collectionView}];
        [self.view addConstraints:constraints];
    }
    [self queryData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderInfoNotification:) name:NotificationRandomPayFinishRefreshOrder object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"订单详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"客服" style:UIBarButtonItemStylePlain target:self action:@selector(callService:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    NSDictionary* arg = @{ @"ince": @"get_order_info", @"uid":self.Identity.userInfo.userID, @"order_id":self.orderID};
    [repositories randomNetConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            self.dictData = [response objectForKey: @"data"];
            [self.collectionView reloadData];
        }else{
            [self alertHUD:message];
        }
    }];
}

#pragma mark ===================================================== <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.dictData)
        return 1;
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RandomOrderInfoHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        header.item = self.dictData;
        [header.btnStatus addTarget:self action:@selector(btnStatusTouch:) forControlEvents:UIControlEventTouchUpInside];
        [header.btnHome addTarget:self action:@selector(btnHomeTouch:) forControlEvents:UIControlEventTouchUpInside];
        [header.btnCancel addTarget:self action:@selector(btnCancelTouch:) forControlEvents:UIControlEventTouchUpInside];
        [header.btnPay addTarget:self action:@selector(btnPayTouch:) forControlEvents:UIControlEventTouchUpInside];
        return header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        RandomOrderInfoFooter* footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        footer.item = self.dictData;
        return footer;
    }
    return nil;
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSInteger status   = [[self.dictData  objectForKey: @"status"]integerValue];
    if(status == 1){
        return CGSizeMake(SCREEN_WIDTH, 425);
    }else{
        return  CGSizeMake(SCREEN_WIDTH, 385);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_WIDTH, 230);
}
#pragma mark =====================================================  <UIAlertViewDelegate>
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        if(alertView.tag == 66){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",alertView.message]]];
        }else{
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories randomNetConfirm:@{ @"ince": @"change_user_order_status", @"uid":self.Identity.userInfo.userID, @"order_id":[self.dictData objectForKey: @"order_id"], @"status": @"-1"} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    [self queryData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRandomRefreshOrder object:nil];
                }else{
                    [self alertHUD:message];
                }
            }]; 
        }
    }
}

#pragma mark =====================================================  SEL
-(IBAction)btnStatusTouch:(id)sender{
    RandomOrderStatus* controller = [[RandomOrderStatus alloc]initWithOrderID:[self.dictData objectForKey: @"status_list"]];
    [self.navigationController pushViewController:controller animated:YES];
}
-(IBAction)btnHomeTouch:(id)sender{
    RandomBuy* controller = [[RandomBuy alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)callService:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打电话？" message: @"0530-6777780" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 66;
    [alert show];
}

-(IBAction)btnCancelTouch:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消订单？" message:  @"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 55;
    [alert show];
   }
-(IBAction)btnPayTouch:(id)sender{
    NSString* orderID = [self.dictData objectForKey: @"order_id"];
    NSString* goodsName = [self.dictData objectForKey: @"title"];
    CGFloat money = [[self.dictData objectForKey: @"total_fee"] floatValue];
    RandomOrderPay* controller = [[RandomOrderPay alloc]initWithOrderID: orderID money:money goodsName:goodsName fromOrder:YES];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [nav.navigationBar setBackgroundColor:theme_navigation_color];
    [nav.navigationBar setBarTintColor:theme_navigation_color];
    [nav.navigationBar setTintColor:theme_default_color];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark =====================================================  notification
-(void)refreshOrderInfoNotification:(NSNotification*)notification{
    [self queryData];
}

#pragma mark =====================================================  property package
-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout* block = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:block];
       // _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[RandomOrderInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: headerIdentifier];
        [_collectionView registerClass:[RandomOrderInfoFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}


@end
