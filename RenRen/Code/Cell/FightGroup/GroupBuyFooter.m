//
//  GroupBuyFooter.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "GroupBuyFooter.h"
#import "ZQCountDownView.h"

@interface GroupBuyFooter ()

@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) ZQCountDownView* timerView;
@property(nonatomic,strong) UIImageView* lineLeft;
@property(nonatomic,strong) UIImageView* lineRight;
@property(nonatomic,strong) UILabel* labelLeft;
@property(nonatomic,strong) UILabel* labelRight;

@end

@implementation GroupBuyFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.labelTitle];
    [self addSubview:self.timerView];
    [self addSubview:self.lineLeft];
    [self addSubview:self.labelLeft];
    [self addSubview:self.lineRight];
    [self addSubview:self.labelRight];
    
}

-(void)layoutConstraints{
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.timerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineLeft.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelLeft.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelRight.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineRight.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:66.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.labelLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.timerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.lineLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.lineLeft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineLeft attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.timerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineLeft attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineLeft attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelLeft attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f ]];
    
    [self.labelRight addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelRight addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.timerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:15.f ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.lineRight addConstraint:[NSLayoutConstraint constraintWithItem:self.lineRight attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineRight attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.timerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineRight attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineRight attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f ]];
}


-(void)endBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.labelLeft.text = @"已结束";
        self.timerView.countDownTimeInterval = 0;
    });
}

#pragma mark =====================================================  property pacakge
-(void)setEntity:(MTuan *)entity{
    if(entity){
        _entity = entity;
        if([entity.lastNum integerValue]>0){
        NSString* count = [NSString stringWithFormat:@"%@",entity.lastNum];
        NSString* str = [NSString stringWithFormat:@"还差%@人，盼您如南方人盼暖气",count];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:count]];
        self.labelTitle.attributedText = attributeStr;
        }else{
             self.labelTitle.text =  @"该团已成团,棒棒哒!";
        }
        if([entity.tuanStatus integerValue] == -1){
             self.labelTitle.text =  @"该团未成功、人数不足!";
        }
        
        NSDate* nowDate = [NSDate date];
        NSDate* endData = [WMHelper convertToDateWithStr:entity.expiredDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];
        //NSLog(@"%f",endInterval);
        if(endInterval<0){
            self.timerView.countDownTimeInterval = -endInterval;
            [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
        }else{
            
        }

    }
}
-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.0];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        
    }
    return _labelTitle;
}

-(UIImageView *)lineLeft{
    if(!_lineLeft){
        _lineLeft = [[UIImageView alloc]init];
        _lineLeft.backgroundColor = [UIColor blackColor];
    }
    return _lineLeft;
}

-(UILabel *)labelLeft{
    if(!_labelLeft){
        _labelLeft = [[UILabel alloc]init];
        _labelLeft.textColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.0];
        _labelLeft.font = [UIFont systemFontOfSize:14.f];
        _labelLeft.text = @"剩余";
    }
    return _labelLeft;
}

-(ZQCountDownView *)timerView{
    if(!_timerView){
        _timerView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(0, 0, 80, 20.f)];
        _timerView.themeColor = [UIColor colorWithRed:87/255.f green:87/255.f blue:87/255.f alpha:1.0];
        _timerView.textColor = [UIColor whiteColor];
        _timerView.textFont = [UIFont boldSystemFontOfSize:14];
    }
    return _timerView;
}

-(UILabel *)labelRight{
    if(!_labelRight){
        _labelRight = [[UILabel alloc]init];
        _labelRight.textColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.0];
        _labelRight.text = @"结束";
        _labelRight.font =[UIFont boldSystemFontOfSize:14];

    }
    return _labelRight;
}

-(UIImageView *)lineRight{
    if(!_lineRight){
        _lineRight = [[UIImageView alloc]init];
        _lineRight.backgroundColor = [UIColor blackColor];
    }
    return _lineRight;
}


@end
