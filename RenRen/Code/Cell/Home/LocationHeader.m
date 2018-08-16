//
//  LocationHeader.m
//  XYRR
//
//  Created by kyjun on 15/10/17.
//
//

#import "LocationHeader.h"

@interface LocationHeader()
@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UILabel* labelSection;

@end

@implementation LocationHeader{
    CGFloat headerHeight,sectionHeight;
}

- (void)awakeFromNib {
    // Initialization code
    headerHeight = 40.f;
    sectionHeight = 30.f;
    
    [self layoutUI];
    [self layoutConstraints];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1.0];
}


-(void)layoutUI{
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = [UIColor colorWithRed:235/255.f green:239/255.f blue:198/255.f alpha:1.0];
    [self addSubview:self.headerView];
    
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.text = @"猜您在:";
    self.labelTitle.textAlignment = NSTextAlignmentRight;
    self.labelTitle.textColor = theme_title_color;
    self.labelTitle.font = [UIFont systemFontOfSize:14.f];
    [self.headerView addSubview:self.labelTitle];
    
    self.labelAddress =[[UILabel alloc]init];
    self.labelAddress.textAlignment = NSTextAlignmentLeft;
    self.labelAddress.textColor = [UIColor colorWithRed:228/255.f green:134/255.f blue:40/255.f alpha:1.0];
    self.labelAddress.font = [UIFont systemFontOfSize:12.f];
    [self.headerView addSubview:self.labelAddress];
    
    self.labelSection = [[UILabel alloc]init];
    self.labelSection.textColor = theme_title_color;
    self.labelSection.textAlignment = NSTextAlignmentLeft;
    self.labelSection.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.labelSection];

}

-(void)layoutConstraints{
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSection.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:headerHeight]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:headerHeight]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:headerHeight]];
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-50]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelSection addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSection attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-30.f]];
    [self.labelSection addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSection attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:sectionHeight]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSection attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
}


-(void)setSectionWith:(NSString *)section address:(NSString *)address{
    self.labelSection.text = section;
    self.labelAddress.text = address;
}
@end
