//
//  OrderConfirm.m
//  KYRR
//
//  Created by kyjun on 16/6/18.
//
//

#import "OrderConfirm.h"
#import "OrderConfirmHeader.h"
#import "OrderConfirmCell.h"
#import <CommonCrypto/CommonDigest.h>
#import "payRequsestHandler.h"
#import "AlipayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "MOrderPay.h"
#import "OrderPaySuccess.h"


@interface OrderConfirm ()
@property(nonatomic,strong) OrderConfirmHeader* headerController;
@property(nonatomic,strong) UIView* footerView;
@property(nonatomic,strong) UIButton* btnPayWay;
@property(nonatomic,strong) UIButton* btnWeXinPay;
@property(nonatomic,strong) UIImageView* imgWeiXin;
@property(nonatomic,strong) UIButton* btnAlipay;
@property(nonatomic,strong) UIImageView* imgAli;
@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelGoodsPriceTitle;
@property(nonatomic,strong) UILabel* labelShipFeeTitle;
@property(nonatomic,strong) UILabel* labelTotalTitle;
@property(nonatomic,strong) UILabel* labelGoodsPrice;
@property(nonatomic,strong) UILabel* labelShipFee;
@property(nonatomic,strong) UILabel* labelTotal;

@property(nonatomic,strong) UIButton* btnPay;
@property(nonatomic,strong) MCheckOrder* entity;
@property(nonatomic,copy) NSString* cellIdentifier;

@property(nonatomic,copy) NSString* tuanID;
@property(nonatomic,assign) CGFloat totalPrice;

@end

@implementation OrderConfirm

-(instancetype)initWithItem:(MCheckOrder *)entity{
    self = [super init];
    if(self){
        _entity = entity;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellIdentifier = @"OrderConfirmCell";
    self.view.backgroundColor = theme_table_bg_color;
    [self.tableView registerClass:[OrderConfirmCell class] forCellReuseIdentifier:self.cellIdentifier];
    [self layoutUI];
    [self layoutConstraints];
    
    self.headerController.entity = self.entity.address;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    self.tableView.tableHeaderView = self.headerController.view;
    CGFloat price = 0.f;
    if(self.entity.isPresale){
        price = [self.entity.presale.presalePrice floatValue];
    }else{
        price = [self.entity.fightGroup.tuanPrice floatValue];
        
    }
    self.labelGoodsPrice.text = [NSString stringWithFormat: @"￥%.2f",price];
    CGFloat shipFee =[self.entity.shipFee floatValue];
    self.totalPrice = price+shipFee;
    self.labelShipFee.text = [NSString stringWithFormat: @"￥%.2f",shipFee];
    self.labelTotal.text = [NSString stringWithFormat: @"￥%.2f",price+shipFee];
    
    [self btnPayWay:self.btnWeXinPay];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNotification:) name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payUserCancelNotification:) name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayFailureNotification:) name:NotificationPayFailure object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
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

#pragma mark =====================================================  user interface layout

-(void)layoutUI{
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300.f);
    self.headerController = [[OrderConfirmHeader alloc]init];
    [self addChildViewController:self.headerController];
    
    self.tableView.tableHeaderView = self.headerController.view;
    self.tableView.tableFooterView = self.footerView;
    
    [self.footerView addSubview:self.btnPayWay];
    [self.footerView addSubview:self.btnWeXinPay];
    [self.btnWeXinPay addSubview:self.imgWeiXin];
    [self.footerView addSubview:self.btnAlipay];
    [self.btnAlipay addSubview:self.imgAli];
    [self.footerView addSubview:self.priceView];
    [self.priceView addSubview:self.labelGoodsPriceTitle];
    [self.priceView addSubview:self.labelGoodsPrice];
    [self.priceView addSubview:self.labelShipFeeTitle];
    [self.priceView addSubview:self.labelShipFee];
    [self.priceView addSubview:self.labelTotalTitle];
    [self.priceView addSubview:self.labelTotal];
    [self.footerView addSubview:self.btnPay];
    
}

-(void)layoutConstraints{
    
    self.btnPayWay.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnWeXinPay.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgWeiXin.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAlipay.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgAli.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnPayWay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPayWay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPayWay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPayWay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPayWay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnPayWay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.imgWeiXin addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.imgWeiXin addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnWeXinPay attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnWeXinPay attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnWeXinPay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.imgAli addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.imgAli addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnAlipay attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnAlipay attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    /*
     [self.btnPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
     [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
     [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
     [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];
     */
    
    NSArray* formats = @[@"H:|-defEdge-[priceView]-defEdge-|",@"H:|-leftEdge-[btnPay]-leftEdge-|", @"V:[btnAlipay][priceView]-20-[btnPay(==40)]-topEdge-|",
                         @"H:|-leftEdge-[labelGoodsPriceTitle][labelGoodsPrice]-leftEdge-|",@"H:|-leftEdge-[labelShipFeeTitle][labelShipFee]-leftEdge-|",@"H:|-leftEdge-[labelTotalTitle][labelTotal]-leftEdge-|",
                         @"V:|-defEdge-[labelGoodsPriceTitle][labelShipFeeTitle(labelGoodsPriceTitle)][labelTotalTitle(labelGoodsPriceTitle)]-defEdge-|",
                         @"V:|-defEdge-[labelGoodsPrice][labelShipFee(labelGoodsPrice)][labelTotal(labelGoodsPrice)]-defEdge-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10),
                               @"priceHeight":@(90)};
    NSDictionary* views = @{ @"btnAlipay":self.btnAlipay, @"priceView":self.priceView, @"btnPay":self.btnPay,
                             @"labelGoodsPriceTitle":self.labelGoodsPriceTitle, @"labelGoodsPrice":self.labelGoodsPrice, @"labelShipFeeTitle":self.labelShipFeeTitle,
                             @"labelShipFee":self.labelShipFee, @"labelTotalTitle":self.labelTotalTitle, @"labelTotal":self.labelTotal};
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       // NSLog( @" %@ %@ ",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.footerView addConstraints:constraints];
    }];
    
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.entity){
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderConfirmCell * cell = (OrderConfirmCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if(self.entity.isPresale){
        [cell loadData:self.entity.presale.goodsName price:self.entity.presale.presalePrice count:@"1"];
    }else{
        [cell loadData:self.entity.fightGroup.goodsName price:self.entity.fightGroup.tuanPrice count:@"1"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.entity.isPresale){
        CGFloat height = [WMHelper calculateTextHeight:self.entity.presale.goodsName font:[UIFont systemFontOfSize:14.f] width:SCREEN_WIDTH*3/5];
        return 10.f+height;
    }else{
        CGFloat height = [WMHelper calculateTextHeight:self.entity.fightGroup.goodsName font:[UIFont systemFontOfSize:14.f] width:SCREEN_WIDTH*3/5];
        return 10.f+height;
    }
}

#pragma mark =====================================================  SEL
-(IBAction)cancelTouch:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btnPayWay:(UIButton*)sender{
    [self showHUD];
    if(sender == self.btnWeXinPay){
        self.btnWeXinPay.selected = YES;
        self.btnAlipay.selected = NO;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
    }else if(sender == self.btnAlipay){
        self.btnWeXinPay.selected = NO;
        self.btnAlipay.selected = YES;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-enter"]];
    }else{
        self.btnWeXinPay.selected = NO;
        self.btnAlipay.selected = NO;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
    }
    [self.HUD hide:YES afterDelay:1];
}

-(IBAction)btnPayTouch:(id)sender{
    
    if(self.btnWeXinPay.selected){
        if(![WXApi isWXAppInstalled]){
            [self alertHUD:@"您的手机不支持微信支付"];
            return;
        }
    }
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            NSString* payType = @"2";
            if(self.btnWeXinPay.selected)//微信支付
                payType = @"2";
            else if (self.btnAlipay.selected)//支付宝支付
                payType = @"1";
            else //货到付款
                payType = @"0";
            
            [self showHUD];
            NSDictionary* arg = nil;
            if(self.entity.isPresale){
                arg = @{@"ince": @"yushou_save_order",@"fid":self.entity.presale.rowID,@"uid":self.Identity.userInfo.userID,@"addr_item_id":self.headerController.entity.rowID,@"pay_type":payType,@"cer_type":@"2"};
            }else{
                arg = @{@"ince": @"pintuan_save_order",@"fid":self.entity.fightGroup.rowID,@"uid":self.Identity.userInfo.userID,@"addr_item_id":self.headerController.entity.rowID,@"pay_type":payType,@"cer_type":@"2", @"tuanid":self.entity.tuanID};
            }
            //NSLog(@"%@",arg);
            
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    NSString* orderID = nil;
                    if(self.entity.isPresale){
                        orderID = [response objectForKey:@"order_id"];
                    }else{
                        orderID = [response objectForKey:@"main_id"];
                        self.tuanID = [response objectForKey: @"tuan_id"];
                    }
                    NSString* strMoeny = nil;
                    //                    if(self.entity.isPresale){
                    //                        strMoeny =self.entity.presale.presalePrice ;
                    //                    }else{
                    //                        strMoeny = self.entity.fightGroup.tuanPrice;
                    //                    }
                    strMoeny = [NSString stringWithFormat: @"%.2f",self.totalPrice];
                    [self hidHUD];
                    if(self.btnWeXinPay.selected){//微信支付
                        NSInteger money = (NSInteger)([strMoeny doubleValue]*100);
                        [MOrderPay payWithWeiXin:orderID price:money];
                    }else if (self.btnAlipay.selected){//支付宝支付
                        [MOrderPay payWithAlipay:orderID price:[strMoeny doubleValue] complete:^(NSInteger resultCode, NSString *message) {
                            if(resultCode == 9000){
                                /* OrderPaySuccess* controller = [[OrderPaySuccess alloc]init];
                                 [self.navigationController pushViewController:controller animated:YES];*/
                                [self payResult:message success:YES];
                            }else if(resultCode == 4000){
                                [self payResult:message success:NO];
                            }else {
                                [self payResult:message success:NO];
                            }
                            
                        }];
                    }else{ //货到付款 不需要修改订单状态这里直接跳转到订单页就可以了。
                        
                    }
                }else if(react == 400){
                    [self hidHUD:message];
                }else{
                    [self hidHUD:message];
                }
            }];
        }
    }];
    
}
#pragma mark =====================================================  通知
-(void)paySuccessNotification:(NSNotification*)notification{
    /* OrderPaySuccess* controller = [[OrderPaySuccess alloc]init];
     [self.navigationController pushViewController:controller animated:YES];*/
    [self payResult:nil success:YES];
}

-(void)payUserCancelNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message success:NO];
}

-(void)PayFailureNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message success:NO];
}

-(void)appBackNotification:(NSNotification*)notification{
    [self payResult:nil success:YES];
}
-(void)payResult:(NSString*)message success:(BOOL)success{
    if(!success){
        [self alertHUD:message];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        /* if([self.entity.tuanID integerValue]>0 ){
         if(self.entity.isPresale){
         [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil];
         }else{
         [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPintuangouVCuccess object:nil];
         }
         }else if(!([self.entity.tuanID integerValue]>0) && ![WMHelper isEmptyOrNULLOrnil:message]){//订单中途取消
         [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil]; //调整到订单列表
         }else{
         [[NSNotificationCenter defaultCenter] postNotificationName:NotificationFightGroupCreateTuanSuccess object:self.tuanID];
         }
         
         */
        if(self.entity.isPresale){//预售
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil];
        }else{//拼团
            if([self.entity.tuanID integerValue]>0){ //参团
                if(success ){//支付成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPintuangouVCuccess object:nil];
                }else{ //支付失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil];
                }
            }else{ //建团
                if(success ){ //支付成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationFightGroupCreateTuanSuccess object:self.tuanID];
                }else{//支付失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil];
                }
            }
        }
        
    }];
}

#pragma mark =====================================================  property package

-(UIView *)footerView{
    if(!_footerView){
        _footerView = [[UIView alloc]init];
    }
    return _footerView;
}

-(UIButton *)btnPayWay{
    if(!_btnPayWay){
        _btnPayWay = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPayWay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnPayWay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-35);
        _btnPayWay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        _btnPayWay.userInteractionEnabled = NO;
        [_btnPayWay setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        [_btnPayWay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        _btnPayWay.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnPayWay setTitle:@"支付方式" forState:UIControlStateNormal];
        _btnPayWay.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 29.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnPayWay.layer addSublayer:border];
    }
    return _btnPayWay;
}

-(UIButton *)btnWeXinPay{
    if(!_btnWeXinPay){
        _btnWeXinPay = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeXinPay.backgroundColor = theme_default_color;
        _btnWeXinPay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnWeXinPay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
        _btnWeXinPay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btnWeXinPay setImage:[UIImage imageNamed:@"icon-wechat-pay"] forState:UIControlStateNormal];
        [_btnWeXinPay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        [_btnWeXinPay setTitle:@"微信支付" forState:UIControlStateNormal];
        _btnWeXinPay.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnWeXinPay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
        _btnWeXinPay.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 39.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnWeXinPay.layer addSublayer:border];
    }
    return _btnWeXinPay;
}

-(UIImageView *)imgWeiXin{
    if(!_imgWeiXin){
        _imgWeiXin = [[UIImageView alloc]init];
        [_imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
    }
    return _imgWeiXin;
}

-(UIButton *)btnAlipay{
    if(!_btnAlipay){
        _btnAlipay = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAlipay.backgroundColor =theme_default_color;
        _btnAlipay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnAlipay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
        _btnAlipay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btnAlipay setImage:[UIImage imageNamed:@"icon-alipay"] forState:UIControlStateNormal];
        [_btnAlipay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        [_btnAlipay setTitle:@"支付宝支付" forState:UIControlStateNormal];
        _btnAlipay.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnAlipay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
        _btnAlipay.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 39.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnAlipay.layer addSublayer:border];
        
    }
    return _btnAlipay;
}

-(UIImageView *)imgAli{
    if(!_imgAli){
        _imgAli = [[UIImageView alloc]init];
        [_imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
    }
    return _imgAli;
}


-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
        _priceView.backgroundColor = [UIColor whiteColor];
        _priceView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceView;
}

-(UILabel *)labelGoodsPriceTitle{
    if(!_labelGoodsPriceTitle){
        _labelGoodsPriceTitle = [[UILabel alloc]init];
        _labelGoodsPriceTitle.text =  @"商品金额:";
        _labelGoodsPriceTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelGoodsPriceTitle;
}

-(UILabel *)labelGoodsPrice{
    if(!_labelGoodsPrice){
        _labelGoodsPrice = [[UILabel alloc]init];
        _labelGoodsPrice.textAlignment = NSTextAlignmentRight;
        _labelGoodsPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelGoodsPrice;
}

-(UILabel *)labelShipFeeTitle{
    if(!_labelShipFeeTitle){
        _labelShipFeeTitle = [[UILabel alloc]init];
        _labelShipFeeTitle.text =  @"配送费:";
        _labelShipFeeTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShipFeeTitle;
}

-(UILabel *)labelShipFee{
    if(!_labelShipFee){
        _labelShipFee = [[UILabel alloc]init];
        _labelShipFee.textAlignment = NSTextAlignmentRight;
        _labelShipFee.textColor = [UIColor redColor];
        _labelShipFee.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShipFee;
}

-(UILabel *)labelTotalTitle{
    if(!_labelTotalTitle){
        _labelTotalTitle = [[UILabel alloc]init];
        _labelTotalTitle.text =  @"应付总金额:";
        _labelTotalTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTotalTitle;
}

-(UILabel *)labelTotal{
    if(!_labelTotal){
        _labelTotal = [[UILabel alloc]init];
        _labelTotal.textAlignment = NSTextAlignmentRight;
        _labelTotal.textColor = [UIColor redColor];
        _labelTotal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTotal;
}

-(UIButton *)btnPay{
    if(!_btnPay){
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnPay setTitle:@"提交订单" forState:UIControlStateNormal];
        _btnPay.backgroundColor = [UIColor colorWithRed:46/255. green:152/255.f blue:52/255.f alpha:1.0];
        [_btnPay addTarget:self action:@selector(btnPayTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnPay.layer.masksToBounds = YES;
        _btnPay.layer.cornerRadius = 5.f;
    }
    return _btnPay;
}




@end
