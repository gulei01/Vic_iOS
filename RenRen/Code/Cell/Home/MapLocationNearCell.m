//
//  MapLocationNearCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/13.
//
//

#import "MapLocationNearCell.h"

@interface MapLocationNearCell ()

@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UILabel* line;

@end

@implementation MapLocationNearCell


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
    
    [self addSubview:self.labelAddress];
    [self addSubview:self.line];
}

-(void)layoutConstraints{
    NSArray* formats = @[  @"H:|-paddingLeft-[labelAddress]-0-|",
                           @"V:|-0-[labelAddress]-0-|",
                           @"V:[lineView(==lineHeight)]-0-|",
                           @"H:|-paddingLeft-[lineView]-0-|"
                           ];
    NSDictionary* metorics = @{ @"paddingLeft":@(10.f), @"paddingTop":@(10.f), @"lineHeight":@(1.f)};
    NSDictionary* views = @{ @"labelAddress":self.labelAddress, @"lineView":self.line};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self addConstraints:constraints];
    }
    
}

#pragma mark =====================================================  property packge
-(void)loadData:(NSString *)title subTitle:(NSString *)subTitle{
    self.labelAddress.text = title;
}

-(UILabel *)labelAddress{
    if(!_labelAddress){
        _labelAddress = [[UILabel alloc]init];
        _labelAddress.font =[UIFont systemFontOfSize:14.f];
        _labelAddress.textColor = [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1.0];
        _labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelAddress;
}



-(UILabel *)line{
    if(!_line){
        _line = [[UILabel alloc]init];
        _line.backgroundColor = [UIColor colorWithRed:241/255.f green:241/255.f blue:241/255.f alpha:1.0];
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}

@end
