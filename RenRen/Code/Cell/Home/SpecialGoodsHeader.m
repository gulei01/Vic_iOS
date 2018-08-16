//
//  SpecialGoodsHeader.m
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import "SpecialGoodsHeader.h"

@interface SpecialGoodsHeader()

@property(nonatomic,strong) UIImageView* photo;

@end

@implementation SpecialGoodsHeader

- (void)awakeFromNib {
    // Initialization code
    
    self.photo = [[UIImageView alloc]init];
    [self addSubview:self.photo];
    
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    
    
}

-(void)setPhotoUrl:(NSString *)photoUrl{
    if(photoUrl)
      [ self.photo sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached];
}
@end
