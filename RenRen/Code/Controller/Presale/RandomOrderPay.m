//
//  RandomOrderPay.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/14.
//
//

#import "RandomOrderPay.h"
#import "PayWayCell.h"
#import "RandomOrderPayHeader.h"
#import <CommonCrypto/CommonDigest.h>
#import "payRequsestHandler.h"
#import "AlipayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "WXApi.h"


@interface RandomOrderPay ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSString* orderID;
@property(nonatomic,assign) CGFloat money;
@property(nonatomic,strong) NSString* goodsName;
@property(nonatomic,assign) BOOL fromOrder;

@property(nonatomic,strong) NSArray* arrayData;

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIButton* btnPay;
@end

static NSString* const cellIdentifier =  @"PayWayCell";
static NSString* const reuseIdentifier =  @"randomOrderPayHeader";

@implementation RandomOrderPay

-(instancetype)initWithOrderID:(NSString *)orderID money:(CGFloat)money goodsName:(NSString *)goodsName fromOrder:(BOOL)fromOrder{
    self = [super init];
    if(self){
        _orderID = orderID;
        _money = money;
        _goodsName = goodsName;
        _fromOrder = fromOrder;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutUI];
    [self.btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay setTitle: [NSString stringWithFormat: @"确认支付 ￥ %.2f",self.money] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNotification:) name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payUserCancelNotification:) name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayFailureNotification:) name:NotificationPayFailure object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBackNotification:) name:NotificationAppBack object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"外卖郎收银台";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPayFailure object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationAppBack object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.arrayData = @[[[MPayWay alloc]initWithDictionary: @{ @"icon": @"icon-alipay", @"title": @"支付宝", @"subTitle": @"推荐支付宝用户使用", @"selected": @"1", @"payType": @"1"}],
                       [[MPayWay alloc]initWithDictionary: @{ @"icon": @"icon-wechat-pay", @"title": @"微信支付", @"subTitle": @"推荐微信用户使用", @"selected": @"0", @"payType": @"2"}]
                       ];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.btnPay];
    NSArray* formats = @[@"H:|-defEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[btnPay]-defEdge-|",  @"V:|-defEdge-[collectionView][btnPay(==payHeight)]-defEdge-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"payHeight":@(50)};
    NSDictionary* views = @{ @"collectionView":self.collectionView, @"btnPay":self.btnPay};
    
    for (NSString* format in formats) {
        //NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
    
}

#pragma mark ===================================================== <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PayWayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.item = self.arrayData[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RandomOrderPayHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [header loadDataWithName:self.goodsName money:self.money];
        return header;
    }
    return nil;
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_WIDTH, 90);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
}

#pragma mark =====================================================  <UICollectionViewDelgate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MPayWay* item = self.arrayData[indexPath.row];
    for (MPayWay* sub in self.arrayData) {
        sub.selected = NO;
    }
    item.selected = YES;
    [self.collectionView reloadData];
}

#pragma mark =====================================================  SEL

-(IBAction)cancelTouch:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btnPayTouch:(id)sender{
    for (MPayWay* sub in self.arrayData) {
        if(sub.selected){
            if([sub.payType integerValue] == 1){
                [self aliPay];
            }else if(([sub.payType integerValue] == 2)){
                [self wxPay];
            }else{
                
            }
        }else {
            
        }
    }
}

#pragma mark =====================================================  private method

#pragma mark 微信支付
-(void)wxPay{
    
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:kWXAPP_ID mch_id:kWXPay_partnerid];
    //设置密钥
    [req setKey:kWXPay_partnerid_secret];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSInteger price = (NSInteger)(self.self.money*100);
    NSMutableDictionary *dict = [req sendPay:self.orderID price:price noticeUrl: @"http://wm.wm0530.com/App/Pay/wxpay_notify"];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alertHUD:debug];
        
       // NSLog(@"%@\n\n",debug);
    }else{
        //NSLog(@"%@\n\n",[req getDebugifo]);
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

-(void)aliPay{
    
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
    order.tradeNO = self.orderID; //订单ID（由商家自行制定）
    order.productName = @"外卖郎 订单"; //商品标题
    order.productDescription = @"外卖郎 订单"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",self.money]; //商品价格
    // order.notifyURL =  @"http://wm.wm0530.com"; //回调URL
    
    order.notifyURL =  @"http://wm.wm0530.com/App/Pay/alipay_notify"; //回调URL
    
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
    if(self.fromOrder){
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRandomPayFinishRefreshOrder object:nil];
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRandomPayFinished object:nil];
        }];
    }

}

-(void)payUserCancelNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self alertHUD:message];
}

-(void)PayFailureNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    
    [self alertHUD:message];
}

-(void)appBackNotification:(NSNotification*)notification{
   /* [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRandomPayFinished object:nil];
    }];*/
}
-(void)payResult:(NSString*)message{
    if(message){
        [self alertHUD:message];
    }
    }
#pragma mark =====================================================  property package
-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout* block = [[UICollectionViewFlowLayout alloc]init];
        block.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:block];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[PayWayCell class] forCellWithReuseIdentifier:cellIdentifier];
        [_collectionView registerClass:[RandomOrderPayHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

-(UIButton *)btnPay{
    if(!_btnPay){
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPay.backgroundColor = [UIColor redColor];
        [_btnPay addTarget:self action:@selector(btnPayTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnPay;
}











@end
