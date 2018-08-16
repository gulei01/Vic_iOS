//
//  EditAddressMapCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/9.
//
//

#import "EditAddressMapCell.h"

@interface EditAddressMapCell ()

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelAddress;
@property(nonatomic,strong) UILabel* line;

@end

@implementation EditAddressMapCell

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

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.icon];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelAddress];
    [self addSubview:self.line];
}

-(void)layoutConstraints{
    NSArray* formats = @[ @"H:|-5-[iconView(==20)]", @"V:|-15-[iconView(==20)]",
                          @"H:[iconView]-5-[titleView]-|", @"V:|-5-[titleView(==titleHeight)][addressView][lineView(==lineHeight)]-0-|",
                          @"H:[iconView]-5-[addressView]-|",
                          @"H:[iconView]-5-[lineView]-0-|"
                          ];
    NSDictionary* metorics = @{ @"titleHeight":@(20.f), @"lineHeight":@(2.f)};
    NSDictionary* views = @{ @"iconView":self.icon, @"titleView":self.labelTitle, @"addressView":self.labelAddress, @"lineView":self.line};

    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self addConstraints:constraints];
    }
   
}

-(void)loadData:(NSString *)title subTitle:(NSString *)subTitle{
    self.labelTitle.text = title;
    self.labelAddress.text = subTitle;
}

#pragma mark =====================================================  property packge
-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.translatesAutoresizingMaskIntoConstraints =NO;
        [_icon setImage:[UIImage imageNamed: @"locate"]];
    }
    return _icon;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font =[UIFont systemFontOfSize:14.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UILabel *)labelAddress{
    if(!_labelAddress){
        _labelAddress = [[UILabel alloc]init];
        _labelAddress.font = [UIFont systemFontOfSize:14.f];
        _labelAddress.textColor = [UIColor grayColor];
        _labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelAddress;
}

-(UILabel *)line{
    if(!_line){
        _line = [[UILabel alloc]init];
        _line.backgroundColor = theme_line_color;
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}

@end
