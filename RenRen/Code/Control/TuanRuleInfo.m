//
//  TuanRuleInfo.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/2.
//
//

#import "TuanRuleInfo.h"

@interface TuanRuleInfo ()

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelDetail;

@property(nonatomic,strong) UIView* setupView;


@property(nonatomic,strong) NSArray* arrayTitle;

@end

@implementation TuanRuleInfo

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = [UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0].CGColor;
        border.fillColor = nil;
        border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH-20, 90)].CGPath;
        border.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 90);
        border.lineWidth = 1.f;
        border.lineCap = @"square";
        border.lineDashPattern = @[@4, @5];
        [self.layer addSublayer:border];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

-(void)layoutUI{
    self.arrayTitle = @[ @"选择\n心仪商品", @"支付开团\n或参团", @"等待好友\n参团支付", @"达到人数\n团购成功"];
    
    [self addSubview:self.topView];
    [self.topView addSubview:self.labelTitle];
    [self.topView addSubview:self.labelDetail];
    [self addSubview:self.setupView];
    CGFloat width = (SCREEN_WIDTH-20)/4;
    for (int columns=0;columns< _arrayTitle.count; columns++) {
        UIView* emptyView = [[UIView alloc]init];
        emptyView.frame = CGRectMake(width*columns, 0, width, 60);
        [self.setupView addSubview:emptyView];
        UILabel* labelNum = [[ UILabel alloc]init];
        labelNum.frame = CGRectMake(5, 0.f, 15.f, 15.f);
        labelNum.layer.masksToBounds = YES;
        labelNum.layer.cornerRadius = 15/2;
        labelNum.textAlignment = NSTextAlignmentCenter;
        labelNum.textColor = [UIColor redColor];
        labelNum.layer.borderColor =[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0].CGColor;
        labelNum.layer.borderWidth = 1.f;
        labelNum.font = [UIFont systemFontOfSize:13.f];
        labelNum.text = [WMHelper intConvertToString:(columns+1)];
        [emptyView addSubview:labelNum];
        UILabel* labelDes = [[UILabel alloc] init];
        labelDes.numberOfLines = 0;
        labelDes.frame = CGRectMake(5.f, 16.f, width, 40.f);
        labelDes.font = [UIFont systemFontOfSize:12.f];
        labelDes.textAlignment = NSTextAlignmentLeft;
        labelDes.textColor = [UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0];
        NSString* str = self.arrayTitle[columns];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        labelDes.attributedText = attributeStr;
        [emptyView addSubview:labelDes];
    }
    
}

-(void)layoutConstraints{
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDetail.translatesAutoresizingMaskIntoConstraints = NO;
    self.setupView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15.f]];
    
    [self.labelDetail addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDetail attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelDetail addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDetail attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDetail attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDetail attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    [self.setupView addConstraint:[NSLayoutConstraint constraintWithItem:self.setupView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.setupView addConstraint:[NSLayoutConstraint constraintWithItem:self.setupView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.setupView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.setupView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
}

#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:12.f];
        _labelTitle.textColor = [UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0];
        _labelTitle.text =  @"拼团玩法";
    }
    return _labelTitle;
}

-(UILabel *)labelDetail{
    if(!_labelDetail){
        _labelDetail = [[UILabel alloc]init];
        _labelDetail.font = [UIFont systemFontOfSize:14.f];
        _labelDetail.textAlignment = NSTextAlignmentRight;
        _labelDetail.textColor = [UIColor blackColor];
        _labelDetail.text =  @"查看详情";
    }
    return _labelDetail;
}


-(UIView *)setupView{
    if(!_setupView){
        _setupView = [[UIView alloc]init];
    }
    return _setupView;
}

@end
