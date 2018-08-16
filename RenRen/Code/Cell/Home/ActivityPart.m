//
//  ActivityPart.m
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import "ActivityPart.h"
#import "ZQCountDownView.h"


@interface ActivityPart ()

@property(nonatomic,strong) UIButton* buyNowView;
@property(nonatomic,strong) UILabel* labelBuyNow;
@property(nonatomic,strong) UIView* timerView;
@property(nonatomic,strong) UILabel* labelEnd;
@property(nonatomic,strong) ZQCountDownView* countDownView;
@property(nonatomic,strong) UIImageView* photoBuyNow;

@property(nonatomic,strong) UIButton* fightGroupView;
@property(nonatomic,strong) UILabel* labelFightGroup;
@property(nonatomic,strong) UILabel* labelCount;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIImageView* photoFightGroup;

@property(nonatomic,strong) UIImageView* line;

@property(nonatomic,strong) MBuyNow* buyNowEntity;
@property(nonatomic,strong) MFightGroup* fightGroupEntity;

@end

@implementation ActivityPart

-(instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

-(void)layoutUI{
    CALayer* border = [[CALayer alloc]init];
    border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1.0f);
    border.backgroundColor = theme_line_color.CGColor;
    [self.layer addSublayer:border];
    
    [self addSubview:self.buyNowView];
    [self.buyNowView addSubview:self.labelBuyNow];
    [self.buyNowView addSubview:self.timerView];
    self.labelEnd.frame = CGRectMake(10, 0, 50.f, 20.f);
    [self.timerView addSubview:self.labelEnd];
    self.countDownView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelEnd.frame), 0, 80, 20.f)];
    self.countDownView.themeColor = [UIColor colorWithRed:87/255.f green:87/255.f blue:87/255.f alpha:1.0];
    self.countDownView.textColor = [UIColor whiteColor];
    self.countDownView.textFont = [UIFont boldSystemFontOfSize:14];
    [self.timerView addSubview:self.countDownView];
    [self.buyNowView addSubview:self.photoBuyNow];
    
    [self addSubview:self.fightGroupView];
    [self.fightGroupView addSubview:self.labelFightGroup];
    [self.fightGroupView addSubview:self.labelCount];
    [self.fightGroupView addSubview:self.labelPrice];
    [self.fightGroupView addSubview:self.photoFightGroup];
    
    [self addSubview:self.line];
}

-(void)layoutConstraints{
    [self.buyNowView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelBuyNow setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.timerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.photoBuyNow setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.fightGroupView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelFightGroup setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.labelCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self.labelPrice setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.photoFightGroup setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.line setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.buyNowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.buyNowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.buyNowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.buyNowView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelBuyNow addConstraint:[NSLayoutConstraint constraintWithItem:self.labelBuyNow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelBuyNow attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelBuyNow attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelBuyNow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelBuyNow attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.photoBuyNow addConstraint:[NSLayoutConstraint constraintWithItem:self.photoBuyNow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.photoBuyNow addConstraint:[NSLayoutConstraint constraintWithItem:self.photoBuyNow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoBuyNow attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.timerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoBuyNow attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
   /* [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoBuyNow attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.buyNowView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoBuyNow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.buyNowView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];*/
    
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.fightGroupView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fightGroupView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fightGroupView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fightGroupView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelFightGroup addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFightGroup attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFightGroup attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFightGroup attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFightGroup attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelFightGroup attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5.f]];
    
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelFightGroup attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
    
    [self.photoFightGroup addConstraint:[NSLayoutConstraint constraintWithItem:self.photoFightGroup attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.photoFightGroup addConstraint:[NSLayoutConstraint constraintWithItem:self.photoFightGroup attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoFightGroup attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoFightGroup attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    /*
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoFightGroup attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.fightGroupView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoFightGroup attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fightGroupView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
     */
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
}

//饕餮
-(void)loadData:(MBuyNow *)buyNow fightGroup:(MFightGroup *)fightGroup{
    if(buyNow){
        _buyNowEntity = buyNow;
        [self.photoBuyNow sd_setImageWithURL:[NSURL URLWithString:buyNow.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        
        NSDate* beginDate = [WMHelper convertToDateWithStr:buyNow.beginDate format:@"yyyy-MM-dd HH:mm:ss"];
       //NSLog(@"%@",buyNow.beginDate);
        NSLog(@"%@",[WMHelper convertToStringWithDate:beginDate format:@"yyyy-MM-dd HH:mm:ss"]);
        NSDate* nowDate = [NSDate date];
        NSTimeInterval beginInterval= [nowDate timeIntervalSinceDate:beginDate];
        //NSLog(@"%f",beginInterval);
        NSDate* endData = [WMHelper convertToDateWithStr:buyNow.endDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];
        //NSLog(@"%f",endInterval);
        if(endInterval>=0){
            self.labelEnd.text = @"已结束";
           // self.buyNowView.userInteractionEnabled = NO;
            self.countDownView.countDownTimeInterval = 0;
        }else{
            if(beginInterval>0){
                self.labelEnd.text = @"距结束";
                self.countDownView.countDownTimeInterval = -endInterval;
                [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
            }else{
                self.labelEnd.text = @"距开始";
                self.countDownView.countDownTimeInterval = -beginInterval;
                [NSTimer scheduledTimerWithTimeInterval:-beginInterval target:self selector:@selector(beginBuy) userInfo:nil repeats:NO];
            }
        }
    }else{
         [self.photoBuyNow setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    if(fightGroup){
        _fightGroupEntity = fightGroup;
        [self.photoFightGroup sd_setImageWithURL:[NSURL URLWithString:fightGroup.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        NSString* str = [NSString stringWithFormat:@"%@成团",fightGroup.pingNum];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:fightGroup.pingNum]];
        self.labelCount.attributedText = attributeStr;
        
        NSString* strIcon = @"￥";
        NSString* strPrice =[NSString stringWithFormat:@"￥%@",fightGroup.marketPrice];
        str = [NSString stringWithFormat:@"%@%@ %@",strIcon,fightGroup.tuanPrice,strPrice];
        attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:fightGroup.tuanPrice]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:strPrice]];
        [_labelPrice setAttributedText:attributeStr];
    }else{
        [self.photoFightGroup setImage:[UIImage imageNamed:@"Icon-60"]];
    }
}

#pragma mark =====================================================  SEL
-(IBAction)buyNowTouch:(UIButton*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:NofificatonActivityPart object:@(sender.tag)];
}

-(void)beginBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDate* endData = [WMHelper convertToDateWithStr:self.buyNowEntity.endDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* nowDate = [NSDate date];
        NSTimeInterval secondsInterval= [endData timeIntervalSinceDate:nowDate];
        self.labelEnd.text = @"距结束";
        self.buyNowView.userInteractionEnabled = YES;
        self.countDownView.countDownTimeInterval = secondsInterval;
    });
}
-(void)endBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.labelEnd.text = @"已结束";
        self.countDownView.countDownTimeInterval = 0;
    });
}


#pragma mark ===================================================== property package
-(UIButton *)buyNowView{
    if(!_buyNowView){
        _buyNowView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyNowView addTarget:self action:@selector(buyNowTouch:) forControlEvents:UIControlEventTouchUpInside];
        _buyNowView.tag = 55;
    }
    return _buyNowView;
}

-(UILabel *)labelBuyNow{
    if(!_labelBuyNow){
        _labelBuyNow = [[UILabel alloc]init];
        [_labelBuyNow setTextColor:[UIColor redColor]];
        [_labelBuyNow setFont:[UIFont systemFontOfSize:17.f]];
        [_labelBuyNow setText:@"秒杀活动"];
    }
    return _labelBuyNow;
}

-(UILabel *)labelEnd{
    if(!_labelEnd){
        _labelEnd = [[UILabel alloc]init];
        [_labelEnd setText:@"距结束"];
        [_labelEnd setTextColor:[UIColor colorWithRed:105/255.f green:105/255.f blue:105/255.f alpha:1.0]];
        [_labelEnd setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _labelEnd;
}

-(UIView *)timerView{
    if(!_timerView){
        _timerView = [[UIView alloc]init];
    }
    return _timerView;
}


-(UIImageView *)photoBuyNow{
    if(!_photoBuyNow){
        _photoBuyNow = [[UIImageView alloc]init];
        [_photoBuyNow setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    return _photoBuyNow;
}

-(UIButton *)fightGroupView{
    if(!_fightGroupView){
        _fightGroupView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fightGroupView addTarget:self action:@selector(buyNowTouch:) forControlEvents:UIControlEventTouchUpInside];
        _fightGroupView.tag = 56;
    }
    return _fightGroupView;
}

-(UILabel *)labelFightGroup{
    if(!_labelFightGroup){
        _labelFightGroup = [[UILabel alloc]init];
        [_labelFightGroup setTextColor:[UIColor colorWithRed:254/255.f green:107/255.f blue:16/255.f alpha:1.0]];
        [_labelFightGroup setText:@"拼团购"];
        [_labelFightGroup setFont:[UIFont systemFontOfSize:17.f]];
    }
    return _labelFightGroup;
}

-(UILabel *)labelCount{
    if(!_labelCount){
        _labelCount = [[UILabel alloc]init];
        [_labelCount setTextColor:[UIColor colorWithRed:105/255.f green:105/255.f blue:105/255.f alpha:1.0]];
        [_labelCount setFont:[UIFont systemFontOfSize:12.f]];
    }
    return _labelCount;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        
    }
    return _labelPrice;
}

-(UIImageView *)photoFightGroup{
    if(!_photoFightGroup){
        _photoFightGroup = [[UIImageView alloc]init];
        [_photoFightGroup setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    return _photoFightGroup;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = theme_line_color;
    }
    return _line;
}

@end
