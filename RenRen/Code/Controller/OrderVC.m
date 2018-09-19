//
//  Order.m
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#import "OrderVC.h"
#import "Pager.h"
#import "OrderCell.h"
#import "AppDelegate.h"
#import "payRequsestHandler.h"
#import "AlipayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "OrderDetail.h"
#import "OrderInfo.h"
#import "AddComment.h"
#import "MyTuanInfo.h"
#import "GroupBuy.h"


@interface OrderVC ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,OrderCellDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UIView* headerView;

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) NSMutableArray* arrayBtn;

@property(nonatomic,strong) UIImageView* line;

//@property(nonatomic,strong) Pager* page;
@property(nonatomic,copy) NSString* orderStatus;
@property(nonatomic,copy) NSString* orderNo;

@property(nonatomic,strong) NetPage* netPage;
@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,strong) MOrder* temporaryOrder;
@property(nonatomic,assign) NSInteger temporaryIndex;

@end

@implementation OrderVC
-(instancetype)init{
    self = [super init];
    if(self){
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab-order-default"]];
        [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-order-enter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self.tabBarItem setTitle:@"订单"];
        self.tabBarItem.tag=2;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = theme_table_bg_color;
    self.title = @"我的订单";
    self.orderStatus = @"-1";
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshOrder:) name:NotificationRefreshOrder object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNotification:) name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payUserCancelNotification:) name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayFailureNotification:) name:NotificationPayFailure object:nil];
    
    [self changeNavigationBarBackgroundColor:theme_navigation_color];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPayFailure object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  试图布局
-(void)layoutUI{
    
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = theme_default_color;
    UIImageView* lineBottom = [[UIImageView alloc]init];
    lineBottom.frame=CGRectMake(0, 44.f, SCREEN_WIDTH, 1.f);
    lineBottom.backgroundColor = theme_line_color;
    [self.headerView addSubview:lineBottom];
    
    
    
    self.arrayBtn = [[NSMutableArray alloc]init];
    NSArray* arrayTitle = @[@"全部",@"待付款",@"已付款",@"退款单"];
    for (int i=0; i<4; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 45);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:theme_navigation_color forState:UIControlStateSelected];
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn addTarget:self action:@selector(btnHeaderTouch:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        /*UIImageView* lineRight = [[UIImageView alloc]init];
         lineRight.frame=CGRectMake(SCREEN_WIDTH/4, 9, 1, 31.f);
         lineRight.backgroundColor = theme_line_color;
         [btn addSubview:lineRight];*/
        [self.headerView addSubview:btn];
        [self.arrayBtn addObject:btn];
        if(i==0)
            btn.selected = YES;
    }
    self.line = [[UIImageView alloc]init];
    self.line.frame=CGRectMake(0, 42.f, SCREEN_WIDTH/4, 3.f);
    self.line.backgroundColor = theme_navigation_color;
    [self.headerView addSubview:self.line];
    
    [self.view addSubview:self.headerView];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

-(void)layoutConstraints{
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
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


#pragma mark =====================================================  数据源
-(void)queryData{
    
    //NSDictionary* arg = @{@"ince":@"get_user_order",@"uid":self.Identity.userInfo.userID,@"page":[WMHelper integerConvertToString:self.netPage.pageIndex],@"status":self.orderStatus};
    NSDictionary* arg = @{@"a":@"getOrderList",@"uid":self.Identity.userInfo.userID,@"page":[WMHelper integerConvertToString:self.netPage.pageIndex],@"status":self.orderStatus};
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryOrder:arg page:self.netPage complete:^(NSInteger react, NSArray *list, NSString *message) {
        if(self.netPage.pageIndex == 1){
            [self.arrayData removeAllObjects];
        }
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            
        }
        [self.tableView reloadData];
        if(self.netPage.pageCount<=self.netPage.pageIndex){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if(self.netPage.pageIndex==1){
            [self.tableView.mj_header endRefreshing];
        }
        
    }];
    
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.netPage.pageIndex = 1;
        [weakSelf queryData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        weakSelf.netPage.pageIndex ++;
        [weakSelf queryData];
    }];
}

#pragma mark =====================================================  UITableView 协议实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    if(!cell)
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.entity = self.arrayData[indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MOrder* entity = self.arrayData[indexPath.row];
    if([entity.orderType  integerValue] ==2){
        if([entity.tuanStatus integerValue] ==0){
            GroupBuy *controller = [[GroupBuy alloc]initWithRowID:entity.tuanID];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            OrderInfo* controller = [[OrderInfo alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            controller.orderID = entity.rowID;
            controller.entity = entity;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }else{
        
        OrderInfo* controller = [[OrderInfo alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.orderID = entity.rowID;
        controller.entity = entity;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark =====================================================  OrderCell协议实现

//自己更改走的支付的协议方法
-(void)orderGoPay:(MOrder *)item{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            self.orderNo = item.rowID;
            [self showHUD];
            
            NSDictionary* arg = @{@"ince":@"check_pay_order",@"order_id":item.rowID};
            
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    [self hidHUD];
                    switch ([item.payType integerValue]) {
                        case 0: //货到付款由后台操作
                        {
                            //[self alertHUD:@"货到付款"];支付宝
                            
                            //[[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:@"货到付款支付成功!"];
                        }
                            break;
                        case 1:
                        case 3:
                        {
                            [self aliPay:item.rowID price:item.goodsPrice];
                        }
                            break;
                        case 2:
                        {
                            [self wxPay:item.rowID price:item.goodsPrice];
                        }
                            break;
                        default:
                            break;
                    }
                    
                }else if(react == 400){
                    [self hidHUD:message];
                }else{
                    self.orderNo = nil;
                    [self hidHUD:message];
                    [self.tableView.mj_header beginRefreshing];
                }
            }];
        }
    }];
}
-(void)orderCancelOrder:(MOrder *)item{
    self.orderNo = item.rowID;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要取消订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 9999;
    [alert show];
}

-(void)orderAddComment:(MOrder *)item{
    AddComment* controller = [[AddComment alloc]initWithOrderID:item.rowID];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)orderDelete:(OrderCell *)tableViewCell item:(MOrder *)item{
    self.temporaryOrder = item;
    self.temporaryIndex = tableViewCell.tag;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确认删除订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 7777;
    [alert show];
}
#pragma mark =====================================================  UIAlert 协议实现
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 9999){
        if (buttonIndex==1){
            [self showHUD];
            
            NSDictionary* arg = @{@"ince":@"update_user_order_status",@"uid":self.Identity.userInfo.userID,@"order_id":self.orderNo,@"orderstatus":@"5"};
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    [self hidHUD:@"订单取消成功"];
                }else if(react == 400){
                    [self hidHUD:message];
                }else{
                    [self hidHUD:message];
                }
                self.orderNo = nil;
                [self.tableView.mj_header beginRefreshing];
            }];
        }
    }
    if(alertView.tag == 7777){
        if (buttonIndex==1){
            [self showHUD];
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories requestPost:@{ @"ince": @"del_user_order", @"uid":self.Identity.userInfo.userID, @"order_id":self.temporaryOrder.rowID} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react==1){
                    [self hidHUD];
                    if (self.arrayData.count > 0) {
                        [self.arrayData removeObjectAtIndex:self.temporaryIndex];
                    }
                    
//                    [self.arrayData removeObjectAtIndex:self.temporaryIndex];
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.temporaryIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                }else{
                    [self hidHUD:message];
                }
            }];
        }
    }
    
}


#pragma mark =====================================================  私有方法
#pragma mark 微信支付
-(void)wxPay:(NSString*)orderID price:(NSString*)price{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:kWXAPP_ID mch_id:kWXPay_partnerid];
    //设置密钥
    [req setKey:kWXPay_partnerid_secret];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    CGFloat empty = [price doubleValue];
    
    NSInteger orderPrice = (NSInteger)(empty*100);
    NSMutableDictionary *dict = [req sendPay:orderID price:orderPrice];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alertHUD:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
    
}

//饕餮
-(void)aliPay:(NSString*)orderID price:(NSString*)price{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = AlipayPartner;
    NSString *seller = AlipaySeller;
    NSString *privateKey = AlipayPrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    AlipayOrder *order = [[AlipayOrder alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = @"外卖郎 订单"; //商品标题
    order.productDescription = @"外卖郎变量店 订单"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[price floatValue]]; //商品价格
    order.notifyURL =  @"http://wm.wm0530.com/Mobile/Tpay/notifyurl"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.wanmei.waimailanguser";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        
            NSInteger flag = [[resultDic objectForKey:@"resultStatus"]integerValue];
            [self alertHUD:[resultDic objectForKey:@"memo"]];
            if(flag == 9000){
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:[resultDic objectForKey:@"memo"]];
            }else if(flag == 4000){
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayFailure object:[resultDic objectForKey:@"memo"]];
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayUserCancel object:[resultDic objectForKey:@"memo"]];
            }
            // NSLog(@"%@",resultDic);
        }];
        
    }
    
}

#pragma mark =====================================================  通知
-(void)paySuccessNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message];
}

-(void)payUserCancelNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message];
}

-(void)PayFailureNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message];
}
-(void)payResult:(NSString*)message{
    [self showHUD:message];
    [self hidHUD:message];
    [self.tableView.mj_header beginRefreshing];
}

-(void)refreshOrder:(NSNotification*)notification{
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark =====================================================  DZEmptyData 协议实现

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString:@"没有查询到相关数据" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:kDefaultImage];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.tableView.tableHeaderView.frame.size.height/2.0f;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  SEL
-(IBAction)btnHeaderTouch:(UIButton*)sender{
    [self.arrayBtn enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ((UIButton*)obj).selected = NO;
    }];
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.7 animations:^{
        self.line.frame = CGRectMake(sender.tag*SCREEN_WIDTH/4, 42.f, SCREEN_WIDTH/4, 3.f);
    }];
    switch (sender.tag) {
        case 0:
            self.orderStatus = @"-1";
            break;
        case 1:
            self.orderStatus = @"0";
            break;
        case 2:
            self.orderStatus = @"1";
            break;
        case 3:
            self.orderStatus = @"2";
            break;
            
        default:
            break;
    }
    [self.tableView.mj_footer resetNoMoreData];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  属性
/*-(Pager *)page{
 if(!_page){
 _page = [[Pager alloc]init];
 _page.pageSize = 10;
 }
 return _page;
 }
 */
-(NetPage *)netPage{
    if(!_netPage){
        _netPage = [[NetPage alloc]init];
        _netPage.pageIndex = 1;
    }
    return _netPage;
}

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
