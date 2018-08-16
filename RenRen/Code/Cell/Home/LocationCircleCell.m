//
//  LocationCircleCell.m
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import "LocationCircleCell.h"

@interface LocationCircleCell()
@property(nonatomic,strong)  UILabel* labelName;
@property(nonatomic,strong)  UILabel* labelRange;
@property(nonatomic,strong) UIImageView* line;

@end

@implementation LocationCircleCell

- (void)awakeFromNib {
    
    self.backgroundColor =[UIColor whiteColor];
    [self layoutUI];
    [self layoutConstraints];
    
}


#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.labelName = [[UILabel alloc]init];
    self.labelName.textColor= theme_title_color;
    self.labelName.textAlignment = NSTextAlignmentLeft;
    self.labelName.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelName];
    
    self.labelRange = [[UILabel alloc]init];
    self.labelRange.textColor = theme_title_color;
    self.labelRange.textAlignment = NSTextAlignmentRight;
    self.labelRange.font =[UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelRange];
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.contentView addSubview:self.line];
    
}
-(void)layoutConstraints{
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelRange.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2-10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelRange addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRange attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRange attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRange attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelRange attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-0.5f]];
}

-(void)setEntity:(MCircle *)entity{
    if(entity){
        _entity = entity;
        self.labelName.text = entity.circleName;
        if([entity.status isEqualToString:@"0"]){
            if(entity.allowLocation)
                self.labelRange.text = [NSString stringWithFormat:@"%.2fkm",entity.range];
            self.labelName.enabled = YES;
            self.labelRange.hidden = NO;
            self.userInteractionEnabled = YES;
        }else {
            self.labelName.enabled = NO;
            self.labelRange.hidden = YES;
            self.userInteractionEnabled = NO;
        }
    }
}

@end
