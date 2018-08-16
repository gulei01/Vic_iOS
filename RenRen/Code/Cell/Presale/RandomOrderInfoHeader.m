//
//  RandomOrderInfoHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import "RandomOrderInfoHeader.h"

@interface RandomOrderInfoHeader ()

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* iconStatus;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UILabel* labelDate;
@property(nonatomic,strong) UILabel* labelMark;

@property(nonatomic,strong) UIView* payView;


@property(nonatomic,strong) UILabel* labelDetail;

@property(nonatomic,strong) UIView* bottomView;

@property(nonatomic,strong) UIView* homeView;

@property(nonatomic,strong) UIImageView* iconHome;
@property(nonatomic,strong) UILabel* labelHome;
@property(nonatomic,strong) UIImageView* arrowHome;

@property(nonatomic,strong) UIView* nameView;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UILabel* labelNameVal;

@property(nonatomic,strong) UIView* deliveryView;
@property(nonatomic,strong) UILabel* labelDeliviery;
@property(nonatomic,strong) UILabel* labelDelivieryVal;

@property(nonatomic,strong) UIView* tipView;
@property(nonatomic,strong) UILabel* labelTip;
@property(nonatomic,strong) UILabel* labelTipVal;

@property(nonatomic,strong) UIView* vouchersView;
@property(nonatomic,strong) UIImageView* iconVouchers;
@property(nonatomic,strong) UILabel* labelVouchers;
@property(nonatomic,strong) UILabel* labelVouchersVal;

@property(nonatomic,strong) UIView* sumView;
@property(nonatomic,strong) UILabel* labelVal;
@end

@implementation RandomOrderInfoHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = theme_line_color;
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    
    NSInteger itemHeight = 44, iconSize = 20, arrowHeight = 14, arrowWidth = 8,  titleWidth = 120,defEdge = 0, leftEdge = 10, topEdge = 10,  itemSpace = 10;
    [self addSubview:self.topView];
    [self.topView addSubview:self.iconStatus];
    [self.topView addSubview:self.labelStatus];
    [self.topView addSubview:self.labelDate];
    [self.topView addSubview:self.labelMark];
    [self.topView addSubview:self.btnStatus];
    
    [self addSubview:self.payView];
    [self.payView addSubview:self.btnCancel];
    [self.payView addSubview:self.btnPay];
    [self addSubview:self.labelDetail];
    
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.homeView];
    [self.homeView addSubview:self.btnHome];
    [self.homeView addSubview:self.iconHome];
    [self.homeView addSubview:self.labelHome];
    [self.homeView addSubview:self.arrowHome];
    [self.bottomView addSubview:self.nameView];
    [self.nameView addSubview:self.labelName];
    [self.nameView addSubview:self.labelNameVal];
    [self.bottomView addSubview:self.deliveryView];
    [self.deliveryView addSubview:self.labelDeliviery];
    [self.deliveryView addSubview:self.labelDelivieryVal];
    [self.bottomView addSubview:self.tipView];
    [self.tipView addSubview:self.labelTip];
    [self.tipView addSubview:self.labelTipVal];
    [self.bottomView addSubview:self.vouchersView];
    [self.vouchersView addSubview:self.iconVouchers];
    [self.vouchersView addSubview:self.labelVouchers];
    [self.vouchersView addSubview:self.labelVouchersVal];
    [self.bottomView addSubview:self.sumView];
    [self.sumView addSubview:self.labelVal];
    
    
    
    [self layoutConstraints:@[
                              @"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[payView]-defEdge-|",@"H:|-leftEdge-[labelDetail]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|",
                              @"V:|-defEdge-[topView(==topHeight)][payView][labelDetail(==itemHeight)][bottomView(==bottomHeight)]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30), @"bottomHeight":@(itemHeight*6),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"topView":self.topView,
                              @"payView":self.payView,
                              @"labelDetail":self.labelDetail,
                              @"bottomView":self.bottomView
                              }
                  superView:self];
    
    
    [self layoutConstraints:@[
                              @"H:|-leftEdge-[iconStatus(==iconSize)]-leftEdge-[labelStatus][labelDate(==topHeight)]-leftEdge-|",@"H:[iconStatus][labelMark][btnStatus(==topHeight)]-leftEdge-|",
                              @"V:|-topEdge-[iconStatus(==iconSize)]", @"V:|-topEdge-[labelStatus(==titleHeight)][labelMark]-defEdge-|", @"V:|-topEdge-[labelDate(==titleHeight)][btnStatus]-defEdge-|",
                              
                              ]
                    options:0
                    metrics:@{
                              @"defEdge":@(defEdge),@"topEdge":@(topEdge), @"leftEdge":@(leftEdge), @"itemSpace":@(itemSpace),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"iconStatus":self.iconStatus, @"labelStatus":self.labelStatus, @"labelDate":self.labelDate, @"labelMark":self.labelMark, @"btnStatus":self.btnStatus
                              }
                  superView:self.topView];
    
    [self layoutConstraints:@[
                              @"H:|-defEdge-[btnCancel]-defEdge-[btnPay(btnCancel)]-defEdge-|",
                               @"V:|-defEdge-[btnCancel]-defEdge-|", @"V:|-defEdge-[btnPay]-defEdge-|"
                              ]
                    options:0
                    metrics:@{ @"defEdge":@(0)}
                      views:@{ @"btnCancel":self.btnCancel, @"btnPay":self.btnPay}
                  superView:self.payView];
    
    [self layoutConstraints:@[
                              @"H:|-defEdge-[homeView]-defEdge-|",
                              @"H:|-defEdge-[nameView]-defEdge-|",
                              @"H:|-defEdge-[deliveryView]-defEdge-|",
                              @"H:|-defEdge-[tipView]-defEdge-|",
                              @"H:|-defEdge-[vouchersView]-defEdge-|",
                              @"H:|-defEdge-[sumView]-defEdge-|",
                              @"V:|-defEdge-[homeView(==itemHeight)][nameView(homeView)][deliveryView(homeView)][tipView(homeView)][vouchersView(homeView)][sumView(homeView)]-defEdge-|",
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"homeView":self.homeView, @"nameView":self.nameView, @"deliveryView":self.deliveryView, @"tipView":self.tipView, @"vouchersView":self.vouchersView, @"sumView":self.sumView
                              }
                  superView:self.bottomView];
    
    [self layoutConstraints:@[
                              @"H:|-defEdge-[btnHome]-defEdge-|", @"V:|-defEdge-[btnHome]-defEdge-|",
                              @"H:|-leftEdge-[iconHome(==iconSize)]-leftEdge-[labelHome][arrowHome(==arrowWidth)]-leftEdge-|",
                              @"V:|-iconTopEdge-[iconHome(==iconSize)]-iconTopEdge-|", @"V:|-defEdge-[labelHome]-defEdge-|",@"V:|-arrowTopEdge-[arrowHome(==arrowHeight)]-arrowTopEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"btnHome":self.btnHome, @"iconHome":self.iconHome, @"labelHome":self.labelHome, @"arrowHome":self.arrowHome
                              }
                  superView:self.homeView];
    
    
    [self layoutConstraints:@[
                              @"H:|-leftEdge-[labelName]-leftEdge-[labelNameVal(==60)]-leftEdge-|",
                              @"V:|-defEdge-[labelName]-defEdge-|",@"V:|-defEdge-[labelNameVal]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"labelName":self.labelName, @"labelNameVal":self.labelNameVal
                              }
                  superView:self.nameView];
    
    [self layoutConstraints:@[
                              @"H:|-leftEdge-[labelDeliviery]-leftEdge-[labelDelivieryVal]-leftEdge-|",
                              @"V:|-defEdge-[labelDeliviery]-defEdge-|",@"V:|-defEdge-[labelDelivieryVal]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"labelDeliviery":self.labelDeliviery, @"labelDelivieryVal":self.labelDelivieryVal
                              }
                  superView:self.deliveryView];
    
    [self layoutConstraints:@[
                              @"H:|-leftEdge-[labelTip]-leftEdge-[labelTipVal]-leftEdge-|",
                              @"V:|-defEdge-[labelTip]-defEdge-|",@"V:|-defEdge-[labelTipVal]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"labelTip":self.labelTip, @"labelTipVal":self.labelTipVal
                              }
                  superView:self.tipView];
    
    [self layoutConstraints:@[
                              @"H:|-leftEdge-[iconVouchers(==iconSize)]-leftEdge-[labelVouchers]-leftEdge-[labelVouchersVal]-leftEdge-|",
                              @"V:|-iconTopEdge-[iconVouchers(==iconSize)]-iconTopEdge-|",@"V:|-defEdge-[labelVouchers]-defEdge-|",@"V:|-defEdge-[labelVouchersVal]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"iconVouchers":self.iconVouchers, @"labelVouchers":self.labelVouchers, @"labelVouchersVal":self.labelVouchersVal
                              }
                  superView:self.vouchersView];
    
    [self layoutConstraints:@[
                              @"H:|-leftEdge-[labelVal]-leftEdge-|",
                              @"V:|-defEdge-[labelVal]-defEdge-|"
                              ]
                    options:0
                    metrics:@{
                              @"defWidth":@(SCREEN_WIDTH), @"defEdge":@(0),@"topEdge":@(10), @"leftEdge":@(10), @"itemSpace":@(10),
                              @"orderHeight":@(itemHeight),@"itemHeight":@(itemHeight), @"topHeight":@(70),
                              @"iconSize":@(iconSize),@"iconTopEdge":@((itemHeight-iconSize)/2),
                              @"titleWidth":@(titleWidth), @"titleHeight":@(30),
                              @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((itemHeight-arrowHeight)/2)
                              }
                      views:@{
                              @"labelVal":self.labelVal
                              }
                  superView:self.sumView];
    
    
}

-(void)layoutConstraints:(NSArray*)formats options:(NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views superView:(UIView*)superView{
    for (NSString* format in formats) {
        // NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
        [superView addConstraints:constraints];
    }
}
#pragma mark =====================================================  property package

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSDictionary* empty = [[item objectForKey: @"status_list"] firstObject];
        self.labelStatus.text = [empty objectForKey: @"mark"];
        self.labelMark.text = [empty objectForKey: @"note"];
        self.labelDate.text = [empty objectForKey: @"add_time"];
        self.labelName.text = [item objectForKey: @"title"];
        self.labelNameVal.text =  @"现金支付";
        self.labelDelivieryVal.text =[NSString stringWithFormat: @"￥%@",[item objectForKey: @"shipping_fee"]];
        self.labelTipVal.text = [NSString stringWithFormat: @"￥%@",[item objectForKey: @"fee"]];
        self.labelVouchersVal.text = [NSString stringWithFormat: @"-￥%@",[item objectForKey: @"voucher_fee"]];
        self.labelVal.text = [NSString stringWithFormat: @"总计 ￥%@", [item objectForKey: @"total_fee"]];
        NSInteger status = [[item objectForKey: @"status"] integerValue];
        if(status == 1){
            self.btnCancel.hidden = NO;
            self.btnPay.hidden = NO;
        }else{
            self.btnPay.hidden = YES;
            self.btnCancel.hidden = YES;
        }
        
    }
}
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIImageView *)iconStatus{
    if(!_iconStatus){
        _iconStatus = [[UIImageView alloc]init];
        [_iconStatus setImage:[UIImage imageNamed: @"icon-random-delivery"]];
        _iconStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconStatus;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStatus;
}

-(UILabel *)labelDate{
    if(!_labelDate){
        _labelDate = [[UILabel alloc]init];
        _labelDate.textColor = [UIColor grayColor];
        _labelDate.font = [UIFont systemFontOfSize:12.f];
        _labelDate.textAlignment = NSTextAlignmentRight;
        _labelDate.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDate;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.numberOfLines = 0;
        _labelMark.textColor = [UIColor grayColor];
        _labelMark.font = [UIFont systemFontOfSize:12.f];
        _labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMark;
}

-(UIButton *)btnStatus{
    if(!_btnStatus){
        _btnStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnStatus setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnStatus setTitle: @"订单状态 >" forState:UIControlStateNormal];
        _btnStatus.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _btnStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnStatus;
}

-(UIView *)payView{
    if(!_payView){
        _payView = [[UIView alloc]init];
        _payView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_payView.layer addSublayer:border];
        _payView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _payView;
}


-(UIButton *)btnCancel{
    if(!_btnCancel){
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnCancel setTitle: @"取消订单" forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnCancel;
}

-(UIButton *)btnPay{
    if(!_btnPay){
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnPay setTitle: @"去支付" forState:UIControlStateNormal];
        _btnPay.titleLabel.font = [UIFont systemFontOfSize:14.f];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, 1, 40);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnPay.layer addSublayer:border];
        _btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnPay;
}

-(UILabel *)labelDetail{
    if(!_labelDetail){
        _labelDetail = [[UILabel alloc]init];
        _labelDetail.text =  @"订单明细";
        _labelDetail.textColor = [UIColor grayColor];
        _labelDetail.font = [UIFont systemFontOfSize:14.f];
        _labelDetail.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDetail;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UIView *)homeView{
    if(!_homeView){
        _homeView = [[UIView alloc]init];
        _homeView.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _homeView;
}

-(UIButton *)btnHome{
    if(!_btnHome){
        _btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnHome.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnHome;
}

-(UIImageView *)iconHome{
    if(!_iconHome){
        _iconHome = [[UIImageView alloc]init];
        [_iconHome setImage:[UIImage imageNamed: @"icon-random-go-home"]];
        _iconHome.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconHome;
}

-(UILabel *)labelHome{
    if(!_labelHome){
        _labelHome = [[UILabel alloc]init];
        _labelHome.text =  @"随意购首页";
        _labelHome.font = [UIFont systemFontOfSize:14.f];
        _labelHome.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelHome;
}

-(UIImageView *)arrowHome{
    if(!_arrowHome){
        _arrowHome = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon-arrow-right"]];
        _arrowHome.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _arrowHome;
}

-(UIView *)nameView{
    if(!_nameView){
        _nameView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        border.backgroundColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:1.0].CGColor;
        [_nameView.layer addSublayer:border];
        _nameView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameView;
}


-(UILabel *)labelName{
    if(!_labelName){
        _labelName = [[UILabel alloc]init];
        _labelName.font = [UIFont systemFontOfSize:14.f];
        _labelName.numberOfLines = 2;
        _labelName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelName;
}

-(UILabel *)labelNameVal{
    if(!_labelNameVal){
        _labelNameVal = [[UILabel alloc]init];
        _labelNameVal.textAlignment = NSTextAlignmentRight;
        _labelNameVal.font = [UIFont systemFontOfSize:14.f];
        _labelNameVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelNameVal;
}

-(UIView *)deliveryView{
    if(!_deliveryView){
        _deliveryView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        border.backgroundColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:0.5f].CGColor;
        [_deliveryView.layer addSublayer:border];
        _deliveryView.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _deliveryView;
}


-(UILabel *)labelDeliviery{
    if(!_labelDeliviery){
        _labelDeliviery = [[UILabel alloc]init];
        _labelDeliviery.text =  @"配送费";
        _labelDeliviery.font = [UIFont systemFontOfSize:14.f];
        _labelDeliviery.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDeliviery;
}

-(UILabel *)labelDelivieryVal{
    if(!_labelDelivieryVal){
        _labelDelivieryVal = [[UILabel alloc]init];
        _labelDelivieryVal.textAlignment = NSTextAlignmentRight;
        _labelDelivieryVal.font = [UIFont systemFontOfSize:14.f];
        _labelDelivieryVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDelivieryVal;
}


-(UIView *)tipView{
    if(!_tipView){
        _tipView = [[UIView alloc]init];
        _tipView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tipView;
}

-(UILabel *)labelTip{
    if(!_labelTip){
        _labelTip = [[UILabel alloc]init];
        _labelTip.text =  @"小费";
        _labelTip.font = [UIFont systemFontOfSize:14.f];
        _labelTip.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTip;
}

-(UILabel *)labelTipVal{
    if(!_labelTipVal){
        _labelTipVal = [[UILabel alloc]init];
        _labelTipVal.textAlignment = NSTextAlignmentRight;
        _labelTipVal.font = [UIFont systemFontOfSize:14.f];
        _labelTipVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTipVal;
}

-(UIView *)vouchersView{
    if(!_vouchersView){
        _vouchersView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        border.backgroundColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:0.5f].CGColor;
        [_vouchersView.layer addSublayer:border];
        _vouchersView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _vouchersView;
}
-(UIImageView *)iconVouchers{
    if(!_iconVouchers){
        _iconVouchers = [[UIImageView alloc]init];
        [_iconVouchers setImage:[UIImage imageNamed: @"icon-random-order-vouchers"]];
        _iconVouchers.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconVouchers;
}
-(UILabel *)labelVouchers{
    if(!_labelVouchers){
        _labelVouchers = [[UILabel alloc]init];
        _labelVouchers.text =  @"代金券优惠";
        _labelVouchers.font = [UIFont systemFontOfSize:14.f];
        _labelVouchers.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelVouchers;
}

-(UILabel *)labelVouchersVal{
    if(!_labelVouchersVal){
        _labelVouchersVal = [[UILabel alloc]init];
        _labelVouchersVal.textAlignment = NSTextAlignmentRight;
        _labelVouchersVal.font = [UIFont systemFontOfSize:14.f];
        _labelVouchersVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelVouchersVal;
}

-(UIView *)sumView{
    if(!_sumView){
        _sumView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_sumView.layer addSublayer:border];
        _sumView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _sumView;
}
-(UILabel *)labelVal{
    if(!_labelVal){
        _labelVal = [[UILabel alloc]init];
        _labelVal.textAlignment = NSTextAlignmentRight;
        _labelVal.font = [UIFont systemFontOfSize:14.f];
        _labelVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelVal;
}

@end
