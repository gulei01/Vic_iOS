//
//  Shopping.m
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#import "Shopping.h"
#import "MStore.h"
#import "ShoppingCell.h"
//#import "StoreGoods.h"
#import "Goods.h"
#import "MAddress.h"
#import "GenerateOrder.h"
#import "AppDelegate.h"
#import "SelectAddres.h"
#import "Store.h"
#import "BuyNowInfo.h"
#import "FruitInfo.h"


#import "PintuangouVC.h"

@interface Shopping ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,ShopCellDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIButton* lineTop;
@property(nonatomic,strong) UIButton* lineBottom;
@property(nonatomic,strong) UIImageView* lineblock;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UIView* footerView;
@property(nonatomic,strong) UIButton* btnSelectAll;
@property(nonatomic,strong) UILabel* labelSelectAll;
@property(nonatomic,strong) UILabel* labelSum;
@property(nonatomic,strong) UIButton* btnConfrim;

@property(nonatomic,strong) UIImageView* photoLociation;
@property(nonatomic,strong) UIButton* btnAdd;

/**
 *  购物车数据源
 */
@property(nonatomic,strong) NSMutableArray* arrayData;
/**
 *  库存不足的
 */
@property(nonatomic,strong) NSMutableArray* arrayStock;
/**
 *  店铺休息
 */
@property(nonatomic,strong) NSMutableArray* arrayStoreRest;

@property(nonatomic,assign) BOOL allSelect;

@property(nonatomic,strong) MGoods* emptyGoods;

@property(nonatomic,strong) MAddress* defaultAddress;

@property(nonatomic,assign) float payPrice;

@property(nonatomic,strong) UIButton *deleteBtn;

@end

@implementation Shopping
#pragma mark =====================================================  生命周期
-(instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab-shopping-default"]];
        [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-shopping-enter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self.tabBarItem setTitle:@"购物车"];
        self.tabBarItem.tag=1;
    }
    return self;
}

//自己更改全部删除
- (void)viewDidLoad {
    
//   _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, 0, 80, 30)];
//    [_deleteBtn setTitle:@"全部删除" forState:UIControlStateNormal];
//    _deleteBtn.titleLabel.textColor = [UIColor whiteColor];
//
//    [_deleteBtn addTarget:self action:@selector(deleteAllData:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_deleteBtn];
    
    [super viewDidLoad];
    self.title = @"购物车";
    self.allSelect = YES;
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrderPayStatusNotification:) name:NotificationChangeOrderPayStatus object:nil];
    
}

- (void)deleteAllData:(UIButton *)button {

//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要删除购物车里所有的商品？" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        
//        //    NSDictionary* arg = @{@"ince":@"addcart",@"fid":self.emptyGoods.rowID,@"uid":self.Identity.userInfo.userID,@"num":[WMHelper integerConvertToString:10000000]};
//        //
//        //    [self showHUD];
//        //    NetRepositories* repositories = [[NetRepositories alloc]init];
//        //    [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
//        //        if(react == 1){
//        //            [self hidHUD:@"全部删除成功" ];
//        //            // [self.tableView.mj_header beginRefreshing];
//        //            [self queryData];
//        //        }else if(react == 400){
//        //            [self hidHUD:message];
//        //        }else{
//        //            [self hidHUD:message];
//        //        }
//        //    }];
//        NSLog(@"删除成功");
//    }];
//    
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    
//    [alert addAction:action1];
//    [alert addAction:action2];
//    
//    [self presentViewController:alert animated:YES completion:nil];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.arrayStock removeAllObjects];
    [self.arrayStoreRest removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
    [self changeNavigationBarBackgroundColor:theme_navigation_color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = theme_default_color;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90.f);
    
    UIImage *image =[UIImage imageNamed:@"icon-line-address"];
    
    self.lineTop = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lineTop.userInteractionEnabled = NO;
    self.lineTop.backgroundColor = [UIColor colorWithPatternImage:image];
    [self.headerView addSubview:self.lineTop];
    
    self.photoLociation = [[UIImageView alloc]init];
    self.photoLociation.image = [UIImage imageNamed:@"icon-location"];
    [self.headerView addSubview:self.photoLociation];
    
    self.labelUserName = [[UILabel alloc]init];
    self.labelUserName.textColor = theme_Fourm_color;
    self.labelUserName.font = [UIFont systemFontOfSize:14.f];
    [self.headerView addSubview:self.labelUserName];
    
    self.labelAddress = [[UILabel alloc]init];
    self.labelAddress.textColor = theme_Fourm_color;
    self.labelAddress.font = [UIFont systemFontOfSize:14.f];
    self.labelAddress.numberOfLines= 2.f;
    self.labelAddress.lineBreakMode = NSLineBreakByCharWrapping;
    [self.headerView addSubview:self.labelAddress];
    
    self.btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAdd setTitleColor:theme_title_color forState:UIControlStateNormal];
    [self.btnAdd setTitle:@"+添加新地址" forState:UIControlStateNormal];
    self.btnAdd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnAdd.titleLabel.font = [UIFont systemFontOfSize:25.f];
    [self.btnAdd addTarget:self action:@selector(btnAddAddressTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.btnAdd];
    
    self.lineBottom = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lineBottom.userInteractionEnabled = NO;
    self.lineBottom.backgroundColor = [UIColor colorWithPatternImage:image];
    [self.headerView addSubview:self.lineBottom];
    
    self.lineblock = [[UIImageView alloc]init];
    self.lineblock.backgroundColor = theme_line_color;
    [self.headerView addSubview:self.lineblock];
    
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90.f)];
    self.footerView.backgroundColor = theme_default_color;
    self.btnSelectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnSelectAll setImage:[UIImage imageNamed:@"icon-address-default"] forState:UIControlStateNormal];
    [self.btnSelectAll setImage:[UIImage imageNamed:@"icon-address-enter"] forState:UIControlStateSelected];
    self.btnSelectAll.selected = self.allSelect;
    [self.btnSelectAll addTarget:self action:@selector(allSelectedTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.btnSelectAll];
    
    self.labelSelectAll = [[UILabel alloc]init];
    self.labelSelectAll.text = @"选择";
    [self.footerView addSubview:self.labelSelectAll];
    
    self.labelSum = [[UILabel alloc]init];
    [self.footerView addSubview:self.labelSum];
    
    self.btnConfrim = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnConfrim.backgroundColor = [UIColor colorWithRed:229/255.f green:0/255.f blue:71/255.f alpha:1.0];
    [self.btnConfrim setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.btnConfrim setTitle:@"去结算" forState:UIControlStateNormal];
    [self.btnConfrim addTarget:self action:@selector(generateOrderTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.btnConfrim.layer.masksToBounds = YES;
    self.btnConfrim.layer.cornerRadius=5.f;
    [self.footerView addSubview:self.btnConfrim];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
}

-(void)layoutConstraints{
    self.lineTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoLociation.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineBottom.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineblock.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.lineTop addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.lineTop addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.photoLociation addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLociation attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.photoLociation addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLociation attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:14.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLociation attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineTop attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLociation attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineTop attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoLociation attribute:NSLayoutAttributeRight multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.labelUserName attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelUserName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoLociation attribute:NSLayoutAttributeRight multiplier:1.0 constant:20.f]];
    
    
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineTop attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoLociation attribute:NSLayoutAttributeRight multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.lineblock addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
    [self.lineblock addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.lineBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.lineBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.lineblock attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    self.btnSelectAll.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSelectAll.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSum.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnConfrim.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnSelectAll addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelectAll attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnSelectAll addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelectAll attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelectAll attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelectAll attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    
    [self.labelSelectAll addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSelectAll attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.labelSelectAll addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSelectAll attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSelectAll attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnSelectAll attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSelectAll attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    
    [self.labelSum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelSelectAll attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    
    [self.btnConfrim addConstraint:[NSLayoutConstraint constraintWithItem:self.btnConfrim attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.btnConfrim addConstraint:[NSLayoutConstraint constraintWithItem:self.btnConfrim attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnConfrim attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnConfrim attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    
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


#pragma mark =====================================================  数据源/数据请求
-(void)queryData{
    
    @try {
        self.allSelect = YES;
        //NSDictionary* arg = @{@"ince":@"getcart",@"zoneid":self.Identity.location.circleID,@"uid":self.Identity.userInfo.userID};
        NSDictionary* arg = @{@"a":@"getCart",@"uid":self.Identity.userInfo.userID};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories queryShopCar:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
            [self.arrayData removeAllObjects];
            if(react == 1){
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.arrayData addObject:obj];
                }];
                NSInteger emptySum = 0;
                CGFloat emptySumPrice = 0.f;
                //            [self.arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //                MStore* emptyItem = (MStore*)obj;
                //                [emptyItem.arrayGoods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //                    MGoods* subEmpty = (MGoods*)obj;
                //                    subEmpty.shopCarSelected = YES;
                //                }];
                //                if([emptyItem.status integerValue] == 1){
                //                    emptySum+=emptyItem.shopCarGoodsCount;
                //                    emptySumPrice+=emptyItem.shopCarGoodsPrice;
                //                }
                //            }];
                for (MStore* item in self.arrayData) {
                    for (MGoods* subItem in item.arrayGoods) {
                        subItem.shopCarSelected = YES;
                    }
                    if([item.status integerValue] == 1){
                        emptySum+=item.shopCarGoodsCount;
                        emptySumPrice+=item.shopCarGoodsPrice;
                    }
                }
                
                self.payPrice = emptySumPrice;
                NSString* str =[NSString stringWithFormat:@"已选商品数: %ld 总计: %.2f ",emptySum,emptySumPrice];
                NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
                [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, str.length)];
                [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, @"已选商品数:".length)];
                [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:[str rangeOfString:@"总计:"]];
                self.labelSum.attributedText = attributeStr;
                self.btnSelectAll.selected = self.allSelect;
                self.btnConfrim.enabled = YES;
//                自己更改去结算的金额
                if(self.payPrice<[@"9.00" floatValue]){
                    self.btnConfrim.backgroundColor = [UIColor lightGrayColor];
                    self.btnConfrim.enabled = NO;
                    [self.btnConfrim setTitle:[NSString stringWithFormat:@"差%.2f元送货",([@"9.00" floatValue]-self.payPrice)] forState:UIControlStateNormal];
                }else{
                    self.btnConfrim.enabled = YES;
                    self.btnConfrim.backgroundColor = [UIColor redColor];
                    [self.btnConfrim setTitle:@"去结算" forState:UIControlStateNormal];
                    
                }
                self.tableView.tableFooterView = self.footerView;
                //garfunkel modify 加载购物车后加载地址
                [self queryDefaultAddress];
            }else if(react == 400){
                self.tableView.tableFooterView = [[UIView alloc]init];
                [self alertHUD:message];
            }else{
                self.tableView.tableFooterView = [[UIView alloc]init];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    } @catch (NSException *exception) {
        NSLog( @"%@",exception.description);
    } @finally {
        //[self.tableView reloadData];
        //[self.tableView.mj_header endRefreshing];
    }
    
}
-(void)queryDefaultAddress{
    NSDictionary* arg;
    //if (arg == nil) {
        //arg = @{@"ince":@"get_user_addr_ince",@"is_default":@"1",@"uid":self.Identity.userInfo.userID};
        arg = @{@"a":@"getUserDefaultAddress",@"uid":self.Identity.userInfo.userID};
    //}
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchAddres:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.defaultAddress = obj;
            AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            delegate.globalAddress=self.defaultAddress;
            
            self.btnAdd.alpha=0.1;
            [self.btnAdd setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            self.photoLociation.image = [UIImage imageNamed:@"icon-address"];
            self.labelUserName.text = [NSString stringWithFormat:@"收货人:%@ %@",self.defaultAddress.userName,self.defaultAddress.phoneNum];
            self.labelAddress.text = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",[MSingle shareAuhtorization].location.cityName,self.defaultAddress.areaName,self.defaultAddress.zoneName,self.defaultAddress.address];
            
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            self.defaultAddress = nil;
            AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            delegate.globalAddress=self.defaultAddress;
            self.btnAdd.alpha=1;
            [self.btnAdd setTitleColor:theme_title_color forState:UIControlStateNormal];
            self.labelUserName.text= @"";
            self.labelAddress.text = @"";
            // [self alertHUD:message];
        }
    }];
}


-(void)addGoodsWithNum:(NSInteger)num{
    //NSDictionary* arg = @{@"ince":@"addcart",@"fid":self.emptyGoods.rowID,@"uid":self.Identity.userInfo.userID,@"num":[WMHelper integerConvertToString:num]};
    NSDictionary* arg = @{@"a":@"addCart",@"fid":self.emptyGoods.rowID,@"uid":self.Identity.userInfo.userID,@"num":[WMHelper integerConvertToString:num],@"spec":self.emptyGoods.spec,@"proper":self.emptyGoods.proper};
    NSLog(@"garfunkel_log:%@ %@",self.emptyGoods.spec,self.emptyGoods.proper);
    [self showHUD];
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            [self hidHUD:num>0? @"添加成功!":@"操作成功" ];
            // [self.tableView.mj_header beginRefreshing];
            [self queryData];
        }else if(react == 400){
            [self hidHUD:message];
        }else{
            [self hidHUD:message];
        }
    }];
    
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
        //[weakSelf queryDefaultAddress];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MStore* item = self.arrayData[section];
    return item.arrayGoods.count;;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MStore* item = self.arrayData[section];
    UIButton* btnSection = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSection.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.f);
    btnSection.backgroundColor = theme_default_color;
    btnSection.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnSection.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-35);
    btnSection.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [btnSection setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
    [btnSection addTarget:self action:@selector(btnSectionTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnSection setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    // [btnSection setTitle:[NSString stringWithFormat:@"%@ %@-%@",item.storeName,item.servicTimeBegin,item.serviceTimerEnd] forState:UIControlStateNormal];
    [btnSection setTitle:[NSString stringWithFormat:@"%@ ",item.storeName] forState:UIControlStateNormal];
    btnSection.titleLabel.font = [UIFont systemFontOfSize:14.f];
    btnSection.tag = section;
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,1.0f);
    border.backgroundColor = theme_line_color.CGColor;
    [btnSection.layer addSublayer:border];
    border = [CALayer layer];
    border.frame = CGRectMake(0.0f, 39.0f, SCREEN_WIDTH,1.0f);
    border.backgroundColor = theme_line_color.CGColor;
    [btnSection.layer addSublayer:border];
    
    [self.arrayStoreRest enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* empty = (NSDictionary*)obj;
        if([item.rowID integerValue] == [[empty objectForKey:@"sid" ]integerValue]){
            [btnSection setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btnSection setTitle:[NSString stringWithFormat:@"%@     %@",item.storeName,[empty objectForKey: @"message"]] forState:UIControlStateNormal];
        }
    }];
    
    if([item.status integerValue] == 0){
        [btnSection setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btnSection setTitle:[NSString stringWithFormat:@"%@     %@",item.storeName,@"店铺休息中!"] forState:UIControlStateNormal];
        self.btnSelectAll.selected = NO;
    }
    
    
    UIImageView* imgArrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-24.f, (40-8)/2, 8.f, 14.f)];
    [imgArrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    [btnSection addSubview:imgArrow];
    
    return btnSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCell *cell =(ShoppingCell*) [tableView dequeueReusableCellWithIdentifier:@"ShoppingCell"];
    if(!cell)
        cell = [[ShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShoppingCell"];
    cell.delegate = self;
    MStore* item = self.arrayData[indexPath.section];
    //MGoods* entity = item.arrayGoods[indexPath.row];
    
    cell.entity = item.arrayGoods[indexPath.row];
    if([item.status integerValue] == 0){
        cell.entity.shopCarSelected = NO;
    }
    
    cell.storeItem = item;
    cell.labelStock.text = @"";
    [self.arrayStock enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* empty = (NSDictionary*)obj;
        if([cell.entity.rowID isEqualToString:[empty objectForKey:@"fid"]]){
            cell.labelStock.text = [empty objectForKey:@"message"];
        }
    }];
    return cell;
}
/*
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
 MStore* item = self.arrayData[indexPath.section];
 MGoods* empty = item.arrayGoods[indexPath.row];
 if([empty.categroyID isEqualToString: @"71"]){
 MBuyNow* by = [[MBuyNow alloc]init];
 by.rowID = empty.rowID;
 by.storeID = item.rowID;
 by.storeStatus = item.status;
 by.goodsName = empty.goodsName;
 BuyNowInfo* controller = [[BuyNowInfo alloc]initWithItem:by];
 controller.storeName = item.storeName;
 controller.hidesBottomBarWhenPushed = YES;
 [self.navigationController pushViewController:controller animated:YES];
 }else{
 Goods* controller = [[Goods alloc]initWithGoodsID:empty.rowID goodsName:empty.goodsName];
 controller.hidesBottomBarWhenPushed = YES;
 [self.navigationController pushViewController:controller animated:YES];
 }
 }
 */
#pragma mark =====================================================  ShoppingCell 协议实现
-(void)selectedGoods:(MGoods *)item{
    
    item.shopCarSelected = !item.shopCarSelected;
    NSInteger emptySum = 0;
    float emptySumPrice = 0.f;
    self.allSelect = YES;
    for (MStore* item in self.arrayData) {
        for (MGoods* subIitem in item.arrayGoods) {
            if(!subIitem.shopCarSelected)
                self.allSelect = NO;
            else{
                emptySum+=[subIitem.quantity integerValue];
                emptySumPrice+=[subIitem.price floatValue]*[subIitem.quantity integerValue];
            }
        }
    }
    self.payPrice = emptySumPrice;
    self.btnSelectAll.selected = self.allSelect;
    NSString* str =[NSString stringWithFormat:@"已选商品数: %ld 总计: %.2f ",(long)emptySum,emptySumPrice];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, str.length)];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, @"已选商品数:".length)];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:[str rangeOfString:@"总计:"]];
    self.labelSum.attributedText = attributeStr;
    self.btnConfrim.enabled = YES;
    if(self.payPrice<[@"9.00" floatValue]){
        self.btnConfrim.backgroundColor = [UIColor lightGrayColor];
        self.btnConfrim.enabled = NO;
        [self.btnConfrim setTitle:[NSString stringWithFormat:@"差%.2f元送货",([@"9.00" floatValue]-self.payPrice)] forState:UIControlStateNormal];
    }else{
        self.btnConfrim.enabled = YES;
        self.btnConfrim.backgroundColor = [UIColor redColor];
        [self.btnConfrim setTitle:@"去结算" forState:UIControlStateNormal];
        
    }
    [self.tableView reloadData];
}

//-(void)didSelectedGoodsTitle:(MGoods *)item store:(MStore *)store{
//    MStore* storeItem = store;
//    MGoods* empty = item;
//    if([empty.categroyID isEqualToString: @"71"]){
//        MBuyNow* by = [[MBuyNow alloc]init];
//        by.rowID = empty.rowID;
//        by.storeID = storeItem.rowID;
//        by.storeStatus = storeItem.status;
//        by.goodsName = empty.goodsName;
//        BuyNowInfo* controller = [[BuyNowInfo alloc]initWithItem:by];
//        controller.storeName = storeItem.storeName;
//        controller.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:controller animated:YES];
//    }else{
//        //Goods* controller = [[Goods alloc]initWithGoodsID:empty.rowID goodsName:empty.goodsName];
//        FruitInfo *controller = [[FruitInfo alloc]initWithItem:item];
//        controller.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }
//    
//}

-(void)addGoodsCount:(MGoods *)item{
    self.emptyGoods= item;
    [self addGoodsWithNum:1];
}

-(void)subtractionGoodsCount:(MGoods *)item{
    self.emptyGoods= item;
    if([item.quantity integerValue]>1){
        [self addGoodsWithNum:-1];
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"确认重购物车删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
#pragma mark =====================================================  UIAlertView 协议实现
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1){
        [self addGoodsWithNum:-1];
    }
}

#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:tipShoppingEmptyDataTitle attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:tipShoppingEmptyDataImge];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString:tipShoppingEmptyDataButtonTitle attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    UIEdgeInsets capInsets = UIEdgeInsetsZero;
    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
    
    capInsets = UIEdgeInsetsMake(22.0, 50.0, 22.0, 50.0);
    rectInsets = UIEdgeInsetsMake(0.0, -20, 0.0, -20);
    
    return [[[UIImage imageNamed:@"icon-bg"] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.tabBarController.selectedIndex=0;
   // NSLog(@"%s",__FUNCTION__);
}


#pragma mark =====================================================  SEL
-(IBAction)btnAddAddressTouch:(id)sender{
    SelectAddres* controller = [[SelectAddres alloc]init];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [nav.navigationBar setBackgroundColor:theme_navigation_color];
    [nav.navigationBar setBarTintColor:theme_navigation_color];
    [nav.navigationBar setTintColor:theme_default_color];
    [self presentViewController:nav animated:YES completion:nil];
}
-(IBAction)btnSectionTouch:(id)sender{
    MStore* item = self.arrayData[((UIButton*)sender).tag];
    Store* controller = [[Store alloc]initWithItem:item];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)allSelectedTouch:(id)sender{
    UIButton* btn =(UIButton*)sender;
    btn.selected = !btn.selected;
    self.allSelect = btn.selected;
    for (MStore* item in self.arrayData) {
        for (MGoods* subIitem in item.arrayGoods) {
            subIitem.shopCarSelected = self.allSelect;
        }
    }
    [self.tableView reloadData];
}
/*
 * 验证购物车是否可以生成订单 如果库存不足则提示
 */
-(IBAction)generateOrderTouch:(id)sender{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            NSMutableArray* emptyCarList = [[NSMutableArray alloc]init];
            for (MStore* item in self.arrayData) {
                for (MGoods* subItem in item.arrayGoods) {
                    if(subItem.shopCarSelected)
                        [emptyCarList addObject:@{@"fid":subItem.rowID,@"stock":subItem.quantity,@"spec":subItem.spec,@"proper":subItem.proper}];
                }
            }
            if(emptyCarList.count>0 && self.defaultAddress){
                if ([NSJSONSerialization isValidJSONObject:emptyCarList])
                {
//                    NSError *error;
//                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:emptyCarList options:NSJSONWritingPrettyPrinted error:&error];
//                    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                    [self showHUD];
//
//                    NSDictionary* arg = @{@"ince":@"submit_check_out",@"addr_item_id":self.defaultAddress.rowID,@"uid":self.Identity.userInfo.userID,@"cart_list":json};
//
//
//                    NetRepositories* repositories = [[NetRepositories alloc]init];
//                    [repositories submitShopCarCheck:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
//                        if(react == 1){
//                            [self hidHUD];
//                            GenerateOrder* controller = [[GenerateOrder alloc]init];
//                            controller.hidesBottomBarWhenPushed = YES;
//                            controller.carJson = json;
//
//                            UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
//                            [nav.navigationBar setBackgroundColor:theme_navigation_color];
//                            [nav.navigationBar setBarTintColor:theme_navigation_color];
//                            [nav.navigationBar setTintColor:theme_default_color];
//                            [self presentViewController:nav animated:YES completion:nil];
//
//                        }else if(react == 400){
//                            [self hidHUD:message];
//                        }else{
//                            NSArray* empty =[response objectForKey:@"foodinfo"];
//                            [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                                [self.arrayStock addObject:obj];
//                            }];
//                            empty = [response objectForKey:@"shopinfo"];
//                            [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                                [self.arrayStoreRest addObject:obj];
//                            }];
//                            [self.tableView reloadData];
//                            [self hidHUD];
//                        }
//                    }];
                    
                    NSError *error;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:emptyCarList options:NSJSONWritingPrettyPrinted error:&error];
                    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    
                    GenerateOrder* controller = [[GenerateOrder alloc]init];
                    controller.hidesBottomBarWhenPushed = YES;
                    controller.carJson = json;
                    
                    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
                    [nav.navigationBar setBackgroundColor:theme_navigation_color];
                    [nav.navigationBar setBarTintColor:theme_navigation_color];
                    [nav.navigationBar setTintColor:theme_default_color];
                    [self presentViewController:nav animated:YES completion:nil];
                }else{
                    NSLog(@"json 格式错误");
                }
            }else{
                [self alertHUD:@"确认选择购买商品、收货地址!"];
            }
        }
    }];
}
#pragma mark =====================================================  通知
-(void)changeOrderPayStatusNotification:(NSNotification*)notification{
    self.tabBarController.selectedIndex = 2;
}
-(void)selectAddressNotification:(NSNotification*)notification{
    MAddress* empty = (MAddress*)[notification object];
    if(empty){
        self.defaultAddress = empty;
    }
}

#pragma mark =====================================================  属性封装
-(NSMutableArray *)arrayData{
    if(!_arrayData)
        _arrayData = [[NSMutableArray alloc]init];
    return _arrayData;
}

-(NSMutableArray *)arrayStock{
    if(!_arrayStock){
        _arrayStock = [[NSMutableArray alloc]init];
    }
    return _arrayStock;
}

-(NSMutableArray *)arrayStoreRest{
    if(!_arrayStoreRest){
        _arrayStoreRest = [[NSMutableArray alloc]init];
    }
    return _arrayStoreRest;
}

@end
