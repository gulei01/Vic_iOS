//
//  HelpBuy.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/6.
//
//

#import "HelpBuy.h"
#import "RandomBuyCar.h"
#import "SilderScrollView.h"
#import "BuyAddress.h"
#import "BuyAddressV2.h"
#import "ReceivesAddress.h"
#import "TagTypeCell.h"
#import "RandomVouchers.h"
#import "RandomOrderPay.h"
#import "RandomPaySuccess.h"
#import "RandomPayFail.h"
#import "RandomOrder.h"
#import "RandomDeliverHelp.h"

@interface HelpBuy ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,RandomBuyCarDelegate,RandomDeliverHelpDelegate>

@property(nonatomic,strong) SilderScrollView* mainScroll;
@property(nonatomic,strong) UIView* nameView;
@property(nonatomic,strong) UIImageView* iconName;
@property(nonatomic,strong) UITextField* txtName;

@property(nonatomic,strong) UICollectionView* collectionView;

@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UITextField* txtPrice;

@property(nonatomic,strong) UIView* buyView;
@property(nonatomic,strong) UIImageView* iconBuy;
@property(nonatomic,strong) UIButton* btnBuy;
@property(nonatomic,strong) UILabel* labelBuy;
@property(nonatomic,strong) UIImageView* buyArrow;

@property(nonatomic,strong) UIView* receiveView;
@property(nonatomic,strong) UIImageView* iconReceive;
@property(nonatomic,strong) UIButton* btnReceive;
@property(nonatomic,strong) UILabel* labelReceive;
@property(nonatomic,strong) UIImageView* receiveArrow;
@property(nonatomic,strong) NSLayoutConstraint* receiveConstraints;

@property(nonatomic,strong) UIView* timeView;
@property(nonatomic,strong) UILabel* labelTimeTitle;
@property(nonatomic,strong) UILabel* labelTime;

@property(nonatomic,strong) UIView* markView;
@property(nonatomic,strong) UILabel* labelMark;
@property(nonatomic,strong) UITextField* txtMark;

@property(nonatomic,strong) UIView* deliveryView;//配送费
@property(nonatomic,strong) UILabel* labelDelivery;
@property(nonatomic,strong) UIButton* iconDelivery;
@property(nonatomic,strong) UILabel* labelDeliveryPrice;
@property(nonatomic,assign) NSInteger deliveryPrice;

@property(nonatomic,strong) UIView* vouchersView;//代金券
@property(nonatomic,strong) UILabel* labelVouchers;
@property(nonatomic,strong) UIButton* btnVouchers;
@property(nonatomic,strong) UILabel* labelVouchersPrice;
@property(nonatomic,assign) NSInteger vouchersPrice;
@property(nonatomic,strong) NSDictionary* redPackage;

@property(nonatomic,strong) UIImageView* vouchersArrow;

@property(nonatomic,strong) UIView* tipView;//小费
@property(nonatomic,strong) UILabel* labelTipTitle;
@property(nonatomic,strong) UILabel* labelTipPrice;
@property(nonatomic,strong) UIButton* btnTip;
@property(nonatomic,assign) NSInteger tipPrice;

@property(nonatomic,strong) UIView* silderView;
@property(nonatomic,strong) UISlider* silder;

@property(nonatomic,strong) UIView* anonymousView;//匿名购买
@property(nonatomic,strong) UILabel* labelAnonymous;
@property(nonatomic,strong) UISwitch* switchAnonymous;

@property(nonatomic,strong) UIView* agreementView; //协议
@property(nonatomic,strong) UIButton* iconAgreement;
@property(nonatomic,strong) UIButton* btnAgreement;

@property(nonatomic,strong) RandomBuyCar* car;
@property(nonatomic,strong) UIView* orderView;

@property(nonatomic,strong) NSArray* arrayTag;
@property(nonatomic,strong) AMapPOI* buyAddress;
@property(nonatomic,strong) MAddress* receiveAddress;//收货地址

@property(nonatomic,strong) RandomDeliverHelp* deliveryHelpe;

@property(nonatomic,strong) UIView* customTipView;
@property(nonatomic,strong) UILabel* labelAlertTitle;
@property(nonatomic,strong) UITextField* txtTipPrice;
@property(nonatomic,strong) UIButton* btnTipCancel;
@property(nonatomic,strong) UIButton* btnTipOK;

@property(nonatomic,strong) NSString* keyword;

@property(nonatomic,strong) NSDictionary* dictPrice;

@property(nonatomic,strong) UIBarButtonItem* rightBtn;

@end

@implementation HelpBuy{
    NSInteger itemHeight,iconSize ,arrowHeight,arrowWidth ,titleWidth ,defEdge ,leftEdge ,topEdge ,itemSpace ,collectionHeight;
}

static NSString* const cellIdentfier =  @"TagTypeCell";

-(instancetype)initWithTags:(NSArray *)tags{
    self = [super init];
    if(self){
        _arrayTag = tags;
    }
    return self;
}

-(instancetype)initWithKeyword:(NSString *)keyword{
    self = [super init];
    if(self){
        _keyword = keyword;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstLoad = YES;
    
    self.vouchersPrice = 0;
    self.deliveryPrice = 0;
    self.tipPrice = 0;
    [self layoutUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedBuyAddressNotification:) name:NotificationSelectedBuyAddress object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedReceiveAddressNotification:) name:NotificationSelectedRandomAddressReceive object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedVouchersNotification:) name:NotificationSelectedVouchers object:nil];
    
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary* conf = [userDef dictionaryForKey:kRandomBuyConfig];
    self.deliveryPrice = [[conf objectForKey: @"ship_fee"] integerValue];
    [self.car setDeliveryPrice:self.deliveryPrice andTip:self.tipPrice];
    if(![WMHelper isEmptyOrNULLOrnil:self.keyword]){
        self.txtName.text = self.keyword;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(randomPayFinished:) name:NotificationRandomPayFinished object:nil];
    self.dictPrice = @{ @"price":[WMHelper integerConvertToString:self.deliveryPrice], @"distance": [conf objectForKey: @"add_distance"]};
    [self queryDefAddress];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.firstLoad) {
        self.firstLoad =NO;
        CGFloat labelWidth = self.btnTip.titleLabel.frame.size.width;
        [self.btnTip setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [self.btnTip setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth, 0, 0)];
    }
    self.labelDeliveryPrice.text =[NSString stringWithFormat: @"%@元", [WMHelper integerConvertToString:self.deliveryPrice]];
    [self loadConstraints];
    self.navigationItem.title =  @"帮你买";
    self.navigationItem.rightBarButtonItem = self.rightBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data Source
-(void)queryDefAddress{
    NSDictionary* arg = @{@"ince":@"get_user_addr_ince",@"is_default":@"1",@"uid":self.Identity.userInfo.userID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchAddres:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            if(obj){
                self.receiveAddress = obj;
                NSString* empty = [NSString stringWithFormat: @"%@ %@",self.receiveAddress.userName,self.receiveAddress.phoneNum];
                NSString* emptyAddress = [NSString stringWithFormat: @"%@ %@",self.receiveAddress.mapAddress,self.receiveAddress.mapNumber];
                NSString* str = [NSString stringWithFormat: @"%@\n%@",emptyAddress,empty];
                NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
                [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str.length)];
                [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, str.length)];
                [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:empty]];
                NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                [paragraphStyle setLineSpacing:8];
                [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
                self.labelReceive.attributedText = attributeStr;
                
                [self loadConstraints];
            }
        }else if(react == 400){
           // NSLog( @"%@",message);
        }else{
            //NSLog( @"%@",message);
        }
    }];
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    itemHeight = 50; iconSize = 20; arrowHeight = 14; arrowWidth = 8;  titleWidth = 120;
    defEdge = 0; leftEdge = 10; topEdge = 10;  itemSpace = 10;
    if(self.arrayTag){
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [self.collectionView.layer addSublayer:border];
        NSInteger weights = 30;
        NSInteger row=1;
        CGFloat width = SCREEN_WIDTH-20;
        CGFloat emptyWidth = 0;
        NSInteger maxIndex = self.arrayTag.count -1;
        for (NSInteger i = 0; i<self.arrayTag.count; i++) {
            NSString* str = self.arrayTag[i] ;
            CGFloat empty = [WMHelper calculateTextWidth:str font:[UIFont systemFontOfSize:14.f]];
            emptyWidth =emptyWidth + empty+weights;
            if(emptyWidth == width){
                if(i == maxIndex){
                }else{
                    row = row+1;
                    emptyWidth = empty+weights;
                }
            }else if (emptyWidth>width){
                row = row+1;
                emptyWidth = empty+weights;
            }else{
                if(i == maxIndex){
                    
                }else{
                    
                }
            }
        }
        
        collectionHeight = row*45;
    }else{
        collectionHeight = 0;
    }
    
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:self.nameView];
    [self.nameView addSubview:self.iconName];
    [self.nameView addSubview:self.txtName];
    [self.mainScroll addSubview:self.collectionView];
    [self.mainScroll addSubview:self.priceView];
    [self.priceView addSubview:self.labelPrice];
    [self.priceView addSubview:self.txtPrice];
    [self.mainScroll addSubview:self.buyView];
    [self.buyView addSubview:self.iconBuy];
    [self.buyView addSubview:self.btnBuy];
    [self.buyView addSubview:self.labelBuy];
    [self.buyView addSubview:self.buyArrow];
    [self.mainScroll addSubview:self.receiveView];
    [self.receiveView addSubview:self.iconReceive];
    [self.receiveView addSubview:self.btnReceive];
    [self.receiveView addSubview:self.labelReceive];
    [self.receiveView addSubview:self.receiveArrow];
    [self.mainScroll addSubview:self.timeView];
    [self.timeView addSubview:self.labelTimeTitle];
    [self.timeView addSubview:self.labelTime];
    [self.mainScroll addSubview:self.markView];
    [self.markView addSubview:self.labelMark];
    [self.markView addSubview:self.txtMark];
    [self.mainScroll addSubview:self.deliveryView];
    [self.deliveryView addSubview:self.labelDelivery];
    [self.deliveryView addSubview:self.iconDelivery];
    [self.deliveryView addSubview:self.labelDeliveryPrice];
    [self.mainScroll addSubview:self.vouchersView];
    [self.vouchersView addSubview:self.labelVouchers];
    [self.vouchersView addSubview:self.btnVouchers];
    [self.vouchersView addSubview:self.labelVouchersPrice];
    [self.vouchersView addSubview:self.vouchersArrow];
    [self.mainScroll addSubview:self.tipView];
    [self.tipView addSubview:self.labelTipTitle];
    [self.tipView addSubview:self.labelTipPrice];
    [self.tipView addSubview:self.btnTip];
    [self.mainScroll addSubview:self.silderView];
    [self.silderView addSubview:self.silder];
    [self.mainScroll addSubview:self.anonymousView];
    [self.anonymousView addSubview:self.labelAnonymous];
    [self.anonymousView addSubview:self.switchAnonymous];
    [self.mainScroll addSubview:self.agreementView];
    [self.agreementView addSubview:self.iconAgreement];
    [self.agreementView addSubview:self.btnAgreement];
    [self.view addSubview:self.orderView];
    
    [self.customTipView addSubview:self.labelAlertTitle];
    [self.customTipView addSubview:self.txtTipPrice];
    [self.customTipView addSubview:self.btnTipCancel];
    [self.customTipView addSubview:self.btnTipOK];
    
    for (UIView* subView in self.mainScroll.subviews) {
        subView.backgroundColor = [UIColor whiteColor];
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        for (UIView* empty in subView.subviews) {
            empty.translatesAutoresizingMaskIntoConstraints = NO;
            if([empty isKindOfClass:[UITextField class]]){
                UITextField* obj = (UITextField*)empty;
                obj.textColor = [UIColor colorWithRed:159/255.f green:159/255.f blue:159/255.f alpha:1.0];
            }
        }
    }
    self.agreementView.backgroundColor=[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    
    [self layoutConstraints:@[
                              @"H:|-defEdge-[mainScroll]-defEdge-|",@"H:|-defEdge-[orderView]-defEdge-|", @"V:[topView][mainScroll]-defEdge-[orderView(==orderHeight)]-defEdge-|",
                              
                              @"H:|-defEdge-[nameView(==defWidth)]-defEdge-|",@"H:|-defEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[priceView]-defEdge-|",@"H:|-defEdge-[buyView]-defEdge-|",
                              @"H:|-defEdge-[receiveView(nameView)]-defEdge-|",@"H:|-defEdge-[timeView]-defEdge-|", @"H:|-defEdge-[markView]-defEdge-|",
                              @"H:|-defEdge-[deliveryView]-defEdge-|",@"H:|-defEdge-[vouchersView]-defEdge-|",@"H:|-defEdge-[tipView]-defEdge-|",
                              @"H:|-defEdge-[silderView]-defEdge-|", @"H:|-defEdge-[anonymousView]-defEdge-|",@"H:|-defEdge-[agreementView]-defEdge-|",
                              @"V:|-topEdge-[nameView(==itemHeight)]-defEdge-[collectionView(==collectionHeight)]-itemSpace-[priceView(nameView)]-itemSpace-[buyView(nameView)]-defEdge-[receiveView]-itemSpace-[timeView(nameView)]-defEdge-[markView(nameView)]-defEdge-[deliveryView(nameView)]-defEdge-[vouchersView(nameView)]-defEdge-[tipView(nameView)]-defEdge-[silderView(nameView)]-defEdge-[anonymousView(nameView)]-defEdge-[agreementView(nameView)]-topEdge-|",
                              
                              @"H:|-leftEdge-[iconName(==iconSize)]-itemSpace-[txtName]-leftEdge-|", @"V:|-iconTopEdge-[iconName]-iconTopEdge-|", @"V:|-defEdge-[txtName]-defEdge-|",
                              @"H:|-leftEdge-[labelPrice(==titleWidth)]-itemSpace-[txtPrice]-leftEdge-|", @"V:|-defEdge-[labelPrice]-defEdge-|", @"V:|-defEdge-[txtPrice]-defEdge-|",
                              
                              @"H:|-leftEdge-[iconBuy(==iconSize)]-leftEdge-[btnBuy]-leftEdge-|",@"H:[iconBuy]-itemSpace-[labelBuy]-defEdge-[buyArrow(==arrowWidth)]-leftEdge-|",
                              @"V:|-iconTopEdge-[iconBuy]-iconTopEdge-|", @"V:|-topEdge-[btnBuy]-topEdge-|",@"V:|-topEdge-[labelBuy]-topEdge-|", @"V:|-arrowTopEdge-[buyArrow]-arrowTopEdge-|",
                              
                              @"H:|-leftEdge-[iconReceive(==iconSize)]-leftEdge-[btnReceive]-leftEdge-|",@"H:[iconReceive]-leftEdge-[labelReceive]-defEdge-[receiveArrow(==arrowWidth)]-leftEdge-|",
                              @"V:|-iconTopEdge-[iconReceive(==iconSize)]", @"V:|-defEdge-[btnReceive]-defEdge-|",@"V:|-defEdge-[labelReceive]-defEdge-|", @"V:|-arrowTopEdge-[receiveArrow(==arrowHeight)]",
                              
                              @"H:|-leftEdge-[labelTimeTitle(==titleWidth)]-leftEdge-[labelTime]-leftEdge-|", @"V:|-topEdge-[labelTimeTitle]-topEdge-|", @"V:|-topEdge-[labelTime]-topEdge-|",
                              @"H:|-leftEdge-[labelMark(==titleWidth)]-leftEdge-[txtMark]-leftEdge-|", @"V:|-topEdge-[labelMark]-topEdge-|", @"V:|-topEdge-[txtMark]-topEdge-|",
                              
                              @"H:|-leftEdge-[labelDelivery(==itemHeight)]-defEdge-[iconDelivery(==itemHeight)]-defEdge-[labelDeliveryPrice]-leftEdge-|",
                              @"V:|-topEdge-[labelDelivery]-topEdge-|", @"V:|-defEdge-[iconDelivery]-defEdge-|", @"V:|-topEdge-[labelDeliveryPrice]-topEdge-|",
                              
                              @"H:|-leftEdge-[labelVouchers(==titleWidth)]-leftEdge-[btnVouchers]-leftEdge-|", @"H:[labelVouchers]-defEdge-[labelVouchersPrice]-2-[vouchersArrow(==arrowWidth)]-leftEdge-|",
                              @"V:|-topEdge-[labelVouchers]-topEdge-|", @"V:|-topEdge-[btnVouchers]-topEdge-|", @"V:|-topEdge-[labelVouchersPrice]-topEdge-|", @"V:|-arrowTopEdge-[vouchersArrow]-arrowTopEdge-|",
                              
                              @"H:|-leftEdge-[labelTipTitle(==155)]-leftEdge-[labelTipPrice]-leftEdge-[btnTip(==95)]-defEdge-|",
                              @"V:|-topEdge-[labelTipTitle]-topEdge-|", @"V:|-topEdge-[labelTipPrice]-topEdge-|", @"V:|-topEdge-[btnTip]-topEdge-|",
                              @"H:|-20-[silder]-20-|", @"V:|-defEdge-[silder]-defEdge-|",
                              @"H:|-leftEdge-[labelAnonymous]-defEdge-[switchAnonymous]-leftEdge-|", @"V:|-topEdge-[labelAnonymous]-topEdge-|", @"V:|-defEdge-[switchAnonymous]",
                              @"H:|-leftEdge-[iconAgreement(==iconSize)]-leftEdge-[btnAgreement]-leftEdge-|", @"V:|-iconTopEdge-[iconAgreement]-iconTopEdge-|", @"V:|-topEdge-[btnAgreement]-topEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(defEdge),@"topEdge":@(topEdge), @"leftEdge":@(leftEdge), @"itemSpace":@(itemSpace),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"collectionHeight":@(collectionHeight),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"mainScroll":self.mainScroll, @"orderView":self.orderView, @"topView":self.topLayoutGuide,
                              @"nameView":self.nameView, @"collectionView":self.collectionView,@"priceView":self.priceView,@"buyView":self.buyView,@"receiveView":self.receiveView,
                              @"timeView":self.timeView, @"markView":self.markView,@"deliveryView":self.deliveryView, @"vouchersView":self.vouchersView,
                              @"tipView":self.tipView,@"silderView":self.silderView, @"anonymousView":self.anonymousView, @"agreementView":self.agreementView,
                              @"iconName":self.iconName, @"txtName":self.txtName,
                              @"labelPrice":self.labelPrice,@"txtPrice":self.txtPrice,
                              @"iconBuy":self.iconBuy, @"btnBuy":self.btnBuy,@"labelBuy":self.labelBuy, @"buyArrow":self.buyArrow,
                              @"iconReceive":self.iconReceive, @"btnReceive":self.btnReceive,@"labelReceive":self.labelReceive, @"receiveArrow":self.receiveArrow,
                              @"labelTimeTitle":self.labelTimeTitle, @"labelTime":self.labelTime,
                              @"labelMark":self.labelMark, @"txtMark":self.txtMark,
                              @"labelDelivery":self.labelDelivery, @"iconDelivery":self.iconDelivery, @"labelDeliveryPrice":self.labelDeliveryPrice,
                              @"labelVouchers":self.labelVouchers, @"btnVouchers":self.btnVouchers ,@"labelVouchersPrice":self.labelVouchersPrice, @"vouchersArrow":self.vouchersArrow,
                              @"labelTipTitle":self.labelTipTitle, @"labelTipPrice":self.labelTipPrice, @"btnTip":self.btnTip,
                              @"silder":self.silder,
                              @"labelAnonymous":self.labelAnonymous, @"switchAnonymous":self.switchAnonymous,
                              @"iconAgreement":self.iconAgreement, @"btnAgreement":self.btnAgreement
                              }
                  superView:self.view];
    
    self.receiveConstraints =[NSLayoutConstraint constraintWithItem:self.receiveView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:itemHeight];
    [self.receiveView addConstraint:self.receiveConstraints];
    
    [self layoutConstraints:@[
                              @"H:|-defEdge-[labelAlertTitle]-defEdge-|",@"H:|-30-[txtTipPrice]-30-|", @"H:|-defEdge-[btnTipCancel][btnTipOK(btnTipCancel)]-defEdge-|",
                              @"V:|-defEdge-[labelAlertTitle(==labelHeight)]-15-[txtTipPrice(==30)]-15-[btnTipCancel]-defEdge-|", @"V:[txtTipPrice]-15-[btnTipOK]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defEdge":@(defEdge),@"topEdge":@(topEdge),@"leftEdge":@(leftEdge), @"labelHeight":@(40)
                              }
                      views:@{
                              @"labelAlertTitle":self.labelAlertTitle, @"txtTipPrice":self.txtTipPrice, @"btnTipCancel":self.btnTipCancel, @"btnTipOK":self.btnTipOK
                              }
                  superView:self.customTipView];
    
}

-(void)layoutConstraints:(NSArray*)formats options:(NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views superView:(UIView*)superView{
    for (NSString* format in formats) {
        // NSLog( @" %@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
        [superView addConstraints:constraints];
    }
}

-(void)loadConstraints{
    if(self.receiveAddress){
        if(self.receiveConstraints)
            [self.receiveView removeConstraint:self.receiveConstraints];
        CGSize empty = [self.labelReceive intrinsicContentSize];
        self.receiveConstraints = [NSLayoutConstraint constraintWithItem:self.receiveView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:empty.height+15];
        self.receiveConstraints.priority = 999;
        [self.receiveView addConstraint:self.receiveConstraints];
    }else{
        if(self.receiveConstraints)
            [self.receiveView removeConstraint:self.receiveConstraints];
        self.receiveConstraints = [NSLayoutConstraint constraintWithItem:self.receiveView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:itemHeight];
        self.receiveConstraints.priority = 999;
        [self.receiveView addConstraint:self.receiveConstraints];
    }
    
}
#pragma mark =====================================================  <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrayTag.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagTypeCell* cell = (TagTypeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentfier forIndexPath:indexPath];
    cell.tagType = self.arrayTag[indexPath.row];
    return cell;
}


#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [WMHelper calculateTextWidth:self.arrayTag[indexPath.row] font:[UIFont systemFontOfSize:14.f]];
    return CGSizeMake(width+20, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark =====================================================  <UICollectionViewDeleate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* str = self.arrayTag[indexPath.row];
    NSString* text = self.txtName.text;
    if(![text containsString:str]){
        self.txtName.text = [text stringByAppendingString:[NSString stringWithFormat: @" %@",str]];
    }else{
        self.txtName.text = [text stringByReplacingOccurrencesOfString: [NSString stringWithFormat: @" %@",str] withString: @""];
    }
}

#pragma mark =====================================================  <UITextFieldDeleget>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSInteger empty =  [[NSString stringWithFormat: @"%@%@",textField.text,string] integerValue];
//    if(empty>200){
//        self.btnTipOK.enabled = NO;
//        [self.btnTipOK setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [self.btnTipOK setTitle: @"可填写1-200" forState:UIControlStateNormal];
//    }else{
//        self.btnTipOK.enabled = YES;
//        [self.btnTipOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.btnTipOK setTitle: @"确认" forState:UIControlStateNormal];
//    }
    return YES;
}

#pragma mark =====================================================  CarDelegate
-(void)submitRandomCar{
    if(self.Identity.userInfo.isLogin){
        if([self checkForm]){
            NetRepositories* repositories = [[NetRepositories alloc]init];
            NSString* buyAddressStr = nil;
            NSString* bonus_use = nil;
            if(self.buyAddress){
                NSDictionary* emptyBuyAddress = @{ @"address":self.buyAddress.address, @"road":self.buyAddress.name, @"lat":@(self.buyAddress.location.latitude), @"lng":@(self.buyAddress.location.longitude)};
                if ([NSJSONSerialization isValidJSONObject:emptyBuyAddress])
                {
                    NSError *error;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:emptyBuyAddress options:NSJSONWritingPrettyPrinted error:&error];
                    buyAddressStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                }else{
                    buyAddressStr = @"";
                }
            }else{
                buyAddressStr =  @"";
            }
            
            if(self.redPackage){
                bonus_use = [self.redPackage objectForKey: @"items"];
            }else{
                bonus_use =  @"";
            }
            NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
            NSString* releaseVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
            
            NSDictionary* arg = @{ @"ince": @"save_order_ince", @"uid":self.Identity.userInfo.userID, @"get_addr_id": @"", @"send_addr_id":self.receiveAddress.rowID,
                                   @"xiao_fee":@(self.tipPrice), @"type": @"buy", @"title":self.txtName.text,@"weight": @"", @"price":self.txtPrice.text,
                                   @"price_kind": @"", @"order_mark":self.txtMark.text,@"cer_type":@"2", @"ClientV": releaseVersion, @"bonus_use":bonus_use, @"buy_addr":buyAddressStr
                                   };
            
            [self showHUD: @"订单提交中"];
            [repositories saveRandomOrder:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    [self hidHUD: @"订单提交成功"];
                    NSDictionary* data = [response objectForKey: @"data"];
                    NSString* orderID = [data objectForKey: @"ordersn"];
                    CGFloat money = [[data  objectForKey: @"total_fee"] floatValue];
                    RandomOrderPay* controller = [[RandomOrderPay alloc]initWithOrderID: orderID money:money goodsName: self.txtName.text fromOrder:NO];
                    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
                    [nav.navigationBar setBackgroundColor:theme_navigation_color];
                    [nav.navigationBar setBarTintColor:theme_navigation_color];
                    [nav.navigationBar setTintColor:theme_default_color];
                    [self presentViewController:nav animated:YES completion:nil];
                }else{
                    [self hidHUD: message];
                }
                
            }];
        }
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark =====================================================  <RandomDeliverHelpDelegate>
-(void)closeDeliveryHelp:(id)sender{
    [self.HUD hide:YES];
}

#pragma mark =====================================================  SEL
-(IBAction)silderViewChanged:(UISlider*)sender{
    self.tipPrice = (NSInteger)sender.value;
    self.labelTipPrice.text =  [WMHelper integerConvertToString:self.tipPrice];
    [self.car setDeliveryPrice:self.deliveryPrice andTip:self.tipPrice];
}

-(IBAction)switchAction:(UISwitch*)sender{
    // self.switchAnonymous.on = !self.switchAnonymous.on;
}

-(IBAction)selectedBuyAddress:(id)sender{
    BuyAddress* controller = [[BuyAddress alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    [self.view endEditing:YES];
}

-(IBAction)selectedReceiveAddress:(id)sender{
    if(self.Identity.userInfo.isLogin){
        ReceivesAddress* controller = [[ReceivesAddress alloc]initWithCategory:RandomAddressCategoryReceive];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
    [self.view endEditing:YES];
}

-(IBAction)btnDeliveryHelpTouch:(id)sender{
    self.HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    self.deliveryHelpe.item = self.dictPrice;
    [self.navigationController.view addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.dimBackground = YES;
    self.HUD.color = [UIColor clearColor];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.customView  = self.deliveryHelpe;
    [self.HUD show:YES];
}

-(IBAction)btnTipTouch:(id)sender{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.dimBackground = YES;
    self.HUD.color = [UIColor clearColor];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.customView  =self.customTipView;
    [self.HUD show:YES];
}

-(IBAction)btnTipCancelTouch:(id)sender{
    [self.HUD hide:YES];
}

-(IBAction)btnTipOKTouch:(id)sender{
    self.tipPrice = [self.txtTipPrice.text integerValue];
    if(self.tipPrice>0){
        self.labelTipPrice.text =  [WMHelper integerConvertToString:self.tipPrice];
        [self.car setDeliveryPrice:self.deliveryPrice andTip:self.tipPrice];
    }
    [self.HUD hide:YES];
}

-(IBAction)btnVouchersTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
        RandomVouchers* controller = [[RandomVouchers alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [self presentViewController:nav animated:YES completion:nil];
    }
    [self.view endEditing:YES];
}

-(IBAction)selectedAgreementTouch:(UIButton*)sender{
    self.iconAgreement.selected = !sender.selected;
}

-(IBAction)goAgreementTouch:(id)sender{
    NSURL *URL = [NSURL URLWithString: @"http://wm.wm0530.com/Public/help/xieyi_buy.html"];
    SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)businessRules:(id)sender{
    NSURL *URL = [NSURL URLWithString: @"http://wm.wm0530.com/Public/help/guize.html"];
    SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  Notification
-(void)selectedBuyAddressNotification:(NSNotification*)notification{
    self.buyAddress = [notification object];
    self.labelBuy.textColor = [UIColor blackColor];
    self.labelBuy.text = self.buyAddress.name;
    [self calculateDelivery];
}

-(void)selectedReceiveAddressNotification:(NSNotification*)notification{
    self.receiveAddress = [notification object];
    NSString* empty = [NSString stringWithFormat: @"%@ %@",self.receiveAddress.userName,self.receiveAddress.phoneNum];
    NSString* emptyAddress = [NSString stringWithFormat: @"%@ %@",self.receiveAddress.mapAddress,self.receiveAddress.mapNumber];
    NSString* str = [NSString stringWithFormat: @"%@\n%@",emptyAddress,empty];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str.length)];
    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, str.length)];
    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:empty]];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.labelReceive.attributedText = attributeStr;
    [self calculateDelivery];
}

-(void)selectedVouchersNotification:(NSNotification*)notification{
    self.redPackage= [notification object];
    self.vouchersPrice = [[self.redPackage objectForKey: @"type_money"] integerValue];
    self.labelVouchersPrice.text =[NSString stringWithFormat: @"-%@元",[WMHelper integerConvertToString:self.vouchersPrice]];
    [self.car setVouchers:self.vouchersPrice];
}

-(void)randomPayFinished:(NSNotification*)notification{
    self.txtName.text =  @"";
    self.txtMark.text =  @"";
    self.txtPrice.text =  @"";
    self.receiveAddress = nil;
    self.labelReceive.textColor = [UIColor grayColor];
    self.labelReceive.text = @"请选择收货地址(必填)";
    self.buyAddress = nil;
    self.labelBuy.textColor = [UIColor grayColor];
    self.labelBuy.text =  @"请选择购买地址(选填)";
    
    self.tipPrice = 0;
    self.labelTipPrice.text =  @"0元";
    self.silder.value = 0;
    self.redPackage = nil;
    self.labelVouchersPrice.text =  @"选择代金券";
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary* conf = [userDef dictionaryForKey:kRandomBuyConfig];
    self.deliveryPrice = [[conf objectForKey: @"ship_fee"] integerValue];
    [self.car setDeliveryPrice:self.deliveryPrice andTip:self.tipPrice];
    
    RandomOrder* controller = [[RandomOrder alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  private method
-(void)calculateDelivery{
    if(self.buyAddress && self.receiveAddress){
        NetRepositories* respositorise = [[NetRepositories alloc]init];
        NSDictionary* arg = @{ @"ince": @"get_ship_fee", @"lat1":[ NSString stringWithFormat: @"%.6f",self.buyAddress.location.latitude], @"lng1":[ NSString stringWithFormat: @"%.6f",self.buyAddress.location.longitude], @"lat2":self.receiveAddress.mapLat, @"lng2":self.receiveAddress.mapLng};
        [respositorise randomNetConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
            if(react == 1){
                self.deliveryPrice =  [[response objectForKey: @"data"] integerValue];
                self.labelDeliveryPrice.text = [NSString stringWithFormat: @"%@元", [WMHelper integerConvertToString:self.deliveryPrice]];
                self.dictPrice = @{ @"price":[WMHelper integerConvertToString:self.deliveryPrice], @"distance":[response objectForKey: @"distance"]};
                [self.car setDeliveryPrice:self.deliveryPrice andTip:self.tipPrice];
            }else{
                [self alertHUD:message];
            }
        }];
    }
}

-(BOOL)checkForm{
    if([WMHelper isEmptyOrNULLOrnil:self.txtName.text]){
        [self alertHUD: @"商品名称不能为空" delay:3];
        return NO;
    }else if (!self.receiveAddress){
        [self alertHUD: @"收货地址不能为空" delay:3];
        return NO;
    }else if (!self.iconAgreement.selected){
        [self alertHUD: @"请同意并接受《帮你买用户协议》" delay:3];
        return NO;
    }
    return YES;
}

#pragma mark =====================================================  property package
-(UIScrollView *)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[SilderScrollView alloc]init];
        _mainScroll.bounces = YES;
        _mainScroll.userInteractionEnabled = YES;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.backgroundColor=[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
        _mainScroll.ignoreSliders = YES;
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainScroll;
}

-(UIView *)orderView{
    if(!_orderView){
        RandomBuyCar* empty = [[RandomBuyCar alloc]init];
        self.car = empty;
        self.car.delegate = self;
        [self addChildViewController:self.car];
        _orderView = self.car.view;
        _orderView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _orderView;
}
-(UIView *)nameView{
    if(!_nameView){
        _nameView = [[UIView alloc]init];
        _nameView.backgroundColor = [UIColor blueColor];
        _nameView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameView;
}

-(UIImageView *)iconName{
    if(!_iconName){
        _iconName = [[UIImageView alloc]init];
        [_iconName setImage:[UIImage imageNamed: @"icon-package"]];
    }
    return _iconName;
}

-(UITextField *)txtName{
    if(!_txtName){
        _txtName = [[UITextField alloc]init];
        _txtName.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
        _txtName.borderStyle = UITextBorderStyleNone;
        _txtName.placeholder = @"输入商品名称";
        _txtName.font = [self defTitleFont];
        _txtName.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    }
    return _txtName;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout* block = [[UICollectionViewFlowLayout alloc]init];
        block.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:block];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[TagTypeCell class] forCellWithReuseIdentifier:cellIdentfier];
    }
    return _collectionView;
}

-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
    }
    return _priceView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice =[[UILabel alloc]init];
        _labelPrice.font = [self defTitleFont];
        _labelPrice.text =  @"预期商品价格";
    }
    return _labelPrice;
}

-(UITextField *)txtPrice{
    if(!_txtPrice){
        _txtPrice = [[UITextField alloc]init];
        _txtPrice.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
        _txtPrice.borderStyle = UITextBorderStyleNone;
        _txtPrice.placeholder = @"收货时支付以小票为准";
        _txtPrice.font = [self defTitleFont];
        _txtPrice.keyboardType = UIKeyboardTypeNumberPad;
        _txtPrice.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _txtPrice.textAlignment = NSTextAlignmentRight;
    }
    return _txtPrice;
}

-(UIView *)buyView{
    if(!_buyView){
        _buyView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(leftEdge+iconSize+leftEdge, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_buyView.layer addSublayer:border];
    }
    return _buyView;
}

-(UIImageView *)iconBuy{
    if(!_iconBuy){
        _iconBuy = [[UIImageView alloc]init];
        [_iconBuy setImage:[UIImage imageNamed: @"icon-sale"]];
    }
    return _iconBuy;
}

-(UIButton *)btnBuy{
    if(!_btnBuy){
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBuy addTarget:self action:@selector(selectedBuyAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBuy;
}

-(UILabel *)labelBuy{
    if(!_labelBuy){
        _labelBuy = [[UILabel alloc]init];
        _labelBuy.font = [self defTitleFont];
        _labelBuy.textColor = [UIColor colorWithRed:159/255.f green:159/255.f blue:159/255.f alpha:1.0];
        _labelBuy.text = @"请选择购买地址(选填)";
    }
    return _labelBuy;
}

-(UIImageView *)buyArrow{
    if(!_buyArrow){
        _buyArrow = [[UIImageView alloc]init];
        [_buyArrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
    }
    return _buyArrow;
}
-(UIView *)receiveView{
    if(!_receiveView){
        _receiveView = [[UIView alloc]init];
    }
    return _receiveView;
}

-(UIImageView *)iconReceive{
    if(!_iconReceive){
        _iconReceive = [[UIImageView alloc]init];
        [_iconReceive setImage:[UIImage imageNamed: @"icon-shou"]];
    }
    return _iconReceive;
}

-(UIButton *)btnReceive{
    if(!_btnReceive){
        _btnReceive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnReceive addTarget:self action:@selector(selectedReceiveAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnReceive;
}

-(UILabel *)labelReceive{
    if(!_labelReceive){
        _labelReceive = [[UILabel alloc]init];
        _labelReceive.font = [self defTitleFont];
        _labelReceive.textColor = [UIColor colorWithRed:159/255.f green:159/255.f blue:159/255.f alpha:1.0];
        _labelReceive.numberOfLines = 0;
        _labelReceive.text = @"请选择收货地址(必填)";
    }
    return _labelReceive;
}

-(UIImageView *)receiveArrow{
    if(!_receiveArrow){
        _receiveArrow = [[UIImageView alloc]init];
        [_receiveArrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
    }
    return _receiveArrow;
}

-(UIView *)timeView{
    if(!_timeView){
        _timeView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_timeView.layer addSublayer:border];
    }
    return _timeView;
}


-(UILabel *)labelTimeTitle{
    if(!_labelTimeTitle){
        _labelTimeTitle =[[UILabel alloc]init];
        _labelTimeTitle.font = [self defTitleFont];
        _labelTimeTitle.text =  @"送货时间";
    }
    return _labelTimeTitle;
}
-(UILabel *)labelTime{
    if(!_labelTime){
        _labelTime =[[UILabel alloc]init];
        _labelTime.text =  @"立即配送";
        _labelTime.font =[self defTitleFont];
        _labelTime.textAlignment = NSTextAlignmentRight;
        _labelTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTime;
}

-(UIView *)markView{
    if(!_markView){
        _markView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_markView.layer addSublayer:border];
    }
    return _markView;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark =[[UILabel alloc]init];
        _labelMark.font = [self defTitleFont];
        _labelMark.text =  @"备注";
    }
    return _labelMark;
}

-(UITextField *)txtMark{
    if(!_txtMark){
        _txtMark = [[UITextField alloc]init];
        _txtMark.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
        _txtMark.borderStyle = UITextBorderStyleNone;
        _txtMark.placeholder = @"可输入特殊要求";
        _txtMark.font = [self defTitleFont];
        _txtMark.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtMark.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _txtMark.textAlignment = NSTextAlignmentRight;
    }
    return _txtMark;
}

-(UIView *)deliveryView{
    if(!_deliveryView){
        _deliveryView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_deliveryView.layer addSublayer:border];
    }
    return _deliveryView;
}

-(UILabel *)labelDelivery{
    if(!_labelDelivery){
        _labelDelivery = [[UILabel alloc]init];
        _labelDelivery.font = [self defTitleFont];
        [_labelDelivery setContentHuggingPriority:501 forAxis:UILayoutConstraintAxisHorizontal];
        _labelDelivery.text =  @"配送费";
    }
    return _labelDelivery;
}

-(UIButton *)iconDelivery{
    if(!_iconDelivery){
        _iconDelivery = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconDelivery setImage:[UIImage imageNamed: @"icon-help"] forState:UIControlStateNormal];
        [_iconDelivery setImageEdgeInsets:UIEdgeInsetsMake(17, 0, 17, 34)];
        [_iconDelivery addTarget:self action:@selector(btnDeliveryHelpTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconDelivery;
}

-(UILabel *)labelDeliveryPrice{
    if(!_labelDeliveryPrice){
        _labelDeliveryPrice = [[UILabel alloc]init];
        _labelDeliveryPrice.font = [self defTitleFont];
        _labelDeliveryPrice.textAlignment = NSTextAlignmentRight;
    }
    return _labelDeliveryPrice;
}

-(UIView *)vouchersView{
    if(!_vouchersView){
        _vouchersView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_vouchersView.layer addSublayer:border];
    }
    return _vouchersView;
}

-(UILabel *)labelVouchers{
    if(!_labelVouchers){
        _labelVouchers = [[UILabel alloc]init];
        _labelVouchers.font = [self defTitleFont];
        _labelVouchers.text =  @"代金券";
    }
    return _labelVouchers;
}

-(UIButton *)btnVouchers{
    if(!_btnVouchers){
        _btnVouchers = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnVouchers addTarget:self action:@selector(btnVouchersTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnVouchers;
}

-(UILabel *)labelVouchersPrice{
    if(!_labelVouchersPrice){
        _labelVouchersPrice = [[UILabel alloc]init];
        _labelVouchersPrice.font = [self defTitleFont];
        _labelVouchersPrice.text =  @"选择代金券";
        _labelVouchersPrice.textColor = [UIColor grayColor];
        _labelVouchersPrice.textAlignment = NSTextAlignmentRight;
    }
    return _labelVouchersPrice;
}

-(UIImageView *)vouchersArrow{
    if(!_vouchersArrow){
        _vouchersArrow = [[UIImageView alloc]init];
        [_vouchersArrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
    }
    return _vouchersArrow;
}

-(UIView *)tipView{
    if(!_tipView){
        _tipView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_tipView.layer addSublayer:border];
    }
    return _tipView;
}

-(UILabel *)labelTipTitle{
    if(!_labelTipTitle){
        _labelTipTitle = [[UILabel alloc]init];
        _labelTipTitle.font = [self defTitleFont];
        NSString* first =  @"加小费抢单更快哦";
        NSString* str =  [NSString stringWithFormat:@"小费  %@",first];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:first]];
        _labelTipTitle.attributedText = attributeStr;
    }
    return _labelTipTitle;
}

-(UILabel *)labelTipPrice{
    if(!_labelTipPrice){
        _labelTipPrice = [[UILabel alloc]init];
        _labelTipPrice.font = [self defTitleFont];
        _labelTipPrice.text =  @"0元";
    }
    return _labelTipPrice;
}

-(UIButton *)btnTip{
    if(!_btnTip){
        _btnTip = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTip setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnTip setTitle: @"更多金额" forState:UIControlStateNormal];
        _btnTip.titleLabel.font = [self defTitleFont];
        [_btnTip setImage:[UIImage imageNamed: @"icon-arrow-cancel"] forState:UIControlStateNormal];
        _btnTip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 5, 1, itemHeight-2*topEdge-10);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_btnTip.layer addSublayer:border];
        [_btnTip addTarget:self action:@selector(btnTipTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTip;
}
-(UIView *)silderView{
    if(!_silderView){
        _silderView = [[UIView alloc]init];
    }
    return _silderView;
}

-(UISlider *)silder{
    if(!_silder){
        _silder = [[UISlider alloc]init];
        _silder.minimumValue = 0;
        _silder.maximumValue = 100;
        _silder.minimumTrackTintColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0];//当前选择部分的颜色
        _silder.maximumTrackTintColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0];//当前未选择部分颜色
        [_silder setThumbImage:[UIImage imageNamed: @"icon-silder"] forState:UIControlStateNormal];
        [_silder addTarget:self action:@selector(silderViewChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _silder;
}

-(UIView *)anonymousView{
    if(!_anonymousView){
        _anonymousView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, itemHeight-1, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        [_anonymousView.layer addSublayer:border];
    }
    return _anonymousView;
}

-(UILabel *)labelAnonymous{
    if(!_labelAnonymous){
        _labelAnonymous = [[UILabel alloc]init];
        _labelAnonymous.font = [self defTitleFont];
        _labelAnonymous.text =  @"匿名购买";
    }
    return _labelAnonymous;
}

-(UISwitch *)switchAnonymous{
    if(!_switchAnonymous){
        _switchAnonymous = [[UISwitch alloc]init];
        _switchAnonymous.on = NO;
        [_switchAnonymous addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchAnonymous;
}

-(UIView *)agreementView{
    if(!_agreementView){
        _agreementView = [[UIView alloc]init];
    }
    return _agreementView;
}

-(UIButton *)iconAgreement{
    if(!_iconAgreement){
        _iconAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconAgreement.selected = YES;
        [_iconAgreement setImage:[UIImage imageNamed: @"icon-agreement-enter"] forState:UIControlStateSelected];
        [_iconAgreement setImage:[UIImage imageNamed: @"icon-agreement-default"] forState:UIControlStateNormal];
        [_iconAgreement addTarget:self action:@selector(selectedAgreementTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconAgreement;
}

-(UIButton *)btnAgreement{
    if(!_btnAgreement){
        _btnAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAgreement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        NSString* first =  @"同意并接受";
        NSString* second =  @"《帮你买用户协议》";
        NSString* str = [NSString stringWithFormat: @"%@ %@",first,second];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{ NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:first]];
        [attributeStr addAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRed:83/255.f green:134/255.f blue:215/255.f alpha:1.f],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:second]];
        [_btnAgreement setAttributedTitle:attributeStr forState:UIControlStateNormal];
        [_btnAgreement addTarget:self action:@selector(goAgreementTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAgreement;
}


-(UIView *)customTipView{
    if(!_customTipView){
        _customTipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 140)];
        _customTipView.backgroundColor = [UIColor whiteColor];
        _customTipView.layer.masksToBounds = YES;
        _customTipView.layer.cornerRadius = 5.f;
    }
    return _customTipView;
}

-(UILabel *)labelAlertTitle{
    if(!_labelAlertTitle){
        _labelAlertTitle = [[UILabel alloc]init];
        _labelAlertTitle.text =  @"小费金额";
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 39, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_labelAlertTitle.layer addSublayer:border];
        _labelAlertTitle.textAlignment = NSTextAlignmentCenter;
        _labelAlertTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelAlertTitle;
}

-(UITextField *)txtTipPrice{
    if(!_txtTipPrice){
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label.font = [UIFont systemFontOfSize:15.f];
        label.text =  @"金额(元)";
        _txtTipPrice = [[UITextField alloc]init];
        _txtTipPrice.backgroundColor = [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:0.5];
        _txtTipPrice.borderStyle = UITextBorderStyleNone;
        _txtTipPrice.layer.masksToBounds = YES;
        _txtTipPrice.layer.cornerRadius = 5.f;
        _txtTipPrice.placeholder = @"可填写";
        _txtTipPrice.font = [UIFont systemFontOfSize:15.f];
        _txtTipPrice.keyboardType = UIKeyboardTypeNumberPad;
        _txtTipPrice.leftView = label;
        _txtTipPrice.leftViewMode = UITextFieldViewModeAlways;
        _txtTipPrice.delegate = self;
        _txtTipPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtTipPrice;
}

-(UIButton *)btnTipCancel{
    if(!_btnTipCancel){
        _btnTipCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTipCancel.backgroundColor = [UIColor whiteColor];
        [_btnTipCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_btnTipCancel setTitle: @"取消" forState:UIControlStateNormal];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, CGRectGetWidth(self.customTipView.frame), 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnTipCancel.layer addSublayer:border];
        [_btnTipCancel addTarget:self action:@selector(btnTipCancelTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnTipCancel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _btnTipCancel;
}

-(UIButton *)btnTipOK{
    if(!_btnTipOK){
        _btnTipOK = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTipOK.backgroundColor = [UIColor redColor];
        [_btnTipOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnTipOK setTitle: @"确认" forState:UIControlStateNormal];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, CGRectGetWidth(self.customTipView.frame), 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnTipOK.layer addSublayer:border];
        [_btnTipOK addTarget:self action:@selector(btnTipOKTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnTipOK.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnTipOK;
}


-(RandomDeliverHelp *)deliveryHelpe{
    if(!_deliveryHelpe){
        _deliveryHelpe = [[RandomDeliverHelp alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH*3/4, 270)];
        _deliveryHelpe.delegate = self;
    }
    return _deliveryHelpe;
}

-(UIFont*)defTitleFont{
    return [UIFont systemFontOfSize:14.f];
}

-(UIBarButtonItem *)rightBtn{
    if(!_rightBtn){
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40, 40);
        [btn addTarget:self action:@selector(businessRules:) forControlEvents:UIControlEventTouchUpInside];
        UIImage* img = [UIImage imageNamed: @"icon-random-delivery-rule"];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 0)];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:img forState:UIControlStateNormal];
        _rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _rightBtn;
}

@end
