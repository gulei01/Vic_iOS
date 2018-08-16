//
//  FruitInfoHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/21.
//
//

#import "FruitInfoHeader.h"
#import "Store.h"

typedef void(^contentViewComplete)(CGSize size);

@interface FruitInfoHeader ()
@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIView* titleView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIButton* btnBuy;
@property(nonatomic,strong) UIView* storeView;
@property(nonatomic,strong) UIButton*  btnStore;
@property(nonatomic,strong) UIImageView* arrow;

@property (nonatomic,copy) contentViewComplete  completBlock;

@property(nonatomic,strong) MGoods* entity;
@end

@implementation FruitInfoHeader


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutUI];
    [self layoutConstraints];
     //[self clearCache];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.photo];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleView];
    [self.titleView addSubview:self.labelTitle];
    [self.bottomView addSubview:self.priceView];
    [self.priceView addSubview:self.labelPrice];
    [self.priceView addSubview:self.labelSale];
    [self.priceView addSubview:self.btnBuy];
    [self.bottomView addSubview:self.storeView];
    [self.storeView addSubview:self.btnStore];
    [self.storeView addSubview:self.arrow];
}

-(void)layoutConstraints{
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    self.storeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnStore.translatesAutoresizingMaskIntoConstraints = NO;
    self.arrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:140.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint  constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.titleView addConstraint:[NSLayoutConstraint  constraintWithItem:self.titleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint  constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.self.titleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.self.titleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.]];
    
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.]];
    
}

-(void)loadData:(MGoods *)entity complete:(void (^)(CGSize))complete{
    if(entity){
        _entity = entity;
        self.completBlock = complete;
        self.labelTitle.text = entity.goodsName;
        NSString* strIcon = @"￥";
        NSString* strPrice = [NSString stringWithFormat:@"￥%@",entity.maketPrice];
        NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,entity.price,strPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.price]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:strPrice]];
        [self.labelPrice setAttributedText:attributeStr];
        self.labelSale.text = [NSString stringWithFormat:@"剩%@份",entity.stock];
        [self.btnStore setTitle:entity.storeName forState:UIControlStateNormal];
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.maxImage] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGFloat width = SCREEN_WIDTH;
            CGFloat height = image.size.height*width/image.size.width;
            if(self.completBlock){
                self.completBlock(CGSizeMake(width, height));
            }
        }];
        // [self clearCache];
        if([entity.storeStatus integerValue] == 1){
            if([entity.stock integerValue]==0){
                self.btnBuy.userInteractionEnabled = NO;
                self.btnBuy.backgroundColor = [UIColor grayColor];
                [self.btnBuy setTitle: @"抢完啦" forState:UIControlStateNormal];
            }else{
                self.btnBuy.userInteractionEnabled = YES;
                self.btnBuy.backgroundColor = [UIColor redColor];
                [self.btnBuy setTitle: @"立即抢购" forState:UIControlStateNormal];
            }
        }else{
            self.btnBuy.userInteractionEnabled = NO;
            self.btnBuy.backgroundColor = [UIColor grayColor];
            [self.btnBuy setTitle: @"休息中" forState:UIControlStateNormal];
        }
    }
}

#pragma mark =====================================================  SEL
-(IBAction)addCarTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
        [self showHUD];
        NSDictionary* arg = @{@"ince":@"addcart",@"fid":self.entity.rowID,@"uid":self.Identity.userInfo.userID,@"num":@"1"};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                [self hidHUD:@"添加成功!"];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshShopCar object:nil];
            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
            }
        }];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(IBAction)btnStoreTouch:(id)sender{
    MStore* item =[[MStore alloc]init];
    item.rowID =self.entity.storeID;
    Store* controller = [[Store alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark =====================================================  property package

-(UIImageView *)photo{
    if(!_photo){
        _photo =[[UIImageView alloc]init];
    }
    return _photo;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}

-(UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc]init];
    }
    return _titleView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1.0];
        _labelTitle.textColor = [UIColor colorWithRed:81/255.f green:81/255.f blue:81/255.f alpha:1.0];
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
        _labelTitle.numberOfLines = 2;
        _labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _labelTitle;
}

-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
        _priceView.backgroundColor = [UIColor whiteColor];
    }
    return _priceView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
    }
    return _labelPrice;
}


-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.font = [UIFont systemFontOfSize:12.f];
        _labelSale.textColor = [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1.0];
    }
    return _labelSale;
}

-(UIButton *)btnBuy{
    if(!_btnBuy){
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBuy setBackgroundColor:[UIColor redColor]];
        [_btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBuy setTitle:@"加入购物车" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _btnBuy.layer.masksToBounds = YES;
        _btnBuy.layer.cornerRadius = 5.f;
        [_btnBuy addTarget:self action:@selector(addCarTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBuy;
}

-(UIView *)storeView{
    if(!_storeView){
        _storeView = [[UIView alloc]init];
    }
    return _storeView;
}

-(UIButton *)btnStore{
    if(!_btnStore){
        _btnStore =[[UIButton alloc]init];
        _btnStore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnStore.imageEdgeInsets = UIEdgeInsetsMake(15/2, 10, 15/2, SCREEN_WIDTH-35);
        _btnStore.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btnStore setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        [_btnStore setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        _btnStore.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnStore.backgroundColor = [UIColor whiteColor];
        [_btnStore addTarget:self action:@selector(btnStoreTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnStore;
}

-(UIImageView *)arrow{
    if(!_arrow){
        _arrow = [[UIImageView alloc]init];
        [_arrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    }
    return _arrow;
}

@end
