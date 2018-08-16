//
//  StoreCommentCell.m
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import "StoreCommentCell.h"

@interface StoreCommentCell ()

@property(nonatomic,strong) UIImageView* avatar;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UILabel* labelComment;
@property(nonatomic,strong) UIView* starView;

@property(nonatomic,strong) UIImageView* line;

@property(nonatomic,strong) NSMutableArray* arrayStar;



@end

@implementation StoreCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark =====================================================  User interface layout
-(void)layoutUI{
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.labelUserName];
    [self.contentView addSubview:self.labelCreateDate];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.labelComment];
    [self.contentView addSubview:self.line];
    
    self.arrayStar =[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20*i, 0, 15, 15);
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-star-default"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-star-enter"] forState:UIControlStateSelected];
        [self.starView addSubview:btn];
        [self.arrayStar addObject:btn];
    }
}

-(void)layoutConstraints{

    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.starView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelComment.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35.f]];
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.starView addConstraint:[NSLayoutConstraint constraintWithItem:self.starView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.f]];
    [self.starView addConstraint:[NSLayoutConstraint constraintWithItem:self.starView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.starView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelUserName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.starView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.starView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.0f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}

#pragma mark =====================================================  property package

-(void)setEntity:(MComment *)entity{
    if(entity){
        _entity = entity;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:entity.avatar] placeholderImage:[UIImage imageNamed: @"Icon-60"]];
        self.labelUserName.text = entity.userName;
       // NSDate* date =[WMHelper convertToDateWithStr:entity.createDate];
        self.labelCreateDate.text = entity.createDate;//   [WMHelper convertToStringWithDate:date format:@"yyyy.MM.dd" ];
        self.labelComment.text = entity.comment;
        NSInteger star = [entity.scoreToal integerValue];
        for (UIButton *btn in self.arrayStar) {
            if(btn.tag< star){
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
    }
}

-(UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc]init];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 35/2.f;
    }
    return _avatar;
}

-(UILabel *)labelUserName{
    if(!_labelUserName){
        _labelUserName =[[UILabel alloc]init];
        _labelUserName.textColor = [UIColor colorWithRed:142/255.f green:142/255.f blue:142/255.f alpha:1.0];
        _labelUserName.font = [UIFont systemFontOfSize:14.f];
        _labelUserName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _labelUserName;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate =[[UILabel alloc]init];
        _labelCreateDate.textColor = [UIColor colorWithRed:142/255.f green:142/255.f blue:142/255.f alpha:1.0];
        _labelCreateDate.font = [UIFont systemFontOfSize:12.f];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
    }
    return _labelCreateDate;
}

-(UILabel *)labelComment{
    if(!_labelComment){
        _labelComment = [[UILabel alloc]init];
        _labelComment.numberOfLines = 0;
       // _labelComment.lineBreakMode = NSLineBreakByWordWrapping;
        _labelComment.font =[UIFont systemFontOfSize:14.f];
    }
    return _labelComment;
}

-(UIView *)starView{
    if(!_starView){
        _starView = [[UIView alloc]init];
    }
    return _starView;
}

-(UIImageView *)line{
    if(!_line){
        _line =[[UIImageView alloc]init];
        _line.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
    }
    return _line;
}

@end
