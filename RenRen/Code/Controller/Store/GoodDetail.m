//
//  GoodDetail.m
//  RenRen
//
//  Created by Garfunkel on 2019/1/9.
//

#import "GoodDetail.h"

@interface GoodDetail ()

@property(nonatomic,strong)UIView* subView;
@property(nonatomic,strong)UIButton* btnClose;
@property(nonatomic,strong)UIImageView* imgDefault;
@property(nonatomic,strong)UIView* goodView;
@property(nonatomic,strong)UILabel* goodTitle;
@property(nonatomic,strong)UILabel* goodPrice;
@property(nonatomic,strong)UILabel* goodDeposit;
@property(nonatomic,strong)UITextView* goodDesc;

@end

@implementation GoodDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [self.view addGestureRecognizer:tapGesture];
    [self.view addSubview:self.subView];
    
    [self layoutUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(instancetype)initWithItem:(MGoods *)entity{
    self = [super init];
    if(self){
        self.entity = entity;
    }
    return self;
}

-(void)layoutUI{
    [self.subView addSubview:self.btnClose];
    [self.subView addSubview:self.imgDefault];
    
    [self.subView addSubview:self.goodView];
    [self.goodView addSubview:self.goodTitle];
    [self.goodView addSubview:self.goodPrice];
    [self.goodView addSubview:self.goodDeposit];
    
    [self.subView addSubview:self.goodDesc];
    
    NSArray* formats = @[@"H:[btnClose(==20)]-10-|",@"V:|-10-[btnClose(==20)]",
                         @"H:|-leftEdge-[imgDefault(==120)]-leftEdge-[goodView]-defEdge-|",
                         @"H:|-leftEdge-[goodDesc]-leftEdge-|",
                         @"V:|-40-[imgDefault(==84)]",@"V:|-40-[goodView(==84)]-10-[goodDesc]-10-|",
                         @"H:|-0-[goodTitle]-0-|",@"H:|-0-[goodDeposit]-0-|",@"H:|-0-[goodPrice]-0-|",
                         @"V:|-2-[goodTitle(==40)][goodDeposit(==15)]-12-[goodPrice(==15)]",
                         ];
    
    NSDictionary* metrics = @{ @"defEdge":@(0),@"iconSize":@(25), @"leftEdge":@(10),@"padding":@(15),@"paddbot":@(18)};
    
    NSDictionary* views = @{@"btnClose":self.btnClose,@"imgDefault":self.imgDefault,@"goodView":self.goodView,
                            @"goodTitle":self.goodTitle,@"goodDeposit":self.goodDeposit,@"goodPrice":self.goodPrice,
                            @"goodDesc":self.goodDesc
                            };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.subView addConstraints:constraints];
    }];
}

-(void)loadData{
    [self.imgDefault sd_setImageWithURL:[NSURL URLWithString:self.entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached completed:nil];
    self.goodTitle.text = self.entity.goodsName;
    
    if([self.entity.deposit floatValue] > 0){
        self.goodDeposit.hidden = NO;
        self.goodDeposit.text = [NSString stringWithFormat:@"%@:$%@",Localized(@"Deposit_price"),self.entity.deposit];
    }else{
        self.goodDeposit.hidden = YES;
    }
    
    self.goodPrice.text = [NSString stringWithFormat:@"$%@",self.entity.price];
    
    self.goodDesc.text = self.entity.desc;
}

-(void)closeView{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

-(UIView *)subView{
    if(!_subView){
        _subView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.25, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.5)];
        _subView.backgroundColor = [UIColor whiteColor];
        _subView.layer.cornerRadius = 10.0;
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_subView addGestureRecognizer:tapGesture];
    }
    
    return _subView;
}

-(UIButton *)btnClose{
    if(!_btnClose){
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setImage:[UIImage imageNamed:@"icon-close-gray"] forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
        _btnClose.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnClose;
}

-(UIImageView *)imgDefault{
    if(!_imgDefault){
        _imgDefault = [[UIImageView alloc]init];
        _imgDefault.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgDefault;
}

-(UIView *)goodView{
    if(!_goodView){
        _goodView = [[UIView alloc]init];
        _goodView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _goodView;
}

-(UILabel *)goodTitle{
    if(!_goodTitle){
        _goodTitle = [[UILabel alloc]init];
        _goodTitle.font = [UIFont systemFontOfSize:16.f];
        _goodTitle.numberOfLines = 0;
        _goodTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _goodTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _goodTitle;
}

-(UILabel *)goodPrice{
    if(!_goodPrice){
        _goodPrice = [[UILabel alloc]init];
        _goodPrice.font = [UIFont systemFontOfSize:14.f];
        [_goodPrice setTextColor:[UIColor redColor]];
        _goodPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _goodPrice;
}

-(UILabel *)goodDeposit{
    if(!_goodDeposit){
        _goodDeposit = [[UILabel alloc]init];
        _goodDeposit.font = [UIFont systemFontOfSize:12.f];
        [_goodDeposit setTextColor:[UIColor grayColor]];
        _goodDeposit.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _goodDeposit;
}

-(UITextView *)goodDesc{
    if(!_goodDesc){
        _goodDesc = [[UITextView alloc]init];
        _goodDesc.font = [UIFont systemFontOfSize:14.f];
        
        _goodDesc.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _goodDesc;
}

@end
