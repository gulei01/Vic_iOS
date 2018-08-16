//
//  BuyNowItemHeader.m
//  KYRR
//
//  Created by kyjun on 16/6/22.
//
//

#import "BuyNowItemHeader.h"
#import "ZQCountDownView.h"
#import "Store.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

typedef void(^contentViewComplete)(CGSize size);

@interface BuyNowItemHeader ()

@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIImageView* icon;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIView* titleView;
@property(nonatomic,strong) UILabel* labelTitle;

@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UITextField* txtTimer;
@property(nonatomic,strong) UIImageView* leftView;
@property(nonatomic,strong) ZQCountDownView* rightView;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIButton* btnBuy;

@property(nonatomic,strong) UIView* storeView;
@property(nonatomic,strong) UIButton*  btnStore;
@property(nonatomic,strong) UIImageView* arrow;

@property(nonatomic,strong) UIView* descView;
@property(nonatomic,strong) UILabel* labelDesc;

@property (nonatomic,copy) contentViewComplete  completBlock;

@property(nonatomic,strong) MBuyNow* entity;

@end

@implementation BuyNowItemHeader


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self layoutUI];
    [self layoutConstraints];
    self.btnBuy.hidden = YES;
   // [self clearCache];
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
    [self.photo addSubview:self.icon];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleView];
    [self.titleView addSubview:self.labelTitle];
    
    [self.bottomView addSubview:self.priceView];
    [self.priceView addSubview:self.labelPrice];
    [self.priceView addSubview:self.txtTimer];
    [self.priceView addSubview:self.labelSale];
    [self.priceView addSubview:self.btnBuy];
    
    [self.bottomView addSubview:self.storeView];
    [self.storeView addSubview:self.btnStore];
    [self.storeView addSubview:self.arrow];
    [self.bottomView addSubview:self.descView];
    [self.descView addSubview:self.labelDesc];
    
}

-(void)layoutConstraints{
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.priceView.translatesAutoresizingMaskIntoConstraints =NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtTimer.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.storeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnStore.translatesAutoresizingMaskIntoConstraints = NO;
    self.arrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.descView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDesc.translatesAutoresizingMaskIntoConstraints = NO;
     
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:170.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
 
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
    [self.txtTimer addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.txtTimer addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:130.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.]];
    
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:130.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtTimer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.]];
    
  
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.]];
    
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.]];
    
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];

}


-(void)loadData:(MBuyNow *)entity complete:(void (^)(CGSize))complete{
    if(entity){
        _entity = entity;
        self.completBlock = complete;
        
        self.labelTitle.text = entity.goodsName;
        NSString* strIcon = @"￥";
        NSString* strPrice = [NSString stringWithFormat:@"￥%@",entity.marketPrice];
        NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,entity.buyNowPrice,strPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.buyNowPrice]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:strPrice]];
        [self.labelPrice setAttributedText:attributeStr];
        
        NSDate* beginDate = [WMHelper convertToDateWithStr:entity.beginDate format:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate* nowDate = [NSDate date];
        NSTimeInterval beginInterval= [nowDate timeIntervalSinceDate:beginDate];
      
        NSDate* endData = [WMHelper convertToDateWithStr:entity.endDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];
        
        if(endInterval>=0){
            self.txtTimer.text = @"已结束";
            self.btnBuy.hidden = NO;
            self.btnBuy.userInteractionEnabled = NO;
            self.btnBuy.backgroundColor = [UIColor grayColor];
            [self.btnBuy setTitle:@"已结束" forState:UIControlStateNormal];
            self.rightView.countDownTimeInterval = 0;
        }else{
            if(beginInterval>0){
                self.txtTimer.text = @"距结束";
                self.btnBuy.hidden = NO;
                self.rightView.countDownTimeInterval = -endInterval;
                [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
            }else{
                self.txtTimer.text = @"距开始";
                self.btnBuy.hidden = YES;
                self.rightView.countDownTimeInterval = -beginInterval;
                [NSTimer scheduledTimerWithTimeInterval:-beginInterval target:self selector:@selector(beginBuy) userInfo:nil repeats:NO];
            }
        }
        self.labelSale.text = [NSString stringWithFormat:@"剩%@份",entity.goodsStock];
        [self.btnStore setTitle:entity.storeName forState:UIControlStateNormal];
       
        [self.photo sd_setImageWithURL:[NSURL URLWithString: entity.thumbnails] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cacheType = SDImageCacheTypeNone;
//             [[SDImageCache sharedImageCache ]removeImageForKey:entity.thumbnails];
            [[SDImageCache sharedImageCache] removeImageForKey:NULL withCompletion:NULL];
            if(CGSizeEqualToSize(self.entity.thumbnailsSize, CGSizeZero)){
                CGFloat width = SCREEN_WIDTH;
                CGFloat height = image.size.height*width/image.size.width;
                self.entity.thumbnailsSize=CGSizeMake(width, height);
                if(self.completBlock){
                    self.completBlock(self.entity.thumbnailsSize);
                }
            }
        }];
       // [self clearCache];
         if([entity.storeStatus integerValue] == 1){
            if([entity.goodsStock integerValue]==0){
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
-(void)beginBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDate* endData = [WMHelper convertToDateWithStr:self.entity.endDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* nowDate = [NSDate date];
        NSTimeInterval secondsInterval= [endData timeIntervalSinceDate:nowDate];
        self.txtTimer.text = @"距结束";
        self.btnBuy.hidden = NO;
        self.rightView.countDownTimeInterval = secondsInterval;
    });
}
-(void)endBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.txtTimer.text = @"已结束";
        self.btnBuy.hidden = NO;
        self.btnBuy.userInteractionEnabled = NO;
        self.btnBuy.backgroundColor = [UIColor grayColor];
        [self.btnBuy setTitle:@"已结束" forState:UIControlStateNormal];
        self.rightView.countDownTimeInterval = 0;
    });
}

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
     //   [_photo setImage:[UIImage imageNamed:@"default-640x300@2x"]];
    }
    return _photo;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed:@"icon-buy-icon"]];
    }
    return _icon;
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

-(UITextField *)txtTimer{
    if(!_txtTimer){
        _txtTimer = [[UITextField alloc]init];
        [_txtTimer setBackgroundColor:[UIColor whiteColor]];
        _txtTimer.textColor = [UIColor redColor];
        _txtTimer.borderStyle=UITextBorderStyleNone;
        _txtTimer.layer.borderColor =[UIColor redColor].CGColor;
        _txtTimer.font = [UIFont systemFontOfSize:12.f];
        _txtTimer.layer.borderWidth = 1.0f;
        _txtTimer.layer.masksToBounds = YES;
        _txtTimer.layer.cornerRadius = 5.f;
        _txtTimer.leftView = self.leftView;
        _txtTimer.leftViewMode =UITextFieldViewModeAlways;
        _txtTimer.rightView = self.rightView;
        _txtTimer.rightViewMode = UITextFieldViewModeAlways;
        [_txtTimer setTextAlignment:NSTextAlignmentCenter];
        _txtTimer.userInteractionEnabled = NO;
    }
    return _txtTimer;
}

-(UIImageView *)leftView{
    if(!_leftView){
        _leftView = [[UIImageView alloc]init];
        _leftView.frame = CGRectMake(0, 0, 20.f, 20.f);
        [_leftView setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    return _leftView;
}

-(ZQCountDownView *)rightView{
    if(!_rightView){
        _rightView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(-10, 0, 66, 20.f)];
        _rightView.themeColor = [UIColor whiteColor];
        _rightView.textColor = [UIColor redColor];
        _rightView.colonColor = [UIColor redColor];
        _rightView.textFont = [UIFont systemFontOfSize:12.f];
    }
    return _rightView;
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
        [_btnBuy setTitle:@"立即抢购" forState:UIControlStateNormal];
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
-(UIView *)descView{
    if(!_descView){
        _descView = [[UIView alloc]init];
        _descView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 29.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = [UIColor colorWithRed:227/255.f green:227/255.f blue:227/255.f alpha:1.0].CGColor;
        [_descView.layer addSublayer:border];
    }
    return _descView;
}

-(UILabel *)labelDesc{
    if(!_labelDesc){
        _labelDesc = [[UILabel alloc]init];
        [_labelDesc setText:@"图文详情"];
        _labelDesc.textColor = [UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 28.f, 70.f, 2.f);
        border.backgroundColor = [UIColor redColor].CGColor;
        [_labelDesc.layer addSublayer:border];
        _labelDesc.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelDesc;
}
@end
