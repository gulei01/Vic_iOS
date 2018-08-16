//
//  PointsMallHeader.m
//  KYRR
//
//  Created by kyjun on 16/5/9.
//
//

#import "PointsMallHeader.h"

@interface PointsMallHeader ()

@property(nonatomic,strong) UIImageView* topImage;
@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) UIButton* btnPoints;
@property(nonatomic,strong) UIButton* btnRecord;
@property(nonatomic,strong) UIButton* btnRule;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation PointsMallHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:240/255.f green:239/255.f blue:237/255.f alpha:1.0];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.topImage];
    [self addSubview:self.middleView];
    [self.middleView addSubview:self.btnPoints];
    [self.middleView addSubview:self.btnRecord];
    [self.middleView addSubview:self.btnRule];
    NSArray* array = @[self.btnPoints,self.btnRecord,self.btnRule];
    NSArray* arrayIcon = @[@"icon-point-point",@"icon-point-record",@"icon-point-help"];
    NSArray* arrayTitle = @[@"200积分",@"兑换记录",@"积分规则"];
    NSInteger index = 0;
    for (UIButton* btn in array) {
        UIImageView* photo = [[UIImageView alloc]init];
        photo.frame = CGRectMake(0,0, 20, 20);
        photo.center = CGPointMake(SCREEN_WIDTH/3/2, 15);
        [photo setImage:[UIImage imageNamed:arrayIcon[index]]];
        [btn addSubview:photo];
        UILabel* title = [[ UILabel alloc]init];
        title.tag = 55;
        title.frame = CGRectMake(0, 25.f, SCREEN_WIDTH/3, 20);
        title.text = arrayTitle[index];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:14.f];
        title.textColor = [UIColor colorWithRed:120/255.f green:118/255.f blue:118/255.f alpha:1.0];
        [btn addSubview:title];
        index++;
    }
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelTitle];
}

-(void)layoutConstraints{
    self.topImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.middleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnPoints.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnRecord.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnRule.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topImage addConstraint:[NSLayoutConstraint constraintWithItem:self.topImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.f]];
    [self.topImage addConstraint:[NSLayoutConstraint constraintWithItem:self.topImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.topImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topImage attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnPoints addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPoints attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.btnPoints addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPoints attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPoints attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPoints attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnRecord addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRecord attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.btnRecord addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRecord attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRecord attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRecord attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnPoints attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnRule addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.btnRule addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRule attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRule attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnRule attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnRecord attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
}


-(void)loadData:(NSString *)points topImg:(NSString *)topImg{
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:topImg] placeholderImage:[UIImage imageNamed:@"lALO0RuFbcy-zQKA_640_190.png_620x10000q90g.jpg"] options:SDWebImageRefreshCached];
    NSString* str =[NSString stringWithFormat:@"%@积分",points];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.f green:178/255.f blue:0/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:points]];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:120/255.f green:118/255.f blue:118/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:@"积分"]];
    id label =  [self.btnPoints viewWithTag:55];
    if([label isKindOfClass:[UILabel class]]){
        ((UILabel*)label).attributedText = attributeStr;
    }else{
        
    }
    
}

#pragma mark =====================================================  SEL
-(IBAction)pointRecordTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(pointsRecord)]){
        [self.delegate pointsRecord];
    }
}

-(IBAction)pointExchangeTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(pointExchange)]){
        [self.delegate pointExchange];
    }
}

-(IBAction)pointRuleTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(pointsRule)]){
        [self.delegate pointsRule];
    }
}

#pragma mark =====================================================  property package
-(UIImageView *)topImage{
    if(!_topImage){
        _topImage    = [[UIImageView alloc]init];
    }
    return _topImage;
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UIView alloc]init];
        _middleView.backgroundColor = [UIColor whiteColor];
    }
    return _middleView;
}

-(UIButton *)btnPoints{
    if(!_btnPoints){
        _btnPoints = [UIButton buttonWithType:UIButtonTypeCustom];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(SCREEN_WIDTH/3-1, 5.f, 1.f, 40.f);
        border.backgroundColor = [UIColor colorWithRed:240/255.f green:239/255.f blue:237/255.f alpha:1.0].CGColor;
        [_btnPoints.layer addSublayer:border];
        [_btnPoints addTarget:self action:@selector(pointRecordTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPoints;
}

-(UIButton *)btnRecord{
    if(!_btnRecord){
        _btnRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(SCREEN_WIDTH/3-1, 5.f, 1.f, 40.f);
        border.backgroundColor = [UIColor colorWithRed:240/255.f green:239/255.f blue:237/255.f alpha:1.0].CGColor;
        [_btnRecord.layer addSublayer:border];
        [_btnRecord addTarget:self action:@selector(pointExchangeTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRecord;
}

-(UIButton *)btnRule{
    if(!_btnRule){
        _btnRule = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRule addTarget:self action:@selector(pointRuleTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRule;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 39.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = [UIColor colorWithRed:231/255.f green:229/255.f blue:226/255.f alpha:1.0].CGColor;
        [_bottomView.layer addSublayer:border];
    }
    return _bottomView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor colorWithRed:56/255.f green:56/255.f blue:56/255.f alpha:1.0];
        _labelTitle.text = @"积分好礼";
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
    }
    return _labelTitle;
}


@end
