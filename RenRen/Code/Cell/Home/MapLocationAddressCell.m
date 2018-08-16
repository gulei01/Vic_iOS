//
//  MapLocationAddressCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/12.
//
//

#import "MapLocationAddressCell.h"


@interface MapLocationAddressCell ()

@property(nonatomic,strong) UILabel* labelAddress;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelPhone;
@property(nonatomic,strong) UILabel* line;

@end

@implementation MapLocationAddressCell


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
    [self addSubview:self.labelUserName];
    [self addSubview:self.labelPhone];
    [self addSubview:self.line];
}

-(void)layoutConstraints{
    NSArray* formats = @[  @"H:|-paddingLeft-[labelAddress]-0-|",
                           @"V:|-paddingTop-[labelAddress(==addressHeight)]",
                           @"H:|-paddingLeft-[labelUserName(==userNameWidth)]-5-[labelPhone]-|",
                           @"V:[labelAddress][labelUserName][lineView(==lineHeight)]-0-|",
                           @"V:[labelAddress][labelPhone][lineView]-0-|",
                           @"H:|-paddingLeft-[lineView]-0-|"
                           ];
    NSDictionary* metorics = @{ @"paddingLeft":@(10.f), @"paddingTop":@(10.f), @"paddingBottom":@(10.f), @"addressHeight":@(20.f), @"userNameWidth":@(80.f), @"lineHeight":@(1.f)};
    NSDictionary* views = @{ @"labelAddress":self.labelAddress, @"labelUserName":self.labelUserName, @"labelPhone":self.labelPhone, @"lineView":self.line};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self addConstraints:constraints];
    }
    
}

#pragma mark =====================================================  property packge
-(void)setEntity:(MAddress *)entity{
    if(entity){
        _entity = entity;
        self.labelAddress.text = entity.mapAddress;
        self.labelUserName.text = entity.userName;
        self.labelPhone.text = entity.phoneNum;
    }
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

-(UILabel *)labelUserName{
    if(!_labelUserName){
        _labelUserName = [[UILabel alloc]init];
        _labelUserName.font = [UIFont systemFontOfSize:14.f];
        _labelUserName.textColor = [UIColor grayColor];
        _labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelUserName;
}

-(UILabel *)labelPhone{
    if(!_labelPhone){
        _labelPhone = [[UILabel alloc]init];
        _labelPhone.font = [UIFont systemFontOfSize:14.f];
        _labelPhone.textColor = [UIColor grayColor];
        _labelPhone.textAlignment = NSTextAlignmentLeft;
        _labelPhone.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPhone;
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
