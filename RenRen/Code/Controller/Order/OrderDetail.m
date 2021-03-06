//
//  OrderDetail.m
//  KYRR
//
//  Created by kyjun on 16/1/13.
//
//

#import "OrderDetail.h"
#import "OrderDetailCell.h"
#import "Feedback.h"
#import <CoreText/CoreText.h>
#import "Store.h"
#import <GoogleMaps/GoogleMaps.h>
//#import "StoreGoods.h"


@interface OrderDetail ()<UIAlertViewDelegate>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UILabel* labelExpressStatus;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UILabel* labelCreateDate;

@property(nonatomic,strong) UILabel* labelDetail;
@property(nonatomic,strong) UIButton* btnStore;

@property(nonatomic,strong) UIView* footerView;
/**
 *  满减优惠
 */
@property(nonatomic,strong) UIView* fullCutView;
@property(nonatomic,strong) NSLayoutConstraint* fullCutConstraint;
@property(nonatomic,strong) UILabel* labelCutIcon;
@property(nonatomic,strong) UILabel* labelCutTitle;
@property(nonatomic,strong) UILabel* labelFullCutPrice;
@property(nonatomic,assign) double fullCut;

@property(nonatomic,strong) UILabel* labelPackge;
@property(nonatomic,strong) UILabel* labelPackgeFee;

@property(nonatomic,strong) UILabel* labelShip;
@property(nonatomic,strong) UILabel* labelShipFee;

@property(nonatomic,strong) UILabel* labelTip;
@property(nonatomic,strong) UILabel* labelTipFee;

@property(nonatomic,strong) UILabel* labelTax;
@property(nonatomic,strong) UILabel* labelTaxFee;

@property(nonatomic,strong) UILabel* labelDeposit;
@property(nonatomic,strong) UILabel* labelDepositFee;

@property(nonatomic,strong) UILabel* labelSumPrice;
@property(nonatomic,strong) UILabel* labelOther;
@property(nonatomic,strong) UITextField* txtExpressMan;
@property(nonatomic,strong) UITextField* txtOrderNO;
@property(nonatomic,strong) UITextField* txtExpressDate;
@property(nonatomic,strong) UITextField* txtAddress;
@property(nonatomic,strong) UITextView* txtShoppingAddress;
@property(nonatomic,strong) UITextField* txtPayWay;

@property(nonatomic,strong) UIView* deliverView;

@property(nonatomic,strong) NSArray* arrayFood;
@property(nonatomic,strong) NSDictionary* dictOther;

@property(nonatomic,strong) GMSMapView* mapView;

@end

@implementation OrderDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Localized(@"Order_detail");
    [self layoutUI];
    [self layoutConstrants];
    
    [self refreshDataSource];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:16];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    //mapView.autoresizingMask = [UIViewAutoresizingFlexibleWidth, UIViewAutoresizingFlexibleHeight];
    [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.deliverView addSubview:self.mapView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI Layout
-(void)layoutUI{
    [self.headerView addSubview:self.labelExpressStatus];
    [self.headerView addSubview:self.labelStatus];
    [self.headerView addSubview:self.labelCreateDate];
    [self.headerView addSubview:self.labelDetail];
    [self.headerView addSubview:self.btnStore];
    
    [self.footerView addSubview:self.fullCutView];
    [self.fullCutView addSubview:self.labelCutIcon];
    [self.fullCutView addSubview:self.labelCutTitle];
    [self.fullCutView addSubview:self.labelFullCutPrice];
    
    [self.footerView addSubview:self.labelPackge];
    [self.footerView addSubview:self.labelPackgeFee];
    [self.footerView addSubview:self.labelShip];
    [self.footerView addSubview:self.labelShipFee];
    [self.footerView addSubview:self.labelTip];
    [self.footerView addSubview:self.labelTipFee];
    [self.footerView addSubview:self.labelTax];
    [self.footerView addSubview:self.labelTaxFee];
    [self.footerView addSubview:self.labelDeposit];
    [self.footerView addSubview:self.labelDepositFee];
    [self.footerView addSubview:self.labelSumPrice];
    [self.footerView addSubview:self.labelOther];
    [self.footerView addSubview:self.txtExpressMan];
    [self.footerView addSubview:self.txtOrderNO];
    [self.footerView addSubview:self.txtExpressDate];
    [self.footerView addSubview:self.txtAddress];
    [self.footerView addSubview:self.txtPayWay];
    
    [self.footerView addSubview:self.deliverView];
    
    [self.tableView registerClass:[OrderDetailCell class] forCellReuseIdentifier:@"OrderDetailCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableHeaderView = self.headerView;
}

-(void)layoutConstrants{
    self.labelPackge.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPackgeFee.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelShip.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelShipFee.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTip.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTipFee.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTax.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTaxFee.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDeposit.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDepositFee.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOther.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtExpressMan.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtOrderNO.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtExpressDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtAddress.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtPayWay.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.fullCutConstraint = [NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f];
    self.fullCutConstraint.priority = 701;
    [self.fullCutView addConstraint:self.fullCutConstraint];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0.f]];
    [self.labelCutIcon addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.labelCutIcon attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutIcon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFullCutPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.labelFullCutPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFullCutPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFullCutPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFullCutPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelCutIcon attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutTitle attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.fullCutView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCutTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelFullCutPrice attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10.f]];
    
    [self.labelPackge addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackge attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelPackge addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackge attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackge attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackge attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelPackgeFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackgeFee attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelPackgeFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackgeFee attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackgeFee attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackgeFee attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelShip addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShip attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelShip addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShip attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShip attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPackge attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShip attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelShipFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShipFee attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelShipFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShipFee attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShipFee attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPackgeFee attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelShipFee attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelTip addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTip attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTip addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTip attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTip attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelShip attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTip attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelTipFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTipFee attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTipFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTipFee attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTipFee attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelShipFee attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTipFee attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelTax addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTax addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTip attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelTaxFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxFee attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTaxFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxFee attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxFee attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTipFee attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxFee attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelDeposit addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelDeposit addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTax attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelDepositFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDepositFee attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelDepositFee addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDepositFee attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDepositFee attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTaxFee attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDepositFee attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelSumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.labelSumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelDepositFee attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    
    [self.labelOther addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.labelOther addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelSumPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.deliverView addConstraint:[NSLayoutConstraint constraintWithItem:self.deliverView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.deliverView addConstraint:[NSLayoutConstraint constraintWithItem:self.deliverView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:200.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.deliverView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelOther attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.deliverView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.txtExpressMan addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressMan attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.txtExpressMan addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressMan attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressMan attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.deliverView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressMan attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.txtOrderNO addConstraint:[NSLayoutConstraint constraintWithItem:self.txtOrderNO attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.txtOrderNO addConstraint:[NSLayoutConstraint constraintWithItem:self.txtOrderNO attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtOrderNO attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtExpressMan attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtOrderNO attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.txtExpressDate addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.txtExpressDate addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressDate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtOrderNO attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtExpressDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.txtAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.txtAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:55.f]];
    [self.txtAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.txtAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtExpressDate attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtAddress attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];

    [self.txtPayWay addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPayWay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.txtPayWay addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPayWay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPayWay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtAddress attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPayWay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  DataSource
-(void)queryData{
   
    //NSDictionary* arg = @{@"ince":@"get_order_detail",@"order_id":self.orderNO};
    NSDictionary* arg = @{@"a":@"getOrderDetail",@"order_id":self.orderNO};
      
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            self.dictOther = [response objectForKey:@"order"];
            self.arrayFood = [response objectForKey:@"food"];
            [self loadData];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
}
#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayFood.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell" forIndexPath:indexPath];
    cell.item = self.arrayFood[indexPath.row];
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark =====================================================  <UIAlertViewDelegate>
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"Tel:%@",[self.dictOther objectForKey:@"tel"]]]];
    }
}

#pragma mark =====================================================  Private Method
-(void)loadData{
    NSString* statusName = [self.dictOther objectForKey:@"statusname"];
    NSString* str =[NSString stringWithFormat:@"%@\n%@",statusName,Localized(@"Can_touch_we")];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:theme_title_color,NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(0, statusName.length)];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:theme_Fourm_color,NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:NSMakeRange(statusName.length+1, str.length-statusName.length-1)];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.labelStatus.attributedText = attributeStr;
    
    NSString* createDate = [self.dictOther objectForKey:@"add_time"];
    NSString* payWay = [self.dictOther objectForKey:@"payname"];
    str =[NSString stringWithFormat:@"%@\n%@",createDate,payWay];
    attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, [createDate length])];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:22/255.f green:162/255.f blue:51/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange([createDate length]+1,[payWay length])];
    
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphSpacing:10];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    self.labelCreateDate.attributedText = attributeStr;
    double packageFee = [[self.dictOther objectForKey:@"packing_fee"] doubleValue];
    double shipFee = [[self.dictOther objectForKey:@"ship_fee"] doubleValue];
    double foodFee = [[self.dictOther objectForKey:@"food_amount"] doubleValue];
    double tipFee = [[self.dictOther objectForKey:@"tip_fee"] doubleValue];
    double taxFee = [[self.dictOther objectForKey:@"tax_price"] doubleValue];
    double depositFee = [[self.dictOther objectForKey:@"deposit_price"] doubleValue];
    
    self.labelPackgeFee.text = [NSString stringWithFormat:@" $%.2f",packageFee];
    self.labelShipFee.text = [NSString stringWithFormat:@" $%.2f",shipFee];
    self.labelTipFee.text = [NSString stringWithFormat:@" $%.2f",tipFee];
    self.labelTaxFee.text = [NSString stringWithFormat:@" $%.2f",taxFee];
    self.labelDepositFee.text = [NSString stringWithFormat:@" $%.2f",depositFee];
    
    self.txtExpressMan.text = [self.dictOther objectForKey:@"empname"];
    self.txtOrderNO.text = [self.dictOther objectForKey:@"order_id"];
    self.txtExpressDate.text = [self.dictOther objectForKey:@"expect_time"];
    self.txtShoppingAddress.text = [NSString stringWithFormat:@"%@ %@ %@ %@",[self.dictOther objectForKey:@"uname"],[self.dictOther objectForKey:@"phone"],[self.dictOther objectForKey:@"address2"],[self.dictOther objectForKey:@"address1"]];
    //NSLog(@"%ld",self.txtShoppingAddress.text.length);
    if(self.txtShoppingAddress.text.length > 40){ self.txtShoppingAddress.font = [UIFont systemFontOfSize:12.f];}
    self.txtPayWay.text = payWay;
    [self.btnStore setTitle:[self.dictOther objectForKey:@"site_name"] forState:UIControlStateNormal];
    //便利店平台负担满减
    double platformDiscount = [[self.dictOther objectForKey: @"promotion_discount"] doubleValue];
    //店铺负担满减
    double storeDiscount = [[self.dictOther objectForKey: @"discount"]doubleValue];
    
    self.fullCut = platformDiscount+storeDiscount;
    self.labelFullCutPrice.text = [NSString stringWithFormat:@"- $%.2f",self.fullCut];
    if(self.fullCut>0.00){
        dispatch_async(dispatch_get_main_queue(), ^{
         if(self.fullCutConstraint){
        /* [self.fullCutView removeConstraint:self.fullCutConstraint];
         self.fullCutConstraint = [NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f];
         self.fullCutConstraint.priority = 751;
         [self.fullCutView addConstraint:self.fullCutConstraint];*/
         }
         });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.fullCutConstraint){
                [self.fullCutView removeConstraint:self.fullCutConstraint];
                self.fullCutConstraint = [NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f];
                self.fullCutConstraint.priority = 751;
                [self.fullCutView addConstraint:self.fullCutConstraint];
            }
        });
    }
    double subTotal = [[self.dictOther objectForKey:@"subtotal"] doubleValue];
    self.labelSumPrice.text = [NSString stringWithFormat:@"%@    $%.2f",Localized(@"Product_price"),subTotal + tipFee - self.fullCut];
    
    if(![WMHelper isEmptyOrNULLOrnil:[self.dictOther objectForKey:@"deliver_lng"]]){
        self.deliverView.hidden = NO;
        for(NSLayoutConstraint* con in [self.deliverView constraints]){
            if([con firstAttribute] == NSLayoutAttributeHeight){
                [self.deliverView removeConstraint:con];
                [self.deliverView addConstraint:[NSLayoutConstraint constraintWithItem:self.deliverView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
            }
        }
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 720.f);
        
        double lng = [[self.dictOther objectForKey:@"deliver_lng"] floatValue];
        double lat = [[self.dictOther objectForKey:@"deliver_lat"] floatValue];
        self.mapView.camera = [GMSCameraPosition cameraWithLatitude:lat
                                                          longitude:lng
                                                               zoom:16];
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(lat,lng);
        marker.title = [self.dictOther objectForKey:@"empname"];
        
        marker.map = self.mapView;
    }else{
        self.deliverView.hidden = YES;
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 520.f);
        for(NSLayoutConstraint* con in [self.deliverView constraints]){
            if([con firstAttribute] == NSLayoutAttributeHeight){
                [self.deliverView removeConstraint:con];
                [self.deliverView addConstraint:[NSLayoutConstraint constraintWithItem:self.deliverView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f]];
            }
        }
    }
}


#pragma mark =====================================================  SEL
-(IBAction)againSingleTouch:(UIButton*)sender{
    MStore* item =[[MStore alloc]init];
    item.rowID =[self.dictOther objectForKey:@"site_id"];
    Store* controller = [[Store alloc]initWithItem:item];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)complaintsTouch:(UIButton*)sender{
    Feedback* controller = [[Feedback alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)tipTouch:(UIButton*)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Localized(@"Whether_call") message:[self.dictOther objectForKey:@"Tel"] delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
    [alert show];
}

#pragma mark =====================================================  Property Package
-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190.f)];
        _headerView.backgroundColor = theme_default_color;
    }
    return _headerView;
}

-(UILabel *)labelExpressStatus{
    if(!_labelExpressStatus){
        _labelExpressStatus = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35.f)];
        _labelExpressStatus.backgroundColor = [UIColor colorWithRed:231/255.f green:232/255.f blue:238/255.f alpha:1.0];
        _labelExpressStatus.textColor = [UIColor colorWithRed:105/255.f green:106/255.f blue:110/255.f alpha:1.0];
        _labelExpressStatus.font = [UIFont systemFontOfSize:14.f];
        _labelExpressStatus.text = [NSString stringWithFormat:@"   %@",Localized(@"Delivery_status")];
    }
    return _labelExpressStatus;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]initWithFrame:CGRectMake(10, 35.f, SCREEN_WIDTH/2, 80.f)];
        _labelStatus.numberOfLines = 0;
        _labelStatus.lineBreakMode = NSLineBreakByCharWrapping;
        NSString* statusName = Localized(@"Order_unknow");
        NSString* str =[NSString stringWithFormat:@"%@\n%@",statusName,Localized(@"Can_touch_we")];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:theme_title_color,NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(0, statusName.length)];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:theme_Fourm_color,NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:NSMakeRange(statusName.length+1, str.length-statusName.length-1)];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        _labelStatus.attributedText = attributeStr;
        
    }
    return _labelStatus;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-10, 35.f, SCREEN_WIDTH/2, 80.f)];
        _labelCreateDate.numberOfLines = 0;
        _labelCreateDate.lineBreakMode = NSLineBreakByCharWrapping;
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
        
        NSString* createDate = [WMHelper convertToStringWithDate:[NSDate new] format:@"yyyy/MM/dd HH:mm:ss "];
        NSString* payWay = Localized(@"Payment_unknow");
        
        NSString*  str =[NSString stringWithFormat:@"%@\n%@",createDate,payWay];
        NSMutableAttributedString*   attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, [createDate length])];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:22/255.f green:162/255.f blue:51/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange([createDate length]+1,[payWay length])];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [paragraphStyle setAlignment:NSTextAlignmentRight];
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        _labelCreateDate.attributedText = attributeStr;
        
    }
    return _labelCreateDate;
}
-(UILabel *)labelDetail{
    if(!_labelDetail){
        _labelDetail = [[UILabel alloc]initWithFrame:CGRectMake(0, 115.f, SCREEN_WIDTH, 35.f)];
        _labelDetail.backgroundColor = [UIColor colorWithRed:231/255.f green:232/255.f blue:238/255.f alpha:1.0];
        _labelDetail.textColor = theme_Fourm_color;
        _labelDetail.font = [UIFont systemFontOfSize:14.f];
        _labelDetail.text = [NSString stringWithFormat:@"   %@",Localized(@"Order_detail")];
    }
    return _labelDetail;
}

-(UIButton *)btnStore{
    if(!_btnStore){
        _btnStore = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStore.frame = CGRectMake(0, 150.f, SCREEN_WIDTH, 45.f);
        
        _btnStore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnStore.imageEdgeInsets = UIEdgeInsetsMake(25/2, 15, 25/2, SCREEN_WIDTH-35);
        _btnStore.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_btnStore setImage:[UIImage imageNamed:@"icon-store-default"] forState:UIControlStateNormal];
        [_btnStore setTitleColor:[UIColor colorWithRed:72/255.f green:72/255.f blue:72/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnStore setTitle:@"supermarket" forState:UIControlStateNormal];
        _btnStore.titleLabel.font = [UIFont systemFontOfSize:16.f];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 44.5f, SCREEN_WIDTH,0.5f);
        border.backgroundColor = [UIColor colorWithRed:231/255.f green:232/255.f blue:238/255.f alpha:1.0].CGColor;
        [_btnStore.layer addSublayer:border];
    }
    return _btnStore;
}

-(UIView *)footerView{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 720.f)];
        _footerView.backgroundColor = theme_default_color;
    }
    return _footerView;
}

-(UIView *)fullCutView{
    if(!_fullCutView){
        _fullCutView = [[UIView alloc]init];
        _fullCutView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _fullCutView;
}

-(UILabel *)labelCutIcon{
    if(!_labelCutIcon){
        _labelCutIcon = [[UILabel alloc]init];
        _labelCutIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"icon-full-cut"]];;
        _labelCutIcon.font = [UIFont systemFontOfSize:14.f];
        _labelCutIcon.textColor = [UIColor whiteColor];
        _labelCutIcon.layer.masksToBounds = YES;
        _labelCutIcon.layer.cornerRadius = 3.f;
        _labelCutIcon.textAlignment = NSTextAlignmentCenter;
        _labelCutIcon.text =  Localized(@"Less_txt");
        _labelCutIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCutIcon;
}

-(UILabel *)labelCutTitle{
    if(!_labelCutTitle){
        _labelCutTitle = [[UILabel alloc]init];
        _labelCutTitle.font =[UIFont systemFontOfSize:14.f];
        _labelCutTitle.text = [NSString stringWithFormat:@"%@:",Localized(@"Full_redue")];
        _labelCutTitle.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelCutTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCutTitle;
}

-(UILabel *)labelFullCutPrice{
    if(!_labelFullCutPrice){
        _labelFullCutPrice = [[UILabel alloc]init];
        _labelFullCutPrice.text = @"$0.00";
        _labelFullCutPrice.textAlignment = NSTextAlignmentRight;
        _labelFullCutPrice.font = [UIFont systemFontOfSize:14.f];
        _labelFullCutPrice.textColor = [UIColor redColor];
        _labelFullCutPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelFullCutPrice;
}


-(UILabel *)labelPackge{
    if(!_labelPackge){
        _labelPackge = [[UILabel alloc]init];
        _labelPackge.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelPackge.font = [UIFont systemFontOfSize:14.f];
        _labelPackge.textAlignment = NSTextAlignmentLeft;
        _labelPackge.text =  Localized(@"Packing_fee");
    }
    return _labelPackge;
}

-(UILabel *)labelPackgeFee{
    if(!_labelPackgeFee){
        _labelPackgeFee = [[UILabel alloc]init];
        _labelPackgeFee.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelPackgeFee.font = [UIFont systemFontOfSize:14.f];
        _labelPackgeFee.textAlignment = NSTextAlignmentRight;
    }
    return _labelPackgeFee;
}

-(UILabel *)labelShip{
    if(!_labelShip){
        _labelShip = [[UILabel alloc]init];
        _labelShip.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelShip.font = [UIFont systemFontOfSize:14.f];
        _labelShip.textAlignment = NSTextAlignmentLeft;
        _labelShip.text =  Localized(@"Delivery_fee");
    }
    return _labelShip;
}

-(UILabel *)labelShipFee{
    if(!_labelShipFee){
        _labelShipFee =[[UILabel alloc]init];
        _labelShipFee.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelShipFee.font = [UIFont systemFontOfSize:14.f];
        _labelShipFee.textAlignment = NSTextAlignmentRight;
    }
    return _labelShipFee;
}

-(UILabel *)labelTip{
    if(!_labelTip){
        _labelTip = [[UILabel alloc]init];
        _labelTip.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelTip.font = [UIFont systemFontOfSize:14.f];
        _labelTip.textAlignment = NSTextAlignmentLeft;
        _labelTip.text =  Localized(@"Tip_txt");
    }
    return _labelTip;
}

-(UILabel *)labelTipFee{
    if(!_labelTipFee){
        _labelTipFee =[[UILabel alloc]init];
        _labelTipFee.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelTipFee.font = [UIFont systemFontOfSize:14.f];
        _labelTipFee.textAlignment = NSTextAlignmentRight;
    }
    return _labelTipFee;
}

-(UILabel *)labelTax{
    if(!_labelTax){
        _labelTax = [[UILabel alloc]init];
        _labelTax.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelTax.font = [UIFont systemFontOfSize:14.f];
        _labelTax.textAlignment = NSTextAlignmentLeft;
        _labelTax.text =  Localized(@"Tax_fee");
    }
    return _labelTax;
}

-(UILabel *)labelTaxFee{
    if(!_labelTaxFee){
        _labelTaxFee =[[UILabel alloc]init];
        _labelTaxFee.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelTaxFee.font = [UIFont systemFontOfSize:14.f];
        _labelTaxFee.textAlignment = NSTextAlignmentRight;
    }
    return _labelTaxFee;
}

-(UILabel *)labelDeposit{
    if(!_labelDeposit){
        _labelDeposit = [[UILabel alloc]init];
        _labelDeposit.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelDeposit.font = [UIFont systemFontOfSize:14.f];
        _labelDeposit.textAlignment = NSTextAlignmentLeft;
        _labelDeposit.text =  Localized(@"Deposit_price");
    }
    return _labelDeposit;
}

-(UILabel *)labelDepositFee{
    if(!_labelDepositFee){
        _labelDepositFee =[[UILabel alloc]init];
        _labelDepositFee.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelDepositFee.font = [UIFont systemFontOfSize:14.f];
        _labelDepositFee.textAlignment = NSTextAlignmentRight;
    }
    return _labelDepositFee;
}

-(UILabel *)labelSumPrice{
    if(!_labelSumPrice){
        _labelSumPrice = [[UILabel alloc]init];
        _labelSumPrice.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelSumPrice.textAlignment = NSTextAlignmentRight;
        _labelSumPrice.font = [UIFont systemFontOfSize:15.f];
        _labelSumPrice.text = [NSString stringWithFormat:@"%@    $%@",Localized(@"Product_price"),@"0.00"];
    }
    return _labelSumPrice;
}

-(UILabel *)labelOther{
    if(!_labelOther){
        _labelOther = [[UILabel alloc]init];
        _labelOther.backgroundColor = [UIColor colorWithRed:231/255.f green:232/255.f blue:238/255.f alpha:1.0];
        _labelOther.textColor = theme_Fourm_color;
        _labelOther.font = [UIFont systemFontOfSize:14.f];
        _labelOther.text = [NSString stringWithFormat:@"   %@",Localized(@"Other_info")];
    }
    return _labelOther;
}

-(UITextField *)txtExpressMan{
    if(!_txtExpressMan){
        _txtExpressMan = [[UITextField alloc]init];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 0, 80, 45.f);
        label.font = [UIFont systemFontOfSize:16.f];
        label.textColor = [UIColor colorWithRed:5/255.f green:5/255.f blue:5/255.f alpha:1.0];
        label.text = [NSString stringWithFormat:@"   %@:",Localized(@"Delivery_person")];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 44.5f, SCREEN_WIDTH,0.5f);
        border.backgroundColor = [UIColor colorWithRed:208/255.f green:207/255.f blue:213/255.f alpha:1.0].CGColor;
        [_txtExpressMan.layer addSublayer:border];
        _txtExpressMan.borderStyle = UITextBorderStyleNone;
        _txtExpressMan.leftView = label;
        _txtExpressMan.leftViewMode =UITextFieldViewModeAlways;
        _txtExpressMan.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtExpressMan.autocapitalizationType= UITextAutocapitalizationTypeAllCharacters;
        _txtExpressMan.placeholder = Localized(@"No_deli_person");
        _txtExpressMan.font = [UIFont systemFontOfSize:14.f];
        _txtExpressMan.enabled = NO;
        _txtExpressMan.textColor  = theme_Fourm_color;
    }
    return _txtExpressMan;
}

-(UITextField *)txtOrderNO{
    if(!_txtOrderNO){
        _txtOrderNO = [[UITextField alloc]init];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 0, 80, 45.f);
        label.font = [UIFont systemFontOfSize:16.f];
        label.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
        label.text = [NSString stringWithFormat:@"   %@:",Localized(@"Order_num")];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 44.5f, SCREEN_WIDTH,0.5f);
        border.backgroundColor = [UIColor colorWithRed:208/255.f green:207/255.f blue:213/255.f alpha:1.0].CGColor;
        [_txtOrderNO.layer addSublayer:border];
        _txtOrderNO.borderStyle = UITextBorderStyleNone;
        _txtOrderNO.leftView = label;
        _txtOrderNO.leftViewMode =UITextFieldViewModeAlways;
        _txtOrderNO.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtOrderNO.autocapitalizationType= UITextAutocapitalizationTypeAllCharacters;
        _txtOrderNO.placeholder = Localized(@"No_order_num");
        _txtOrderNO.font = [UIFont systemFontOfSize:14.f];
        _txtOrderNO.enabled = NO;
        _txtOrderNO.textColor  = theme_Fourm_color;
    }
    return _txtOrderNO;
}

-(UITextField *)txtExpressDate{
    if(!_txtExpressDate){
        _txtExpressDate =[[UITextField alloc]init];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 90, 45.f);
        label.font = [UIFont systemFontOfSize:16.f];
        label.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
        label.text = [NSString stringWithFormat:@"   %@:",Localized(@"Delivery_time")];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 44.5f, SCREEN_WIDTH,0.5f);
        border.backgroundColor = [UIColor colorWithRed:208/255.f green:207/255.f blue:213/255.f alpha:1.0].CGColor;
        [_txtExpressDate.layer addSublayer:border];
        _txtExpressDate.borderStyle = UITextBorderStyleNone;
        _txtExpressDate.leftView = label;
        _txtExpressDate.leftViewMode =UITextFieldViewModeAlways;
        _txtExpressDate.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtExpressDate.autocapitalizationType= UITextAutocapitalizationTypeAllCharacters;
        _txtExpressDate.placeholder = Localized(@"No_deli_time");
        _txtExpressDate.font = [UIFont systemFontOfSize:14.f];
        _txtExpressDate.enabled = NO;
        _txtExpressDate.textColor  = theme_Fourm_color;
        
    }
    return _txtExpressDate;
}

-(UITextField *)txtAddress{
    if(!_txtAddress){
        _txtAddress = [[UITextField alloc]init];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 90, 55.f);
        label.font = [UIFont systemFontOfSize:16.f];
        label.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
        NSMutableAttributedString*   attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"   %@:\n",Localized(@"Rece_info")]];
        label.attributedText = attributeStr;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        _txtShoppingAddress = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-90, 50)];
        _txtShoppingAddress.textColor  = theme_Fourm_color;
        _txtShoppingAddress.font = [UIFont systemFontOfSize:14.f];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 54.5f, SCREEN_WIDTH,0.5f);
        border.backgroundColor = [UIColor colorWithRed:208/255.f green:207/255.f blue:213/255.f alpha:1.0].CGColor;
        [_txtAddress.layer addSublayer:border];
        _txtAddress.borderStyle =  UITextBorderStyleNone;
        _txtAddress.leftView = label;
        _txtAddress.leftViewMode =UITextFieldViewModeAlways;
        _txtAddress.rightViewMode = UITextFieldViewModeAlways;
        _txtAddress.rightView = self.txtShoppingAddress;
        _txtAddress.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtAddress.autocapitalizationType= UITextAutocapitalizationTypeAllCharacters;
        _txtShoppingAddress.text =Localized(@"No_rece_info");
        _txtAddress.enabled = NO;
        [_txtShoppingAddress setEditable:NO];
        _txtShoppingAddress.textAlignment = NSTextAlignmentLeft;
        
    }
    return _txtAddress;
}

-(UITextField *)txtPayWay{
    if(!_txtPayWay){
        _txtPayWay =[[UITextField alloc]init];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 90, 45.f);
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
        label.text = [NSString stringWithFormat:@"   %@:",Localized(@"Payment_method")];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 44.5f, SCREEN_WIDTH,0.5f);
        border.backgroundColor = [UIColor colorWithRed:208/255.f green:207/255.f blue:213/255.f alpha:1.0].CGColor;
        [_txtPayWay.layer addSublayer:border];
        _txtPayWay.borderStyle = UITextBorderStyleNone;
        _txtPayWay.leftView = label;
        _txtPayWay.leftViewMode =UITextFieldViewModeAlways;
        _txtPayWay.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtPayWay.autocapitalizationType= UITextAutocapitalizationTypeAllCharacters;
        _txtPayWay.placeholder = Localized(@"No_payment_method");
        _txtPayWay.enabled = NO;
        _txtPayWay.font = [UIFont systemFontOfSize:14.f];
        _txtPayWay.textColor  = theme_Fourm_color;
    }
    return _txtPayWay;
}

-(UIView *)deliverView{
    if(!_deliverView){
        _deliverView = [[UIView alloc] init];
        _deliverView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _deliverView;
}

@end
