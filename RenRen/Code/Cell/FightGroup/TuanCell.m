//
//  TuanCell.m
//  KYRR
//
//  Created by kyjun on 16/6/16.
//
//

#import "TuanCell.h"
#import "ZQCountDownView.h"

@interface TuanCell ()

@property(nonatomic,strong) UIImageView* avatar;
@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelLast;
@property(nonatomic,strong) UILabel* labelLeft;
@property(nonatomic,strong) ZQCountDownView* timerView;
@property(nonatomic,strong) UILabel* labelRight;
@property(nonatomic,strong) UIButton* btnFightGroup;

@end

@implementation TuanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutUI{
    
    [self.contentView addSubview:self.middleView];
    [self.middleView addSubview:self.labelUserName];
    [self.middleView addSubview:self.labelLast];
    [self.middleView addSubview:self.labelLeft];
    [self.middleView addSubview:self.timerView];
    [self.middleView addSubview:self.labelRight];
    [self.middleView addSubview:self.btnFightGroup];
    [self.contentView addSubview:self.avatar];
}

-(void)layoutConstraints{
    self.middleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnFightGroup.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelLast.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelLeft.translatesAutoresizingMaskIntoConstraints = NO;
    self.timerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelRight.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.btnFightGroup addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFightGroup attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.btnFightGroup addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFightGroup attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFightGroup attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnFightGroup attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelLast addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLast attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
      [self.labelLast addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLast attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:85.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLast attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLast attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnFightGroup attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5.f]];
    
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:45.f]];
     [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelLast attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10.f]];
    
    [self.labelRight addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelRight addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnFightGroup attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f]];
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-2.f]];
    
    [self.labelLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:28.f]];
    [self.labelLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.middleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.timerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}
-(void)endBuy{
    /*if(self.delegate && [self.delegate respondsToSelector:@selector(tuanEnd)]){
        [self.delegate tuanEnd];
    }*/
     [[NSNotificationCenter defaultCenter]postNotificationName:NotificationFightGroupTuanEnd object:self.entity];
}

#pragma mark =====================================================  property package
-(void)setEntity:(MTuan *)entity{
    if(entity){
        _entity = entity;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:entity.avatar] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
         self.labelLast.text =[NSString stringWithFormat:@"还差%@人成团",entity.lastNum];
        self.labelUserName.text = entity.userName;
        NSDate* nowDate = [NSDate date];
        NSDate* endData = [WMHelper convertToDateWithStr:entity.expiredDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];
        self.timerView.countDownTimeInterval = -endInterval;
        [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
    }
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UIView alloc]init];
        _middleView.layer.masksToBounds = YES;
        _middleView.layer.cornerRadius = 20.f;
        _middleView.layer.borderColor = [UIColor redColor].CGColor;
        _middleView.layer.borderWidth = 2.f;
    }
    return _middleView;
}

-(UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc]init];
        [_avatar setImage:[UIImage imageNamed:@"icon-avatar-default"]];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius =45/2.f;
        _avatar.layer.borderColor = theme_line_color.CGColor;
        _avatar.layer.borderWidth = 1.f;
    }
    return _avatar;
} 

-(UIButton *)btnFightGroup{
    if(!_btnFightGroup){
        _btnFightGroup = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFightGroup.backgroundColor = [UIColor redColor];
        [_btnFightGroup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnFightGroup setTitle:@"去参团 >" forState:UIControlStateNormal];
        _btnFightGroup.userInteractionEnabled = NO;
    }
    return _btnFightGroup;
}

-(UILabel *)labelUserName{
    if(!_labelUserName){
        _labelUserName = [[UILabel alloc]init];
        _labelUserName.textAlignment = NSTextAlignmentLeft;
        _labelUserName.font = [UIFont systemFontOfSize:15.f];
        _labelUserName.text = @"夜来香";
    }
    return _labelUserName;
}

-(UILabel *)labelLast{
    if(!_labelLast){
        _labelLast = [[UILabel alloc]init];
        _labelLast.textAlignment = NSTextAlignmentRight;
        _labelLast.font = [UIFont systemFontOfSize:14.f];
        _labelLast.textColor = [UIColor redColor];
    }
    return _labelLast;
}

-(ZQCountDownView *)timerView{
    if(!_timerView){
        _timerView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(0, 0, 70, 20.f)];
        _timerView.themeColor = [UIColor whiteColor];
        _timerView.textColor = [UIColor colorWithRed:89/255.f green:89/255.f blue:89/255.f alpha:1.0];
        _timerView.colonColor = [UIColor colorWithRed:89/255.f green:89/255.f blue:89/255.f alpha:1.0];
        _timerView.textFont = [UIFont systemFontOfSize:12.f];
        _timerView.countDownTimeInterval = 1000;
    }
    return _timerView;
}

-(UILabel *)labelLeft{
    if(!_labelLeft){
        _labelLeft = [[UILabel alloc]init];
        _labelLeft.font = [UIFont systemFontOfSize:12.f];
        _labelLeft.textAlignment = NSTextAlignmentCenter;
        _labelLeft.textColor = [UIColor colorWithRed:89/255.f green:89/255.f blue:89/255.f alpha:1.0];
        _labelLeft.text = @"剩余";
    }
    return _labelLeft;
}

-(UILabel *)labelRight{
    if(!_labelRight){
        _labelRight = [[UILabel alloc]init];
        _labelRight.font = [UIFont systemFontOfSize:12.f];
        _labelRight.textAlignment = NSTextAlignmentCenter;
        _labelRight.textColor = [UIColor colorWithRed:89/255.f green:89/255.f blue:89/255.f alpha:1.0];
        _labelRight.text = @"结束";
    }
    return _labelRight;
}













@end
