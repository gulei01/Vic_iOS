//
//  OrderCell.m
//  KYRR
//
//  Created by kyjun on 15/11/7.
//
//

#import "OrderCell.h"

@interface OrderCell()
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* photoIcon;
@property(nonatomic,strong) UILabel* labelOrderNo;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) UIImageView* photoGoods;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UILabel* labelGoodsNum;
@property(nonatomic,strong) UILabel* labelStoreName;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnPay;
@property(nonatomic,strong) UIButton* btnCancel;
@property(nonatomic,strong) UIButton* btnComment;
@property(nonatomic,strong) UIButton* btnDelete;
@property(nonatomic,strong) UILabel* labelPayStatus;
@property(nonatomic,strong) UIImageView* line;



@end


@implementation OrderCell{
    NSInteger middleHeight;
    NSInteger topHeight;
    NSInteger bottomHeight;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundView = [UIView new];
        self.selectedBackgroundView = [UIView new];
        [self layoutUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)layoutUI{
    topHeight = 40;
    middleHeight = 80;
    NSInteger iconSize = 20,goodsSize = 70,btnWidth=60,statusWidth=95,itemSpace=5;
    
    [self addSubview:self.topView];
    [self.topView addSubview:self.photoIcon];
    [self.topView addSubview:self.labelOrderNo];
    [self.topView addSubview:self.labelCreateDate];
    [self.topView addSubview:self.btnDelete];
    [self addSubview:self.middleView];
    [self.middleView addSubview:self.photoGoods];
    [self.middleView addSubview:self.rightView];
    [self.rightView addSubview:self.labelGoodsNum];
    [self.rightView addSubview:self.labelStoreName];
    [self.rightView addSubview:self.labelPrice];
    
    [self.rightView addSubview:self.btnPay];
    [self.rightView addSubview:self.btnCancel];
    [self.rightView addSubview:self.btnComment];
    
    [self.rightView addSubview:self.labelPayStatus];
    
    [self addSubview:self.line];
    
    NSArray* formats = @[@"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[middleView]-defEdge-|",@"H:|-defEdge-[line]-defEdge-|",
                         @"V:|-defEdge-[topView(==topHeight)][middleView(==middleHeight)]-defEdge-|", @"V:[line(==1)]-defEdge-|",
                         @"H:|-leftEdge-[photoIcon(==iconSize)]-itemSpace-[labelOrderNo][labelCreateDate]-itemSpace-[btnDelete(==30)]-defEdge-|",
                         @"V:|-topEdge-[photoIcon]-topEdge-|", @"V:|-defEdge-[labelOrderNo]-defEdge-|", @"V:|-defEdge-[labelCreateDate]-defEdge-|",@"V:|-itemSpace-[btnDelete]-itemSpace-|",
                         @"H:|-leftEdge-[photoGoods(==goodsSize)]-leftEdge-[rightView]-defEdge-|", @"V:|-defEdge-[photoGoods]-topEdge-|", @"V:|-defEdge-[rightView]-defEdge-|",
                         @"H:|-defEdge-[labelGoodsNum][btnPay(==btnWidth)]-leftEdge-|",@"H:|-defEdge-[labelStoreName][btnCancel(==btnWidth)]-leftEdge-|",
                         @"H:|-defEdge-[labelPrice][labelPayStatus(==statusWidth)]-leftEdge-|",
                         @"V:|-defEdge-[labelGoodsNum][labelStoreName(labelGoodsNum)][labelPrice(labelGoodsNum)]-topEdge-|",
                         @"V:|-itemSpace-[btnPay]-itemSpace-[btnCancel(btnPay)]-topEdge-|",
                          @"V:[labelPayStatus]-topEdge-|",
                         @"H:[btnComment(==btnWidth)]-leftEdge-|",@"V:|-15-[btnComment(==25)]"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"itemSpace":@(itemSpace),@"topHeight":@(topHeight), @"middleHeight":@(middleHeight), @"iconSize":@(iconSize),
                               @"goodsSize":@(goodsSize), @"btnWidth":@(btnWidth), @"statusWidth":@(statusWidth)};
    NSDictionary* views = @{ @"topView":self.topView, @"middleView":self.middleView, @"line":self.line,
                             @"photoIcon":self.photoIcon, @"labelOrderNo":self.labelOrderNo, @"labelCreateDate":self.labelCreateDate,
                             @"photoGoods":self.photoGoods, @"rightView":self.rightView,
                             @"labelGoodsNum":self.labelGoodsNum, @"labelStoreName":self.labelStoreName, @"labelPrice":self.labelPrice,
                             @"btnPay":self.btnPay, @"btnCancel":self.btnCancel, @"btnComment":self.btnComment, @"btnDelete":self.btnDelete, @"labelPayStatus":self.labelPayStatus};
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
}
#pragma mark =====================================================  SEL
-(IBAction)btnSendPayTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(orderGoPay:)]){
        [self.delegate orderGoPay:self.entity];
    }
}

-(IBAction)btnCancelPayTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(orderCancelOrder:)]){
        [self.delegate orderCancelOrder:self.entity];
    }
}

-(IBAction)btnCommentTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(orderAddComment:)]){
        [self.delegate orderAddComment:self.entity];
    }
}

-(IBAction)btnDeleteTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(orderDelete:item:)]){
        [self.delegate orderDelete:self item:self.entity];
    }
}

-(void)setEntity:(MOrder *)entity{
    if(entity){
        _entity = entity;
        self.btnComment.hidden = YES;
        self.labelCreateDate.text = entity.createDate;
        self.labelOrderNo.text = entity.rowID;
        [self.photoGoods sd_setImageWithURL:[NSURL URLWithString:entity.goodsImage] placeholderImage:[UIImage imageNamed:kDefaultImage]];
        if([entity.orderType isEqualToString: @"2"]){
            NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:entity.tuanMark];
            NSRange rang = [entity.tuanMark rangeOfString: @"]"];
            [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, rang.location+1)];
            self.labelGoodsNum.attributedText = attributeStr;
        }else{
            self.labelGoodsNum.text = [NSString stringWithFormat:@"%@:%@",Localized(@"Product_total"),entity.goodsCount];
        }
        self.labelStoreName.text = [NSString stringWithFormat:@"%@:%@",Localized(@"Store_txt"),entity.storeName];
        self.labelPrice.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),[entity.goodsPrice floatValue]];
        
        
        if([entity.status integerValue]==0){ //未付款
            self.labelPayStatus.hidden = YES;
            self.btnPay.hidden = NO;
            self.btnCancel.hidden = NO;
            if([entity.payType isEqualToString:@"0"]){ //货到付款只显示订单状态
                self.labelPayStatus.hidden = NO;
                self.btnCancel.hidden = YES;
                self.btnPay.hidden = YES;
                self.labelPayStatus.textColor = theme_navigation_color;
                self.labelPayStatus.text = [NSString stringWithFormat:@"%@/%@",entity.statusName,entity.payTypeName];
            }
        }else if ([entity.status integerValue]==1){//已发货x
            self.labelPayStatus.hidden = NO;
            self.btnCancel.hidden = YES;
            self.btnPay.hidden = YES;
            self.labelPayStatus.textColor = theme_navigation_color;
            self.labelPayStatus.text = [NSString stringWithFormat:@"%@",entity.statusName];
        }else if([entity.status integerValue]==2){//已付款
            self.labelPayStatus.hidden = NO;
            self.btnCancel.hidden = YES;
            self.btnPay.hidden = YES;
            self.labelPayStatus.textColor = theme_navigation_color;
            self.labelPayStatus.text = [NSString stringWithFormat:@"%@/%@",entity.statusName,entity.payTypeName];
        }else if ([entity.status integerValue]==3){//退款中
            self.labelPayStatus.hidden = NO;
            self.btnCancel.hidden = YES;
            self.btnPay.hidden = YES;
            self.labelPayStatus.textColor = theme_navigation_color;
            self.labelPayStatus.text = [NSString stringWithFormat:@"%@",entity.statusName];
        }else if ([entity.status integerValue]==4){//交易成功
            self.labelPayStatus.hidden = NO;
            self.btnCancel.hidden = YES;
            self.btnPay.hidden = YES;
            if([entity.isComment isEqualToString:@"1"]){
                self.btnComment.hidden = NO;
            }else {
                self.btnComment.hidden = YES;
            }
            self.labelPayStatus.textColor = [UIColor colorWithRed:64/255.f green:156/255.f blue:107/255.f alpha:1.0];
            self.labelPayStatus.text = [NSString stringWithFormat:@"%@/%@",entity.statusName,entity.payTypeName];
        }else if ([entity.status integerValue]==5){//取消
            self.labelPayStatus.hidden = NO;
            self.btnCancel.hidden = YES;
            self.btnPay.hidden = YES;
            self.labelPayStatus.textColor = theme_Fourm_color;
            self.labelPayStatus.text = [NSString stringWithFormat:@"%@",entity.statusName];
        }else if ([entity.status integerValue]==6){//已退款
            self.labelPayStatus.hidden = NO;
            self.btnCancel.hidden = YES;
            self.btnPay.hidden = YES;
            self.labelPayStatus.textColor = theme_navigation_color;
            self.labelPayStatus.text = [NSString stringWithFormat:@"%@",entity.statusName];
        }
        
        if([entity.orderType integerValue] ==2 ){
            if(([entity.tuanStatus integerValue]==-1) || ([entity.tuanStatus integerValue] == 1)){
                self.btnPay.hidden = YES;
                self.btnCancel.hidden = YES;
            }
        }
        if([entity.showDel integerValue]==1){
            self.btnDelete.hidden = NO;
        }else{
            self.btnDelete.hidden = YES;
        }
    }
}

#pragma mark =====================================================  property pcakge

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIImageView *)photoIcon{
    if(!_photoIcon){
        _photoIcon = [[UIImageView alloc]init];
        [_photoIcon setImage:[UIImage imageNamed:@"icon-store-default"]];
        _photoIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoIcon;
}

-(UILabel *)labelOrderNo{
    if(!_labelOrderNo){
        _labelOrderNo = [[UILabel alloc]init];
        _labelOrderNo.textColor = theme_Fourm_color;
        _labelOrderNo.font = [UIFont systemFontOfSize:14.f];
        _labelOrderNo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelOrderNo;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.textColor = theme_Fourm_color;
        _labelCreateDate.font = [UIFont systemFontOfSize:14.f];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
        _labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCreateDate;
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UIView alloc]init];
        _middleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _middleView;
}

-(UIImageView *)photoGoods{
    if(!_photoGoods){
        _photoGoods = [[UIImageView alloc]init];
        _photoGoods.layer.masksToBounds = YES;
        _photoGoods.layer.cornerRadius =5.f;
        _photoGoods.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoGoods;
}

-(UIView *)rightView{
    if(!_rightView){
        _rightView = [[UIView alloc]init];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}

-(UILabel *)labelGoodsNum{
    if(!_labelGoodsNum){
        _labelGoodsNum = [[UILabel alloc]init];
        _labelGoodsNum.font = [UIFont systemFontOfSize:15.f];
        _labelGoodsNum.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelGoodsNum;
}

-(UILabel *)labelStoreName{
    if(!_labelStoreName){
        _labelStoreName = [[UILabel alloc]init];
        _labelStoreName.textColor = theme_Fourm_color;
        _labelStoreName.font = [UIFont systemFontOfSize:15.f];
        _labelStoreName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStoreName;
}

-(UILabel *)labelPrice{
    if(!_labelPrice) {
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = [UIColor colorWithRed:62/255.f green:62/255.f blue:62/255.f alpha:1.0];
        _labelPrice.font = [UIFont systemFontOfSize:15.f];
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}
-(UIButton *)btnPay{
    if(!_btnPay){
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPay.backgroundColor = theme_navigation_color;
        [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnPay setTitle:Localized(@"Payment_txt") forState:UIControlStateNormal];
        _btnPay.titleLabel.font =[UIFont systemFontOfSize:14.f];
        _btnPay.layer.masksToBounds = YES;
        _btnPay.layer.cornerRadius =5.f;
        [_btnPay addTarget:self action:@selector(btnSendPayTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnPay;
}

-(UIButton *)btnCancel{
    if(!_btnCancel){
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.backgroundColor = [UIColor colorWithRed:41/255.f green:64/255.f blue:104/255.f alpha:1.0 ];
        [_btnCancel setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
        [_btnCancel setTitle:Localized(@"Cancel_txt") forState:UIControlStateNormal];
        _btnCancel.titleLabel.font =[UIFont systemFontOfSize:14.f];
        _btnCancel.layer.masksToBounds = YES;
        _btnCancel.layer.cornerRadius =5.f;
        [_btnCancel addTarget:self action:@selector(btnCancelPayTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnCancel;
}

-(UIButton *)btnComment{
    if(!_btnComment){
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.backgroundColor = theme_navigation_color;
        [_btnComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnComment setTitle:Localized(@"To_comment") forState:UIControlStateNormal];
        _btnComment.titleLabel.font =[UIFont systemFontOfSize:14.f];
        _btnComment.layer.masksToBounds = YES;
        _btnComment.layer.cornerRadius =5.f;
        [_btnComment addTarget:self action:@selector(btnCommentTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnComment;
}

-(UIButton *)btnDelete{
    if(!_btnDelete){
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete setImage:[UIImage imageNamed: @"icon-waste"] forState:UIControlStateNormal];
        [_btnDelete setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [_btnDelete addTarget:self action:@selector(btnDeleteTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnDelete;
}

-(UILabel *)labelPayStatus{
    if(!_labelPayStatus){
        _labelPayStatus = [[UILabel alloc]init];
        _labelPayStatus.font = [UIFont systemFontOfSize:14.f];
        _labelPayStatus.textAlignment = NSTextAlignmentRight;
        _labelPayStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPayStatus;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = theme_line_color;
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}
@end
