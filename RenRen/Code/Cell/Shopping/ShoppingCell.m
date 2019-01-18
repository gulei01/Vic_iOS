//
//  ShoppingCell.m
//  KYRR
//
//  Created by kyjun on 15/11/4.
//
//

#import "ShoppingCell.h"


@interface ShoppingCell ()

@property(nonatomic,strong) UIButton* btnSelected;
@property(nonatomic,strong) UIImageView* photoGoods;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelDeposit;
//garfunkel add
@property(nonatomic,strong) UILabel* labelDesc;

@property(nonatomic,strong) UIButton* btnAdd;
@property(nonatomic,strong) UIButton* btnSub;
@property(nonatomic,strong) UILabel* labelCount;
@property(nonatomic,strong) UIImageView* line;

@end

@implementation ShoppingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundView = [[UIView alloc]init];
        self.selectedBackgroundView = [[UIView alloc]init];
        
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
    self.btnSelected = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnSelected setImage:[UIImage imageNamed:@"icon-address-default"] forState:UIControlStateNormal];
    [self.btnSelected setImage:[UIImage imageNamed:@"icon-address-enter"] forState:UIControlStateSelected];
    [self.btnSelected addTarget:self action:@selector(btnSelectedTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnSelected];
    
    self.photoGoods = [[UIImageView alloc]init];
    [self.contentView addSubview:self.photoGoods];
    
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectedGoodsName:)];
    [self.labelTitle addGestureRecognizer:tap];
    self.labelTitle.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelTitle];
    
    self.labelPrice = [[UILabel alloc]init];
    self.labelPrice.userInteractionEnabled = YES;
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectedGoodsName:)];
    [self.labelPrice addGestureRecognizer:tap];
    self.labelPrice.textColor = [UIColor redColor];
    self.labelPrice.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelPrice];
    
    self.labelDeposit = [[UILabel alloc]init];
    self.labelDeposit.textColor = [UIColor grayColor];
    self.labelDeposit.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:self.labelDeposit];
    
    self.labelDesc = [[UILabel alloc]init];
    self.labelDesc.textColor = [UIColor grayColor];
    self.labelDesc.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:self.labelDesc];
    
    self.labelStock = [[UILabel alloc]init];
    self.labelStock.textColor = [UIColor redColor];
    self.labelStock.font = [UIFont systemFontOfSize:17.f];
    [self.contentView addSubview:self.labelStock];
    
    self.btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
    [self.btnAdd addTarget:self action:@selector(btnAddTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnAdd];
    
    self.labelCount = [[UILabel alloc]init];
    self.labelCount.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.labelCount];
    
    self.btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnSub setImage:[UIImage imageNamed:@"icon-sub"] forState:UIControlStateNormal];
    [self.btnSub addTarget:self action:@selector(btnSubTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnSub];
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.contentView addSubview:self.line];
}

-(void)layoutConstraints{
    self.btnSelected.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoGoods.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDesc.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelStock.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCount.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnSub.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDeposit.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnSelected addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelected attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnSelected addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelected attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelected attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSelected attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    
    [self.photoGoods addConstraint:[NSLayoutConstraint constraintWithItem:self.photoGoods attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.photoGoods addConstraint:[NSLayoutConstraint constraintWithItem:self.photoGoods attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoGoods attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnSelected attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoGoods attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoGoods attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:55.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoGoods attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    
    [self.labelDeposit addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:100.f]];
    [self.labelDeposit addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDeposit attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelPrice attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoGoods attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelStock addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStock attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90.f]];
    [self.labelStock addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStock attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStock attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photoGoods attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStock attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelDesc attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnAdd attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    
    [self.btnSub addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSub attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnSub addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSub attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSub attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelCount attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSub attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

-(IBAction)didSelectedGoodsName:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedGoodsTitle:store:)]){
        [self.delegate didSelectedGoodsTitle:self.entity store:self.storeItem];
    }
}

-(IBAction)btnSelectedTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectedGoods:)]){
        [self.delegate selectedGoods:self.entity];
    }
}

-(IBAction)btnAddTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addGoodsCount:)]){
        [self.delegate addGoodsCount:self.entity];
    }
}

-(IBAction)btnSubTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(subtractionGoodsCount:)]){
        [self.delegate subtractionGoodsCount:self.entity];
    }
}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        [self.photoGoods sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage]];
        self.labelTitle.text = entity.goodsName;
        self.labelPrice.text = [NSString stringWithFormat:@"$%@",entity.price];
        self.labelCount.text = entity.quantity;
        if(!([entity.spec_desc isEqualToString:@""] && [entity.proper_desc isEqualToString:@""]))
            self.labelDesc.text = [NSString stringWithFormat:@"(%@ %@)",entity.spec_desc,entity.proper_desc];
        
        self.btnSelected.selected = entity.shopCarSelected;
        
        if([entity.deposit floatValue] > 0){
            self.labelDeposit.text = [NSString stringWithFormat:@"(%@:$%@)",Localized(@"Deposit_price"),entity.deposit];
        }else{
            self.labelDeposit.text = @"";
        }
        
    }
}

-(void)setStoreItem:(MStore *)storeItem{
    if(storeItem){
        _storeItem = storeItem;
        if([storeItem.status integerValue] == 0){
            self.btnSelected.selected = NO;
            self.btnSelected.userInteractionEnabled = NO;
        }else{
            self.btnSelected.userInteractionEnabled = YES;
        }
    }
}

@end
