//
//  ReceivesAddressCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/10.
//
//

#import "ReceivesAddressCell.h"

@interface ReceivesAddressCell ()
@property(nonatomic,strong) UIView* leftView;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UIButton* btnEdit;


@end

@implementation ReceivesAddressCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor =[UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0].CGColor;
        [self.layer addSublayer:border];
        [self addSubview:self.leftView];
        [self.leftView addSubview:self.labelName];
        [self.leftView addSubview:self.labelAddress];
        [self addSubview:self.btnEdit];
        NSInteger editWidth = self.frame.size.height,defEdge = 0,leftEdge = 10,topEdge= 10;
        NSArray* formats = @[ @"H:|-leftEdge-[leftView]-defEdge-[btnEdit(==editWidth)]-leftEdge-|", @"V:|-defEdge-[leftView]-defEdge-|", @"V:|-defEdge-[btnEdit]-defEdge-|",
                              @"H:|-defEdge-[labelName]-defEdge-|",@"H:|-defEdge-[labelAddress]-defEdge-|", @"V:|-topEdge-[labelName][labelAddress(labelName)]-topEdge-|"
                              ];
        
        NSDictionary* metrics = @{ @"defEdge":@(defEdge), @"leftEdge":@(leftEdge), @"topEdge":@(topEdge), @"editWidth":@(editWidth), @"labelHeight":@(20)};
        
        NSDictionary* views = @{ @"leftView":self.leftView, @"labelName":self.labelName, @"labelAddress":self.labelAddress, @"btnEdit":self.btnEdit};
        
        for (NSString* format in formats) {
           // NSLog( @"%@ %@",[self class],format);
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
    }
    return self;
}
#pragma mark =====================================================  SEL
-(IBAction)btnEditTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(editRecevicesAddress:)]){
        [self.delegate editRecevicesAddress:self.item];
    }
}

#pragma mark =====================================================  property packeg

-(void)setItem:(MAddress *)item{
    if(item){
        _item = item;
        self.labelName.text = [NSString stringWithFormat: @"%@ %@",item.userName,item.phoneNum];
        self.labelAddress.text = [NSString stringWithFormat: @"%@ %@",item.mapAddress,item.mapNumber];
    }
}

-(UIView *)leftView{
    if(!_leftView){
        _leftView = [[UIView alloc]init];
        _leftView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _leftView;
}
-(UILabel *)labelName{
    if(!_labelName){
        _labelName = [[UILabel alloc]init];
        _labelName.textColor = [UIColor grayColor];
        _labelName.font = [UIFont systemFontOfSize:14.f];
        _labelName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelName;
}
-(UILabel *)labelAddress{
    if(!_labelAddress){
        _labelAddress = [[UILabel alloc]init];
        _labelAddress.font = [UIFont systemFontOfSize:14.f];
        _labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelAddress;
}

-(UIButton *)btnEdit{
    if(!_btnEdit){
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnEdit setImage:[UIImage imageNamed: @"icon-edit"] forState:UIControlStateNormal];
        [_btnEdit setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        [_btnEdit addTarget:self action:@selector(btnEditTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnEdit.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnEdit;
}

@end
