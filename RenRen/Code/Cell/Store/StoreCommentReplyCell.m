//
//  StoreCommentReplyCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/21.
//
//

#import "StoreCommentReplyCell.h"

@interface StoreCommentReplyCell ()

@property(nonatomic,strong) UIImageView* backgroudImageView;
@property(nonatomic,strong) UILabel* labelComment;

@end

@implementation StoreCommentReplyCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIImage* image = [UIImage imageNamed: @"replymsg"];
        CGFloat top = 20; // 顶端盖高度
        CGFloat bottom = 5 ; // 底端盖高度
        CGFloat left = 200; // 左端盖宽度
        CGFloat right = 10; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        // 伸缩后重新赋值
        image = [image resizableImageWithCapInsets:insets];
        [self.backgroudImageView setImage:image];
        [self layoutUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.backgroundView = self.backgroudImageView;
    
    [self addSubview:self.labelComment];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
}

-(void)setReplyComment:(NSString *)replyComment{
    if(replyComment){
        self.labelComment.text = replyComment;
    }
}

-(UILabel *)labelComment{
    if(!_labelComment){
        _labelComment = [[UILabel alloc]init];
        _labelComment.textColor = [UIColor grayColor];
        _labelComment.font = [UIFont systemFontOfSize:14.f];
        _labelComment.numberOfLines = 0;
        _labelComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelComment;
}

-(UIImageView *)backgroudImageView{
    if(!_backgroudImageView){
        _backgroudImageView = [[UIImageView alloc]init];
    }
    return _backgroudImageView;
}

@end
