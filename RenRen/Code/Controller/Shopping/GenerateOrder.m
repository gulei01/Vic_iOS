//
//  GenerateOrder.m
//  KYRR
//
//  Created by kyjun on 15/11/5.
//
//

#import "GenerateOrder.h"
#import "AppDelegate.h"
#import "GenerateOrderCell.h"
#import <CommonCrypto/CommonDigest.h>
#import "payRequsestHandler.h"
#import "AlipayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "WXApi.h"
#import "CreditPay.h"
#import "Agreement.h"


@interface GenerateOrder ()<UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIButton* lineTop;
@property(nonatomic,strong) UIButton* lineBottom;
@property(nonatomic,strong) UIImageView* lineblock;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelAddress;
@property(nonatomic,strong) UIImageView* photoLociation;

@property(nonatomic,strong) UIButton* btnSection;

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NSArray* arrayGoods;
@property(nonatomic,strong) NSArray* arrayRed;
/**
 *  送达时间
 */
@property(nonatomic,copy) NSString* expect_time;

@property(nonatomic,strong) UIView* footerView;
@property(nonatomic,strong) UIButton* btnSectionPay;

@property(nonatomic,strong) UIButton* btnWeXinPay;
@property(nonatomic,strong) UIImageView* imgWeiXin;
@property(nonatomic,strong) UIButton* btnAlipay;
@property(nonatomic,strong) UIImageView* imgAli;
@property(nonatomic,strong) UIButton* btnFacePay;
@property(nonatomic,strong) UIImageView* imgFace;
@property(nonatomic,strong) UIButton* btnCredit;
@property(nonatomic,strong) UIImageView* imgCredit;

@property(nonatomic,strong) UIView* tipView;
@property(nonatomic,strong) UILabel* tipLabel;
@property(nonatomic,strong) UILabel* tipFeeLabel;
@property(nonatomic,strong) UISegmentedControl* tipSeg;
@property(nonatomic,strong) UITextField* tipTxt;

@property(nonatomic,assign) double tip_fee;

@property(nonatomic,strong) UIView* sumView;
/**
 *  商品金额
 */
@property(nonatomic,strong) UILabel* labelGoodsPriceTitle;
@property(nonatomic,strong) UILabel* labelGoodsPrice;
/**
 *  满减优惠
 */
@property(nonatomic,strong) UIView* fullCutView;
@property(nonatomic,strong) NSLayoutConstraint* fullCutConstraint;
@property(nonatomic,strong) UILabel* labelCutIcon;
@property(nonatomic,strong) UILabel* labelCutTitle;
@property(nonatomic,strong) UILabel* labelFullCutPrice;
/**
 *  优惠价格
 */
@property(nonatomic,strong) UILabel* labelDiscountPriceTitle;
@property(nonatomic,strong) UILabel* labelDiscountPrice;
/**
 *  配送费
 */
@property(nonatomic,strong) UILabel* labelExpectPriceTitle;
@property(nonatomic,strong) UILabel* labelExpectPrice;
/**
 *  打包费
 */
@property(nonatomic,strong) UILabel* labelPackage;
@property(nonatomic,strong) UILabel* labelPackagePrice;

/**
 * 税费
 */
@property(nonatomic,strong) UILabel* labelTax;
@property(nonatomic,strong) UILabel* labelTaxNum;

/**
 * 用户协议
 */
@property(nonatomic,strong) UIButton* agreementBtn;
@property(nonatomic,strong) UIButton* agreementTxt;
/**
 *  应付总金额
 */
@property(nonatomic,strong) UILabel* labelSumPriceTitle;
@property(nonatomic,strong) UILabel* labelSumPrice;
@property(nonatomic,strong) UIButton*   btnPay;

/**
 *  商品总金额
 */
@property(nonatomic,assign) double goodsSumPrice;

/**
 *  应付总金额
 */
@property(nonatomic,assign) double paySumPrice;
/**
 *  货到付款金额(线下支付金额)
 */
@property(nonatomic,assign) double offLinePrice;
/**
 *  在线支付金额
 */
@property(nonatomic,assign) double onLinePrice;

@property(nonatomic,assign) double packagePrice;

@property(nonatomic,assign) double shipPrice;
/**
 *  满减金额
 */
@property(nonatomic,assign) double fullCut;
/**
 *  优惠金额 (红包)
 */
@property(nonatomic,assign) double discountPrice;
//税费
@property(nonatomic,assign) double taxPrice;

@property(nonatomic,copy) NSString* orderNo;

@property(nonatomic,strong) NSString* remark;
@property(nonatomic,strong) UITextField* txtRemark;
/**
 *  红包选择器
 */
@property(nonatomic,strong) UIPickerView* redPickerView;
@property(nonatomic,strong) UITextField* txtRedPicker;
@property(nonatomic,assign) NSInteger redIndex;//红包下标默认为0
@property(nonatomic,assign) BOOL useRed;//是否使用红包 默认 NO

//商品口味
@property(nonatomic,strong) NSMutableArray *arrayGoodsTaste;
@property(nonatomic,assign) int tasteCount;
@property(nonatomic,assign) int stockCount;
@property(nonatomic,assign) int oldY;


@property(nonatomic,assign) int flag;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UILabel *remarkLable;

@property(nonatomic,strong)NSString *endString;

@property(nonatomic,assign)int myFontSize;

@property(nonatomic,assign)BOOL isHaveDian;
@end

@implementation GenerateOrder

-(instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
         
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_endString = @"全部口味默认";
    _endString = @"";
    
    self.discountPrice = 0.00;
    self.fullCut = 0.00;
    self.remark = @"";
    [self layoutUI];
    [self layoutConstraints];
    self.redIndex = 0;
    self.useRed = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    MAddress* item = delegate.globalAddress;
    self.photoLociation.image = [UIImage imageNamed:@"icon-address"];
    self.labelUserName.text = [NSString stringWithFormat:@"%@:%@ %@",Localized(@"Receiver_txt"),item.userName,item.phoneNum];
    self.labelAddress.text = [NSString stringWithFormat:@"%@:%@ %@ %@. Postal Code:%@",Localized(@"Shipping_address"),item.zoneName,item.address,item.mapLocation,item.mapNumber];
    
    [self refreshDataSource];
    [self btnPayWay:self.btnFacePay];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNotification:) name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payUserCancelNotification:) name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayFailureNotification:) name:NotificationPayFailure object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBackNotification:) name:NotificationAppBack object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _tasteCount = 0;
    _myFontSize = 13;
    self.navigationItem.title = Localized(@"Submit_order");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Localized(@"Cancel_txt") style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
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


#pragma mark =====================================================  试图布局
-(void)layoutUI{
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = theme_default_color;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80.f);
    
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
    self.labelAddress.numberOfLines = 2;
    self.labelAddress.lineBreakMode = NSLineBreakByCharWrapping;
    [self.headerView addSubview:self.labelAddress];
    
    
    self.lineBottom = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lineBottom.userInteractionEnabled = NO;
    self.lineBottom.backgroundColor = [UIColor colorWithPatternImage:image];
    [self.headerView addSubview:self.lineBottom];
    
    self.lineblock = [[UIImageView alloc]init];
    self.lineblock.backgroundColor = theme_line_color;
    [self.headerView addSubview:self.lineblock];
    
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 425)];
    self.btnSectionPay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSectionPay.backgroundColor = theme_default_color;
    self.btnSectionPay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnSectionPay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
    self.btnSectionPay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnSectionPay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    [self.btnSectionPay setTitle:Localized(@"Payment_method") forState:UIControlStateNormal];
    self.btnSectionPay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.footerView addSubview:self.btnSectionPay];
    
    self.btnWeXinPay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnWeXinPay.backgroundColor = theme_default_color;
    self.btnWeXinPay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnWeXinPay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
    self.btnWeXinPay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnWeXinPay setImage:[UIImage imageNamed:@"icon-wechat-pay"] forState:UIControlStateNormal];
    [self.btnWeXinPay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    [self.btnWeXinPay setTitle:Localized(@"Wexin_payment") forState:UIControlStateNormal];
    self.btnWeXinPay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.btnWeXinPay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.btnWeXinPay];
    self.btnWeXinPay.hidden = YES;//garfunkel add
    
    self.imgWeiXin = [[UIImageView alloc]init];
    [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
    [self.btnWeXinPay addSubview:self.imgWeiXin];
    
    self.btnAlipay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAlipay.backgroundColor =theme_default_color;
    self.btnAlipay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnAlipay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
    self.btnAlipay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnAlipay setImage:[UIImage imageNamed:@"icon-alipay"] forState:UIControlStateNormal];
    [self.btnAlipay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    [self.btnAlipay setTitle:Localized(@"Alipay_payment") forState:UIControlStateNormal];
    self.btnAlipay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.btnAlipay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.btnAlipay];
    self.btnAlipay.hidden = YES;//garfunkel add
    
    self.imgAli = [[UIImageView alloc]init];
    [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
    [self.btnAlipay addSubview:self.imgAli];
    
    self.btnFacePay = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.btnFacePay.hidden = YES;
    [self.btnFacePay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Offline_payment")];
    
//    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[@"货到付款(在线付款享受折扣价)" rangeOfString:@"在线付款享受折扣价"]];
    [self.btnFacePay setAttributedTitle:attributeStr forState:UIControlStateNormal];
    self.btnFacePay.backgroundColor =theme_default_color;
    self.btnFacePay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnFacePay.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.btnFacePay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.btnFacePay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.btnFacePay];
    
    self.imgFace = [[UIImageView alloc]init];
    [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
    [self.btnFacePay addSubview:self.imgFace];
    
    self.btnCredit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCredit setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* creditStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Payment_online")];
    [self.btnCredit setAttributedTitle:creditStr forState:UIControlStateNormal];
    self.btnCredit.backgroundColor =theme_default_color;
    self.btnCredit.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnCredit.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.btnCredit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.btnCredit addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.btnCredit];
    
    self.imgCredit = [[UIImageView alloc]init];
    [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
    [self.btnCredit addSubview:self.imgCredit];
    
    self.sumView = [[UIView alloc]init];
    self.sumView.backgroundColor = theme_default_color;
    [self.footerView addSubview:self.sumView];
    
    self.labelGoodsPriceTitle = [[UILabel alloc]init];
    self.labelGoodsPriceTitle.text = [NSString stringWithFormat:@"%@:",Localized(@"Product_price")];
    [self.sumView addSubview:self.labelGoodsPriceTitle];
    
    self.labelGoodsPrice = [[UILabel alloc]init];
    self.labelGoodsPrice.text =@"$0.00";
    self.labelGoodsPrice.textAlignment = NSTextAlignmentRight;
    [self.sumView addSubview:self.labelGoodsPrice];
    
    [self.sumView addSubview:self.fullCutView];
    [self.fullCutView addSubview:self.labelCutIcon];
    [self.fullCutView addSubview:self.labelCutTitle];
    [self.fullCutView addSubview:self.labelFullCutPrice];
    
    self.labelDiscountPriceTitle = [[UILabel alloc]init];
    self.labelDiscountPriceTitle.text = [NSString stringWithFormat:@"%@:",Localized(@"Disc_price")];
    [self.sumView addSubview:self.labelDiscountPriceTitle];
    
    self.labelDiscountPrice = [[UILabel alloc]init];
    self.labelDiscountPrice.text = @"$0.00";
    self.labelDiscountPrice.textAlignment = NSTextAlignmentRight;
    self.labelDiscountPrice.textColor = [UIColor redColor];
    [self.sumView addSubview:self.labelDiscountPrice];
    
    self.labelExpectPriceTitle = [[UILabel alloc]init];
    self.labelExpectPriceTitle.text = [NSString stringWithFormat:@"%@:",Localized(@"Delivery_fee")];
    [self.sumView addSubview:self.labelExpectPriceTitle];
    
    self.labelExpectPrice = [[UILabel alloc]init];
    self.labelExpectPrice.text = @"$0.00";
    self.labelExpectPrice.textAlignment = NSTextAlignmentRight;
    [self.sumView addSubview:self.labelExpectPrice];
    
    [self.sumView addSubview:self.labelPackage];
    [self.sumView addSubview:self.labelPackagePrice];
    
    self.labelTax = [[UILabel alloc]init];
    self.labelTax.text = [NSString stringWithFormat:@"%@:",Localized(@"Tax_fee")];
    [self.sumView addSubview:self.labelTax];
    
    self.labelTaxNum = [[UILabel alloc]init];
    self.labelTaxNum.text = @"5%";
    self.labelTaxNum.textAlignment = NSTextAlignmentRight;
    [self.sumView addSubview:self.labelTaxNum];
    
    self.labelSumPriceTitle = [[UILabel alloc]init];
    self.labelSumPriceTitle.text = [NSString stringWithFormat:@"%@:",Localized(@"Subtotal_price")];
    [self.sumView addSubview:self.labelSumPriceTitle];
    
    self.labelSumPrice = [[UILabel alloc]init];
    self.labelSumPrice.text =  @"$0.00";
    self.labelSumPrice.textColor=[UIColor redColor];
    self.labelSumPrice.textAlignment = NSTextAlignmentRight;
    [self.sumView addSubview:self.labelSumPrice];
    
    self.agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.agreementBtn setImage:[UIImage imageNamed:@"icon-agreement-default"] forState:UIControlStateNormal];
    [self.agreementBtn setImage:[UIImage imageNamed:@"icon-agreement-enter"] forState:UIControlStateSelected];
    self.agreementBtn.selected = YES;
    [self.agreementBtn addTarget:self action:@selector(agreement) forControlEvents:UIControlEventTouchUpInside];
    [self.sumView addSubview:self.agreementBtn];
    
    self.agreementTxt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.agreementTxt setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* agreementStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Agreement_memo")];
    [self.agreementTxt setAttributedTitle:agreementStr forState:UIControlStateNormal];
    [agreementStr addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[agreementStr length]}];
    self.agreementTxt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.agreementTxt.backgroundColor =theme_default_color;
    self.agreementTxt.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.agreementTxt.contentEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 0);
    self.agreementTxt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.agreementTxt addTarget:self action:@selector(agreementMemo) forControlEvents:UIControlEventTouchUpInside];
    [self.sumView addSubview:self.agreementTxt];
    
    self.btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPay.backgroundColor = [UIColor redColor];
    [self.btnPay setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.btnPay setTitle:Localized(@"Submit_order") forState:UIControlStateNormal];
    self.btnPay.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.btnPay.layer.masksToBounds = YES;
    self.btnPay.layer.cornerRadius = 5.f;
    [self.btnPay addTarget:self action:@selector(generalOrderTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.sumView addSubview:self.btnPay];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.redPickerView =[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.redPickerView.showsSelectionIndicator = YES;
    self.redPickerView.dataSource = self;
    self.redPickerView.delegate = self;
    
    self.txtRedPicker = [[UITextField alloc]init];
    self.txtRedPicker.layer.borderColor = theme_line_color.CGColor;
    self.txtRedPicker.layer.borderWidth = 1.f;
    self.txtRedPicker.layer.masksToBounds = YES;
    self.txtRedPicker.layer.cornerRadius = 5.f;
    UIButton* btn  =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 26, 10);
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [btn setImage:[UIImage imageNamed:@"icon-arrow-bottom-default"] forState:UIControlStateNormal];
    self.txtRedPicker.rightView = btn;
    self.txtRedPicker.rightViewMode=UITextFieldViewModeAlways;
    self.txtRedPicker.inputView =self.redPickerView;
    self.txtRedPicker.textAlignment = NSTextAlignmentCenter;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.txtRedPicker.inputAccessoryView = toolBar;
    
    self.tipView = [[UIView alloc]init];
    self.tipView.backgroundColor =theme_default_color;
    [self.footerView addSubview:self.tipView];
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.text = Localized(@"Tip_txt");
    [self.tipView addSubview:self.tipLabel];
    
    self.tipFeeLabel = [[UILabel alloc] init];
    self.tipFeeLabel.text = @"$0.00";
    [self.tipView addSubview:self.tipFeeLabel];
    
    self.tipSeg = [[UISegmentedControl alloc] init];
    [self.tipSeg insertSegmentWithTitle:@"15%" atIndex:0 animated:true];
    [self.tipSeg insertSegmentWithTitle:@"20%" atIndex:1 animated:true];
    [self.tipSeg insertSegmentWithTitle:@"25%" atIndex:2 animated:true];
    self.tipSeg.layer.borderColor = theme_navigation_color.CGColor;
    self.tipSeg.tintColor = theme_navigation_color;
    [self.tipSeg setSelectedSegmentIndex:0];
    
    [self.tipSeg addTarget:self action:@selector(tip_select) forControlEvents:UIControlEventValueChanged];
    
    [self.tipView addSubview:self.tipSeg];
    
    self.tipTxt = [[UITextField alloc] init];
    self.tipTxt.leftView = [self leftView:[NSString stringWithFormat:@"  %@:$",Localized(@"Self_tip")]];
    self.tipTxt.leftViewMode =UITextFieldViewModeAlways;
    self.tipTxt.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.tipTxt.placeholder = @"0.00";
    self.tipTxt.layer.masksToBounds = YES;
    self.tipTxt.layer.cornerRadius = 5.f;
    self.tipTxt.backgroundColor = theme_line_color;
    self.tipTxt.delegate = self;
    [self.tipTxt addTarget:self action:@selector(changeTip) forControlEvents:UIControlEventEditingChanged];
    
    [self.tipView addSubview:self.tipTxt];
}
-(void)layoutConstraints{
    self.lineTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoLociation.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineBottom.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineblock.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnSection.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.lineTop addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.lineTop addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.photoLociation addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLociation attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.photoLociation addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLociation attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
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
    
    [self.lineBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.lineBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelAddress attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.lineblock addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
    [self.lineblock addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineBottom attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineblock attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    self.btnSectionPay.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnWeXinPay.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAlipay.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnFacePay.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnCredit.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgWeiXin.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgAli.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgFace.translatesAutoresizingMaskIntoConstraints  = NO;
    self.imgCredit.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tipView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipFeeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipSeg.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipTxt.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.sumView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelGoodsPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelGoodsPriceTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDiscountPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDiscountPriceTitle.translatesAutoresizingMaskIntoConstraints =NO;
    self.labelExpectPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelExpectPriceTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPackage.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPackagePrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTax.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTaxNum.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumPriceTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.agreementBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.agreementTxt.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnSectionPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSectionPay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnSectionPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSectionPay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSectionPay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSectionPay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnFacePay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFacePay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnFacePay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFacePay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFacePay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnSectionPay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFacePay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.imgFace addConstraint:[NSLayoutConstraint constraintWithItem:self.imgFace attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.imgFace addConstraint:[NSLayoutConstraint constraintWithItem:self.imgFace attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnFacePay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgFace attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnFacePay attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnFacePay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgFace attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnFacePay attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.btnCredit addConstraint:[NSLayoutConstraint constraintWithItem:self.btnCredit attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnCredit addConstraint:[NSLayoutConstraint constraintWithItem:self.btnCredit attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnCredit attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnFacePay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnCredit attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.imgCredit addConstraint:[NSLayoutConstraint constraintWithItem:self.imgCredit attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.imgCredit addConstraint:[NSLayoutConstraint constraintWithItem:self.imgCredit attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnCredit addConstraint:[NSLayoutConstraint constraintWithItem:self.imgCredit attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnCredit attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnCredit addConstraint:[NSLayoutConstraint constraintWithItem:self.imgCredit attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnCredit attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:115.f]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnCredit attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipFeeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipFeeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.tipSeg addConstraint:[NSLayoutConstraint constraintWithItem:self.tipSeg attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:30.f]];
    [self.tipSeg addConstraint:[NSLayoutConstraint constraintWithItem:self.tipSeg attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH - 20]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipSeg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tipLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipSeg attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.tipTxt addConstraint:[NSLayoutConstraint constraintWithItem:self.tipTxt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH - 20]];
    [self.tipTxt addConstraint:[NSLayoutConstraint constraintWithItem:self.tipTxt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:35.f]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipTxt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tipSeg attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipTxt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnFacePay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeXinPay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.imgWeiXin addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.imgWeiXin addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnWeXinPay attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnWeXinPay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgWeiXin attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnWeXinPay attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnWeXinPay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAlipay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.imgAli addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.imgAli addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnAlipay attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnAlipay addConstraint:[NSLayoutConstraint constraintWithItem:self.imgAli attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnAlipay attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:265.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    //只有线下支付，恢复在线支付是 toItem：btnAlipay
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tipView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelGoodsPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPriceTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelGoodsPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPriceTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPriceTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPriceTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelGoodsPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelGoodsPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelGoodsPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    
    self.fullCutConstraint = [NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f];
    self.fullCutConstraint.priority = 701;
    [self.fullCutView addConstraint:self.fullCutConstraint];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelGoodsPriceTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
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
    
    [self.labelExpectPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPriceTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelExpectPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPriceTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPriceTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPriceTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelExpectPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelExpectPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullCutView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpectPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelPackage addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelPackage addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelExpectPriceTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelPackagePrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackagePrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelPackagePrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackagePrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackagePrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelExpectPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPackagePrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelDiscountPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPriceTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelDiscountPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPriceTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPriceTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPackage attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPriceTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelDiscountPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelDiscountPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPackagePrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDiscountPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelTax addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTax addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelDiscountPriceTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTax attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelTaxNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTaxNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxNum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelDiscountPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTaxNum attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelSumPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPriceTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelSumPriceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPriceTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPriceTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTax attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPriceTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelSumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelSumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTaxNum attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.agreementBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:26.f]];
    [self.agreementBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:26.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelSumPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.agreementTxt addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementTxt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH - 56]];
    [self.agreementTxt addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementTxt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:30.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementTxt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelSumPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.agreementTxt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.agreementBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.btnPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnPay addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-30.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.sumView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sumView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15.f]];
    
    
}

//自己更改添加口味添加数据
-(void)queryData{
    
    //cer_type 3:安卓，2：苹果；
    NSLog(@"garfunkel_log:cart_list:%@",self.carJson);
//    NSDictionary* arg = @{@"ince":@"new_order_sure",@"uid":self.Identity.userInfo.userID,@"cart_list":self.carJson,@"cer_type":@"2"};
    NSDictionary* arg = @{@"a":@"confirmCart",@"uid":self.Identity.userInfo.userID,@"cart_list":self.carJson,@"cer_type":@"2"};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        [self.arrayData removeAllObjects];
        if(react == 1){
            self.expect_time = [response objectForKey:@"expect_time"];
            self.arrayGoods = [response objectForKey:@"info"];
            self.arrayRed  = [response objectForKey:@"hongbao"];
            
            NSMutableArray *myArray = [[NSMutableArray alloc]init];
            
            [self.arrayGoods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *string = [obj objectForKey:@"attr"];
                
                if (![WMHelper isNULLOrnil:string]) {
                    
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    
                    NSDictionary *attrDic = @{@"index":[NSString stringWithFormat:@"%ld",(long)idx],@"attr":[obj objectForKey:@"attr"],@"stock":[obj objectForKey:@"stock"],@"fname":[obj objectForKey:@"fname"],@"price":[obj objectForKey:@"price"],@"size":array};

                   [myArray addObject:attrDic];
                    
  
                }
                NSLog(@"我的口味字符串%@",string);
            }];
            
            int count = 0;
            
            for (NSDictionary *tempDic in myArray) {
                
                 count += ([tempDic[@"stock"] intValue]);

            }
            
            _stockCount = count;
            
            NSLog(@"我的口味个数%d",_stockCount);
                    
            int sum = 0;
            NSMutableArray *endArray = [[NSMutableArray alloc]init];
            
            if (myArray.count > 1) {
                
                NSMutableArray *array = [[NSMutableArray alloc]init];
                NSDictionary *endDic = @{@"index":myArray[0][@"index"],@"attr":myArray[0][@"attr"],@"stock":myArray[0][@"stock"],@"fname":myArray[0][@"fname"],@"size":array};
                
                [endArray addObject:endDic];
                
                for (int i = 0; i < myArray.count; i++) {
                    
                    
                    if (i + 1 == myArray.count) {
                        break ;
                    }
                    
                    if (i == 0) {
                        
                        sum += [myArray[i][@"index"] intValue] + [myArray[i][@"stock"] intValue] + [myArray[i+1][@"index"] intValue] - [myArray[i][@"index"] intValue];
                        
                    }else {
                        
                        sum += [myArray[i][@"stock"] intValue]+1;
                    }
                    NSMutableArray *array = [[NSMutableArray alloc]init];

                    NSDictionary *endDic = @{@"index":[NSString stringWithFormat:@"%d",sum],@"attr":myArray[i+1][@"attr"],@"stock":myArray[i+1][@"stock"],@"fname":myArray[i+1][@"fname"],@"size":array};
                    
                    [endArray addObject:endDic];
                    
                    
                };
                
                _arrayGoodsTaste = [NSMutableArray arrayWithArray:endArray];
                
            }else {
            
                _arrayGoodsTaste = [NSMutableArray arrayWithArray:myArray];
               
            }
            
            [self.arrayData addObject:self.arrayGoods];
            [self.arrayData addObject:[[NSArray alloc]init]];
            if(self.arrayRed.count>0)
                [self.arrayData addObject:self.arrayRed];
            
            self.offLinePrice =[[response objectForKey:@"total_market_price"] doubleValue];//线下支付等于市场价格
            self.onLinePrice = [[response objectForKey:@"food_total_price"] doubleValue];//在线支付
            self.packagePrice = [[response objectForKey:@"packing_fee"] doubleValue];//打包费用
            self.shipPrice = [[response objectForKey:@"ship_fee"] doubleValue];//配送费用
            
            
            self.fullCut = [[response objectForKey: @"full_discount"]doubleValue]; //满减金额
            if(self.fullCut>0.00){
                /* dispatch_async(dispatch_get_main_queue(), ^{
                 if(self.fullCutConstraint){
                 [self.fullCutView removeConstraint:self.fullCutConstraint];
                 self.fullCutConstraint = [NSLayoutConstraint constraintWithItem:self.fullCutView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f];
                 self.fullCutConstraint.priority = 751;
                 [self.fullCutView addConstraint:self.fullCutConstraint];
                 }
                 });*/
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
            self.goodsSumPrice = self.onLinePrice;
//            self.paySumPrice =self.onLinePrice+self.packagePrice+self.shipPrice;
            //加上税费后的实际需要支付的金额
            self.paySumPrice = [[response objectForKey: @"total_pay_price"]doubleValue];
            self.taxPrice = self.paySumPrice - (self.onLinePrice + self.shipPrice + self.packagePrice);
            [self updatePrice];
            
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
    [self showHUD];
    __weak typeof(self) weakSelf = (id)self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                [weakSelf queryData];
            }else
                [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  UITableView  协议实现

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if( self.btnFacePay.selected)
        return 2;
    
    return self.arrayData.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0 )
//        + count>0?count:0
//        + _stockCount
        return self.arrayGoods.count + _stockCount;
    
    else if (section==1)
        return 1;
    else if (section == 2 )
        return 1;
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && self.arrayGoodsTaste.count) {
        
        return 30;
    }
    
    if (indexPath.section == 1) {
        
//        _remarkLable.bounds.size.height
        return 45 + _remarkLable.bounds.size.height;
        
    }
    return 45.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //MStore* item = self.arrayData[section];
    UIButton* btnSection = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSection.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.f);
    btnSection.backgroundColor = theme_default_color;
    btnSection.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnSection.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
    btnSection.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [btnSection setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    
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
    if(section==0){
        [btnSection setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        [btnSection setTitle:Localized(@"Order_info") forState:UIControlStateNormal];
    }else if (section==1){
        [btnSection setImage:[UIImage imageNamed:@"icon-time"] forState:UIControlStateNormal];
        [btnSection setTitle:Localized(@"Esti_deli_time") forState:UIControlStateNormal];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(SCREEN_WIDTH-150, 0, 140, 40);
        label.text = [NSString stringWithFormat:@"%@",self.expect_time];
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:12.f];
        label.textAlignment = NSTextAlignmentRight;
        [btnSection addSubview:label];
        
    }else if (section ==2){
        [btnSection setImage:[UIImage imageNamed:@"icon-preferential"] forState:UIControlStateNormal];
        [btnSection setTitle:Localized(@"Use_Coupon") forState:UIControlStateNormal];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(SCREEN_WIDTH-150, 0, 140, 40);
        label.text = self.useRed?Localized(@"Used_txt"):Localized(@"Unused_txt");
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.textAlignment = NSTextAlignmentRight;
        [btnSection addSubview:label];
    }
    
    return btnSection;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        
        GenerateOrderCell* cell = (GenerateOrderCell*) [tableView dequeueReusableCellWithIdentifier:@"GenerateOrderCell"];
        if(!cell)
            cell = [[GenerateOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenerateOrderCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = theme_line_color;
//        lineView.alpha = 0.4;
        [cell addSubview:lineView];
        
        if (_arrayGoodsTaste.count && !_oldY) {
            
            int space = 0;
            
            for (int i = 0; i < _arrayGoodsTaste.count; i++) {
                
//                if (indexPath.row == [_arrayGoodsTaste[i][@"index"] intValue]) {
//                    
//                    UIButton *guigeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 5, 100, 20)];
//                    [guigeBtn setTitle:@"规格" forState:UIControlStateNormal];
//                    guigeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//                    
//                    guigeBtn.tag = indexPath.row;
//                    
//                    [guigeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                    
//                    [guigeBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//                    
//                    [guigeBtn addTarget:self action:@selector(guigeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//                   
//                    [cell addSubview:guigeBtn];
//                    
//                }
                
//                NSLog(@"我存储的下标是%d,个数是%d",[_arrayGoodsTaste[i][@"index"] intValue],[_arrayGoodsTaste[i][@"stock"] intValue]);
                
                
                    if (indexPath.row > [_arrayGoodsTaste[i][@"index"] intValue] && indexPath.row < [_arrayGoodsTaste[i][@"index"] intValue]+[_arrayGoodsTaste[i][@"stock"] intValue] + 1) {
                        
                        cell.tag = [_arrayGoodsTaste[i][@"index"] intValue];
                        
                        [self creatGoodsTasteBtn:cell tasteStr:_arrayGoodsTaste[i][@"attr"] indexPath:indexPath];
                        
                        _tasteCount++;
                        
                        break;
                        
                    }else{
//                        NSLog(@"通过计算得出的cell的indexPath值%ld,self.arrayGoods的长度%ld",indexPath.row,self.arrayGoods.count);
                        
                        if (indexPath.row - _tasteCount >= _arrayGoods.count) {
                            
                        }else {
                         
                            
                        [cell setItemWithDict: self.arrayGoods[indexPath.row - _tasteCount]];
                            
                        }
                    }

                
            };

        }else if(!_arrayGoodsTaste.count){
            
            [cell setItemWithDict: self.arrayGoods[indexPath.row]];
        
        }
        
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = theme_table_bg_color;
        UITextField* txtRemark = [[UITextField alloc]init];
        txtRemark.frame =CGRectMake(10, 5, SCREEN_WIDTH-20, 35);
        txtRemark.layer.masksToBounds = YES;
        txtRemark.layer.cornerRadius = 5.f;
        txtRemark.backgroundColor = theme_line_color;
        txtRemark.placeholder = [NSString stringWithFormat:@"%@(%@)",Localized(@"Order_notes"),Localized(@"Within_words")];
        txtRemark.text = self.remark;
        [cell.contentView addSubview:txtRemark];
        
        _remarkLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREEN_WIDTH - 20, [WMHelper calculateTextHeight:_endString font:[UIFont systemFontOfSize:_myFontSize] width:SCREEN_WIDTH-20])];
        
        _remarkLable.backgroundColor = theme_table_bg_color;
        _remarkLable.textColor = theme_title_color;
        _remarkLable.font = [UIFont systemFontOfSize:_myFontSize];
        _remarkLable.alpha = 0.5;
        _remarkLable.text = _endString;
        _remarkLable.numberOfLines = 10;
        
        [cell.contentView addSubview:_remarkLable];
        self.txtRemark = txtRemark;
        return cell;
    }else if(indexPath.section == 2 ){
        UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        self.txtRedPicker.frame =CGRectMake(10, 5, SCREEN_WIDTH*2/3, 35);
        [cell addSubview:self.txtRedPicker];
        NSDictionary* item = self.arrayRed[self.redIndex];
        self.txtRedPicker.text =[NSString stringWithFormat:@"[%@]%@",[item objectForKey:@"type_money"],[item objectForKey:@"type_name"]];
        
        UIButton* btnUse = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUse.frame = CGRectMake(SCREEN_WIDTH-90, 5, 80, 35);
        [btnUse setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btnUse setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [btnUse setTitle:Localized(@"Use_txt") forState:UIControlStateNormal];
        [btnUse setTitle:Localized(@"Used_txt") forState:UIControlStateSelected];
        btnUse.layer.masksToBounds = YES;
        btnUse.layer.cornerRadius = 5.f;
        btnUse.layer.borderColor = theme_line_color.CGColor;
        btnUse.layer.borderWidth = 1.f;
        btnUse.selected = self.useRed;
        //btnUse.enabled = self.useRed;
        [btnUse addTarget:self action:@selector(useRedTouch:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnUse];
        
        return cell;
        
    }
    
    return nil;
}

-(void)guigeBtnClicked:(UIButton *)button {

    button.selected = !button.selected;
    
    [_arrayGoodsTaste enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj[@"index"] intValue] == button.tag) {
            
            _stockCount = [obj[@"stock"] intValue];
            
            [self.tableView reloadData];
            
        }
        
        
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    _oldY = self.tableView.contentOffset.y;
    
}

-(void)agreement{
    self.agreementBtn.selected = !self.agreementBtn.selected;
    if(self.agreementBtn.selected){
        self.btnPay.userInteractionEnabled = YES;
        self.btnPay.backgroundColor = [UIColor redColor];
    }else{
        self.btnPay.userInteractionEnabled = NO;
        self.btnPay.backgroundColor = [UIColor grayColor];
    }
}

-(void)agreementMemo{
//    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Agreement alloc]init]];
//    [nav.navigationBar setBackgroundColor:theme_navigation_color];
//    [nav.navigationBar setBarTintColor:theme_navigation_color];
//    [nav.navigationBar setTintColor:theme_default_color];
//    [self.parentViewController presentViewController:nav animated:YES completion:nil];
    
    NSURL *URL = [NSURL URLWithString:@"https://www.tutti.app/intro/5.html?app=1"];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark ===================================================自己更改添加口味功能
- (void)creatGoodsTasteBtn:(UITableViewCell *)cell tasteStr:(NSString *)tasteString indexPath:(NSIndexPath *)indexPath {
    
    [cell.contentView removeFromSuperview];
    
    cell.backgroundColor = theme_table_bg_color;
    
    
//    NSArray *arrayStr = [tasteString componentsSeparatedByString:@"|"];
    
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.frame = CGRectMake(0, 5, SCREEN_WIDTH , 20); // frame中的size指UIScrollView的可视范围
    _scrollView.backgroundColor = theme_table_bg_color;
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    
    UILabel* specLabel = [[UILabel alloc]init];
    specLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 20);
    specLabel.text = tasteString;
    specLabel.textColor = theme_title_color;
    specLabel.font = [UIFont systemFontOfSize:13];
    
    [_scrollView addSubview:specLabel];
    
//    int btnWidth = 50;
////    arrayStr.count
//        for (int j = 0; j < arrayStr.count; j ++) {
//
//            UIFont *myFont = [UIFont systemFontOfSize:13];
//
//            btnWidth = [WMHelper calculateTextWidth:arrayStr[j] font:myFont height:20]+5;
//
//            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(10+(10 + btnWidth)*j, 0, btnWidth, 20);
////            btn.frame = CGRectMake(0, 0, btnWidth, 20);
//            btn.clipsToBounds = YES;
//            btn.tag = j + indexPath.row*10;
//            btn.layer.cornerRadius = 3;
//            btn.titleLabel.font = myFont;
//            btn.backgroundColor = [UIColor whiteColor];
//            btn.layer.borderWidth = 1.0f;
//            btn.layer.borderColor = theme_navigation_color.CGColor;
//            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
//
//            [btn setTitle:arrayStr[j] forState:UIControlStateNormal];
//            [btn setTitleColor:theme_title_color forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(goodsTasteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//
//
//            [_scrollView addSubview:btn];
//        }
//
//    if ((btnWidth + 10)*arrayStr.count < SCREEN_WIDTH) {
//
//        _scrollView.scrollEnabled = NO;
//
//    }else {
//
//    _scrollView.contentSize = CGSizeMake((btnWidth + 10)*10 + 10, 0);
//    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    _scrollView.showsHorizontalScrollIndicator = NO;
//
//    }
    
    [cell addSubview:_scrollView];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 30);
}


- (void)goodsTasteBtnClicked:(UIButton *)button {

    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    
    __weak NSMutableArray *arrayTaste = _arrayGoodsTaste;

     __block long num = 0;
    
//    NSLog(@"cell的tag值%ld",cell.tag);
    
    
        [_arrayGoodsTaste enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 
            NSMutableArray *arr = arrayTaste[idx][@"size"];
            num = arr.count;
            
                if (cell.tag == [arrayTaste[idx][@"index"] intValue]) {
                    
                    if (!num) {

                    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:arrayTaste[idx][@"fname"],@"fname",button.titleLabel.text,@"attr",@(button.tag),@"tag",@(1),@"count", nil];
                        
//                    NSLog(@"添加我的新字典");
                        
                     [arrayTaste[idx][@"size"] addObject:dic1];
                        
                    }else {
                        
                        for (int i = 0; i < num; i++) {
                            
                                    if ([arrayTaste[idx][@"size"][i][@"tag"] longValue]/10 == button.tag/10) {
                                            
                                            
                                            NSString *str = button.titleLabel.text;
                                            
                                            [arrayTaste[idx][@"size"][i] setValue:str forKey:@"attr"];
                                            
                                            
//                                            NSLog(@"更改过的字典%@和数组的tag值%@，口味%@，商品名称%@和个数%@和总计的个数%ld",arrayTaste[idx][@"size"][i],arrayTaste[idx][@"size"][i][@"tag"],arrayTaste[idx][@"size"][i][@"attr"],arrayTaste[idx][@"size"][i][@"fname"],arrayTaste[idx][@"size"][i][@"count"],arr.count);
                                        
                                        break;
                                        
                                        }else if(i == num - 1) {
                                            
                                            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:arrayTaste[idx][@"fname"],@"fname",button.titleLabel.text,@"attr",@(button.tag),@"tag",@(1),@"count", nil];
                                            
                                            [arrayTaste[idx][@"size"] addObject:dic2];
                                            
//                                            NSLog(@"最新添加的字典%@和数组的tag值%@，口味%@，商品名称%@和个数%@和总计的个数%ld",dic2,dic2[@"tag"],dic2[@"attr"],dic2[@"fname"],dic2[@"count"],arr.count);
                                            
                                            
                                        }


                            
                        }
                        
                    
                    }
                    
                    
                }
            
    }];

    
    for (UIView *tempView in cell.subviews) {
        
        
        for (UIButton *btn in tempView.subviews) {
            
            if (btn.tag >= 10 && button.tag != btn.tag) {
                
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:theme_title_color forState:UIControlStateNormal];
                
            }else if(btn.tag == button.tag) {
                
                btn.backgroundColor = theme_navigation_color;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
            }

        }
        
    }
    
    
    [self getMyTasteString];
    
    
    _remarkLable.frame = CGRectMake(10, 45, SCREEN_WIDTH - 20,[WMHelper calculateTextHeight:_endString font:[UIFont systemFontOfSize:_myFontSize] width:SCREEN_WIDTH - 20]);
    
    _remarkLable.text = _endString;
    
    _remarkLable.numberOfLines = 10;
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)getMyTasteString {

    //            自己添加在备注里有多少口味的商品
    
    __block NSString *tasteString = @"";
    
    [_arrayGoodsTaste enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *arr = obj[@"size"];
        
        tasteString = [tasteString stringByAppendingString:[NSString stringWithFormat:@"%@:",obj[@"fname"]]];
        
        if (!arr.count) {
            
            tasteString = [tasteString stringByAppendingString:[NSString stringWithFormat:@"|%@|，",Localized(@"Blank_txt")]];

            return;
            
        }else {
            
            for (NSMutableDictionary *temp in arr) {
                
                tasteString = [tasteString stringByAppendingString:[NSString stringWithFormat:@"|%@",temp[@"attr"]]];
                
            }
            
            tasteString = [tasteString stringByAppendingString:@"，"];
            
        }
        
    }];
    
    
    __block NSArray *comArray = [tasteString componentsSeparatedByString:@"，"];
    
    __block NSString *endString = @"";
    
    for (NSDictionary *tempDic in _arrayGoodsTaste) {

        NSArray *kindArray = [tempDic[@"attr"] componentsSeparatedByString:@"|"];
    
        [comArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            NSArray *comArray1 = [obj componentsSeparatedByString:@"|"];
            
            int num = [tempDic[@"stock"] intValue];
            int sub = 0;
            
            if ([tempDic[@"fname"] isEqualToString:[comArray1[0] stringByReplacingOccurrencesOfString:@":" withString:@""]]) {
                
                endString = [endString stringByAppendingString:[NSString stringWithFormat:@"%@",comArray1[0]]];
                
                
                
                for (NSString *nucleobase in kindArray){
                    
                    int count = (int)[obj componentsSeparatedByString:nucleobase].count;
                    
                    if (count!=1) {
                        
                        endString = [endString stringByAppendingString:[NSString stringWithFormat:@"%d%@，",count - 1,nucleobase]];
                        
                        sub += count -1;
                    }
                    
                    
                }
                
                
                if (sub < num) {
                    
                    endString = [endString stringByAppendingString:[NSString stringWithFormat:@"%d %@，",num - sub,Localized(@"Default_txt")]];
                    
                }
                
                
                if (idx == comArray.count - 2) {
                    
                    endString = [endString stringByReplacingCharactersInRange:NSMakeRange(endString.length -1, 1) withString:@"."];
                    
                }
                
                
            }
            
            
            
        }];
        
        
    }
    
    
    _endString = endString;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark =====================================================  SEL
-(IBAction)btnPayWay:(UIButton*)sender{
    [self showHUD];
    self.remark = self.txtRemark.text;
    if(sender == self.btnWeXinPay){
        self.btnWeXinPay.selected = YES;
        self.btnAlipay.selected = NO;
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = NO;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        self.goodsSumPrice = self.onLinePrice;
    }else if(sender == self.btnAlipay){
        self.btnWeXinPay.selected = NO;
        self.btnAlipay.selected = YES;
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = NO;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        self.goodsSumPrice = self.onLinePrice;
    }else if(sender == self.btnCredit){
        self.btnWeXinPay.selected = NO;
        self.btnAlipay.selected = NO;
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = YES;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-enter"]];
        self.goodsSumPrice = self.onLinePrice;
        self.tipView.hidden = NO;
        for(NSLayoutConstraint* con in [self.tipView constraints]){
            if([con firstAttribute] == NSLayoutAttributeHeight){
                [self.tipView removeConstraint:con];
                [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:115.f]];
            }
        }
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 535);
    }else{
        self.btnWeXinPay.selected = NO;
        self.btnAlipay.selected = NO;
        self.btnFacePay.selected = YES;
        self.btnCredit.selected = NO;
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        self.discountPrice =0.00;
        self.goodsSumPrice = self.offLinePrice;
        self.useRed = NO;
        self.tipView.hidden = YES;
        for(NSLayoutConstraint* con in [self.tipView constraints]){
            if([con firstAttribute] == NSLayoutAttributeHeight){
                [self.tipView removeConstraint:con];
                [self.tipView addConstraint:[NSLayoutConstraint constraintWithItem:self.tipView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f]];
            }
        }
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 424);
    }
    [self updatePrice];
    [self.HUD hide:YES afterDelay:1];
}

-(IBAction)generalOrderTouch:(id)sender{
    if(self.btnWeXinPay.selected){
        if(![WXApi isWXAppInstalled]){
            [self alertHUD:Localized(@"Not_weixin_payment")];
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
            else if(self.btnCredit.selected)//信用卡支付
                payType = @"3";
            else //货到付款
                payType = @"0";
            
            
            AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            MAddress* item = delegate.globalAddress;
            [self showHUD];
            
            
            /*begin zeng jun  2015-12-27  得到使用红包的编号 */
            NSString* bonus_use_id;
            if(self.useRed){
                NSString* emptybonus_use_id = [self.arrayRed[self.redIndex] objectForKey:@"items"];
                bonus_use_id = emptybonus_use_id;
            }else{
                bonus_use_id = @"0";
            }
            /*end zeng jun  2015-12-27*/
            
            
           
            NSString *str = [self.txtRemark.text stringByAppendingString:_endString];
            
            //NSDictionary* arg = @{@"ince":@"save_order_cer",@"uid":self.Identity.userInfo.userID,@"cart_list":self.carJson,@"addr_item_id":item.rowID,@"pay_type":payType,@"order_mark":str,@"bonus_use":bonus_use_id,@"cer_type":@"2"};
            NSDictionary* arg = @{@"a":@"saveOrder",@"uid":self.Identity.userInfo.userID,@"cart_list":self.carJson,@"addr_item_id":item.rowID,@"pay_type":payType,@"order_mark":str,@"bonus_use":bonus_use_id,@"cer_type":@"3",@"tip":[NSString stringWithFormat:@"%.2f",self.tip_fee]};
            
            NSLog(@"我神奇的口味字符串%@",str);
            
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    [self hidHUD];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationShopCarChange object:nil];
                    if(self.btnWeXinPay.selected)//微信支付
                        [self wxPay:[response objectForKey:@"main_id"]];
                    else if (self.btnAlipay.selected)//支付宝支付
                        [self aliPay:[response objectForKey:@"main_id"]];
                    else if(self.btnCredit.selected)
                        [self creditPay:[response objectForKey:@"main_id"]];
                    else{ //货到付款 不需要修改订单状态这里直接跳转到订单页就可以了。
                        [self payResult:nil];
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

-(void)cancelTouched:(UIBarButtonItem *)sender
{

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    [self.txtRedPicker resignFirstResponder];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}
-(IBAction)useRedTouch:(id)sender{
     NSDictionary* dict=  self.arrayRed[self.redIndex];
    double limitMoney = [[dict objectForKey: @"limit_money"]doubleValue];
    if((self.goodsSumPrice-self.fullCut)>=limitMoney){
    self.remark = self.txtRemark.text;
    self.useRed = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    
    self.discountPrice =[[dict objectForKey:@"type_money"] doubleValue];
    if(self.btnFacePay.selected)
        self.goodsSumPrice=self.offLinePrice;
    else
        self.goodsSumPrice=self.onLinePrice;
    self.paySumPrice = self.goodsSumPrice;
    [self updatePrice];
    }else{
        NSString* message = [NSString stringWithFormat: Localized(@"Cannot_use_coupon"),[dict objectForKey: @"limit_money"]];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle: Localized(@"Prompt_txt") message: message delegate:nil cancelButtonTitle: Localized(@"Confirm_txt") otherButtonTitles: nil];
        [alert show];
    }
}
-(IBAction)cancelTouch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self creditPay:@"1"];
}

-(void)creditPay:(NSString*)order_id{
    CreditPay* controller = [[CreditPay alloc]init];
    controller.tip_price = self.tip_fee;
    controller.total_price = self.paySumPrice;
    controller.order_id = order_id;
    
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [nav.navigationBar setBackgroundColor:theme_navigation_color];
    [nav.navigationBar setBarTintColor:theme_navigation_color];
    [nav.navigationBar setTintColor:theme_default_color];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}
#pragma mark =====================================================  UIPickerView 协议实现

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrayRed count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *item = [self.arrayRed objectAtIndex:row];
    return [item objectForKey:@"type_name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.remark = self.txtRemark.text;
    if(self.useRed){
        if(self.btnFacePay.selected)
            self.goodsSumPrice=self.offLinePrice;
        else
            self.goodsSumPrice=self.onLinePrice;
        self.discountPrice = 0.00;
        self.paySumPrice = self.goodsSumPrice;
        [self updatePrice];
    }
    self.useRed = NO;
    self.redIndex = row;
}
#pragma mark =====================================================  私有方法
-(void)updatePrice{
    //self.paySumPrice =self.goodsSumPrice-self.discountPrice+self.packagePrice+self.shipPrice-self.fullCut;
    self.labelFullCutPrice.text = [NSString stringWithFormat:@"-$%.2f",self.fullCut];
    self.labelDiscountPrice.text = [NSString stringWithFormat:@"-$%.2f",self.discountPrice];
    self.labelPackagePrice.text = [NSString stringWithFormat:@"$%.2f",self.packagePrice];
    self.labelExpectPrice.text = [NSString stringWithFormat:@"$%.2f",self.shipPrice];
    self.labelGoodsPrice.text = [NSString stringWithFormat:@"$%.2f",self.goodsSumPrice];
    self.labelSumPrice.text =[NSString stringWithFormat:@"$%.2f",self.paySumPrice];
    self.labelTaxNum.text = [NSString stringWithFormat:@"$%.2f",self.taxPrice];
    
    [self changeTip];
    [self.tableView reloadData];
}
#pragma mark 微信支付
-(void)wxPay:(NSString*)orderID{
    self.orderNo = orderID;
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:kWXAPP_ID mch_id:kWXPay_partnerid];
    //设置密钥
    [req setKey:kWXPay_partnerid_secret];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSInteger price = (NSInteger)(self.paySumPrice*100);
    NSMutableDictionary *dict = [req sendPay:orderID price:price];
    
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

-(void)aliPay:(NSString*)orderID{
    self.orderNo = orderID;
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
//    饕餮
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
    order.productName = @"Tutti 订单"; //商品标题
    order.productDescription = @"Tutti 订单"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",self.paySumPrice]; //商品价格
    // order.notifyURL =  @"http://www.vicisland.com"; //回调URL
    
    order.notifyURL =  @"http://www.vicisland.com/Mobile/Tpay/notifyurl"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.kavl.tutti";
    
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

-(void)appBackNotification:(NSNotification*)notification{
    [self payResult:nil];
}
-(void)payResult:(NSString*)message{
    if(message){
        /*[self showHUD:message];
         [self hidHUD:message];*/
        [self alertHUD:message];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil];
    }];
}

-(void)tip_select{
    //NSLog(@"garfunkel_log:tip:%ld",self.tipSeg.selectedSegmentIndex);
    [self changeTip];
}

-(void)changeTip{
    NSArray* tipArr;
    if(self.tipSeg.selectedSegmentIndex == -1){
        self.tip_fee = [self.tipTxt.text doubleValue];
    }else{
        self.tipTxt.text = @"";
        if (self.paySumPrice > 20) {
            NSArray* tipArr = @[@"15",@"20",@"25"];
            self.tip_fee = self.paySumPrice * [[tipArr objectAtIndex:self.tipSeg.selectedSegmentIndex] integerValue]/100;
            NSInteger i = 0;
            for(NSString* tText in tipArr){
                NSString* Stxt = [NSString stringWithFormat:@"%@%@",tText,@"%"];
                [self.tipSeg setTitle:Stxt forSegmentAtIndex:i];
                i++;
            }
        }else{
            NSArray* tipArr = @[@"3",@"4",@"5"];
            self.tip_fee = [[tipArr objectAtIndex:self.tipSeg.selectedSegmentIndex] doubleValue];
            NSInteger i = 0;
            for(NSString* tText in tipArr){
                NSString* Stxt = [NSString stringWithFormat:@"$%@",tText];
                [self.tipSeg setTitle:Stxt forSegmentAtIndex:i];
                i++;
            }
        }
    }
    
    self.tipFeeLabel.text = [NSString stringWithFormat:@"$%.2f",self.tip_fee];
    if (self.btnCredit.selected) {
        self.labelSumPrice.text =[NSString stringWithFormat:@"$%.2f",self.paySumPrice + self.tip_fee];
    }
}
                                      
#pragma mark =====================================================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            [self alertHUD:Localized(@"Enter_Error")];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            [self alertHUD:Localized(@"Enter_Error")];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    [self alertHUD:Localized(@"Enter_Error")];
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    [self alertHUD:Localized(@"Enter_Error")];
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    [self alertHUD:Localized(@"Enter_Error")];
                    return NO;
                }
            }
        }
        
    }
    //NSLog(@"garfunkel_log:%ld,%ld",textField.text.length,string.length);
    if(textField.text.length == 0 && string.length == 1){
        [self.tipSeg setSelectedSegmentIndex:-1];
    }
    if(textField.text.length == 1 && string.length == 0){
        [self.tipSeg setSelectedSegmentIndex:0];
    }
    
    return YES;
}


#pragma mark =====================================================  属性封装
-(NSMutableArray *)arrayData{
    if(!_arrayData)
        _arrayData = [[NSMutableArray alloc]init];
    return _arrayData;
}

- (NSMutableArray *)arrayGoodsTaste {
    if (!_arrayGoodsTaste) {
        _arrayGoodsTaste = [[NSMutableArray alloc]init];
    }

    return _arrayGoodsTaste;
}

-(UILabel *)labelPackage{
    if(!_labelPackage){
        _labelPackage =[[UILabel alloc]init];
        _labelPackage.text = [NSString stringWithFormat:@"%@:",Localized(@"Packing_fee")];
    }
    return _labelPackage;
}

-(UILabel *)labelPackagePrice{
    if(!_labelPackagePrice){
        _labelPackagePrice = [[UILabel alloc]init];
        _labelPackagePrice.text = @"$0.00";
        _labelPackagePrice.textAlignment = NSTextAlignmentRight;
    }
    return _labelPackagePrice;
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
        _labelCutTitle.text =  [NSString stringWithFormat:@"%@:",Localized(@"Full_redue")];
        _labelCutTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCutTitle;
}

-(UILabel *)labelFullCutPrice{
    if(!_labelFullCutPrice){
        _labelFullCutPrice = [[UILabel alloc]init];
        _labelFullCutPrice.text = @"$0.00";
        _labelFullCutPrice.textAlignment = NSTextAlignmentRight;
        _labelFullCutPrice.textColor = [UIColor redColor];
        _labelFullCutPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelFullCutPrice;
}

-(UILabel*)leftView:(NSString*)title{
    UILabel* leftView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40.f)];
    leftView.textColor = [UIColor grayColor];
    leftView.font = [UIFont systemFontOfSize:14.f];
    leftView.text = title;
    return leftView;
}


@end
