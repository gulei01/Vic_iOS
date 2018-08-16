//
//  HomeActive.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import "HomeActive.h"
#import "ZQCountDownView.h"

@interface HomeActive ()

@property(nonatomic,strong) UIButton* btnMiaoSha;
@property(nonatomic,strong) UIView* miaoShaView;
@property(nonatomic,strong) UILabel* labelMiaoSha;
@property(nonatomic,strong) UIImageView* iconMiaoSha;
@property(nonatomic,strong) ZQCountDownView* timer;
@property(nonatomic,strong) UIImageView* photoMiaoSha;
@property(nonatomic,strong) UIImageView* lineLeft;
@property(nonatomic,strong) UIButton* btnManJian;
@property(nonatomic,strong) UIView* manJianView;
@property(nonatomic,strong) UILabel* labelManJian;
@property(nonatomic,strong) UIImageView* iconManJian;
@property(nonatomic,strong) UILabel* labelItem;
@property(nonatomic,strong) UIImageView* photoManJian;
@property(nonatomic,strong) UIImageView* lineRight;
@property(nonatomic,strong) UIButton* btnTuan;
@property(nonatomic,strong) UIView* tuanView;
@property(nonatomic,strong) UILabel* labelTuan;
@property(nonatomic,strong) UIImageView* iconTuan;
@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelTuanItem;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIImageView* photoTuan;
@property(nonatomic,strong) NSDictionary* dictMiaoSha;
@end

@implementation HomeActive

-(instancetype)init{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"line-vertical-home"]];
        [self layoutUI];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    
    [self addSubview:self.btnMiaoSha];
    [self addSubview:self.btnManJian];
    [self addSubview:self.btnTuan];
    [self.btnMiaoSha addSubview:self.miaoShaView];
    [self.miaoShaView addSubview:self.labelMiaoSha];
    [self.miaoShaView addSubview:self.iconMiaoSha];
    [self.btnMiaoSha addSubview:self.timer];
    [self.btnMiaoSha addSubview:self.photoMiaoSha];
    
    [self.btnManJian addSubview:self.manJianView];
    [self.manJianView addSubview:self.labelManJian];
    [self.manJianView addSubview:self.iconManJian];
    [self.btnManJian addSubview:self.labelItem];
    [self.btnManJian addSubview:self.photoManJian];
    
    [self.btnTuan addSubview:self.tuanView];
    [self.tuanView addSubview:self.labelTuan];
    [self.tuanView addSubview:self.iconTuan];
    [self.btnTuan addSubview:self.priceView];
   // [self.priceView addSubview:self.labelTuanItem];
    [self.priceView addSubview:self.labelPrice];
    [self.btnTuan addSubview:self.photoTuan];
    
//    设置秒杀活动距离上边框的距离
    NSArray* formats = @[@"H:|-defEdge-[btnMiaoSha][btnManJian(btnMiaoSha)][btnTuan(btnMiaoSha)]-defEdge-|",
                         @"V:|-defEdge-[btnMiaoSha]-defEdge-|", @"V:|-defEdge-[btnManJian]-defEdge-|", @"V:|-defEdge-[btnTuan]-defEdge-|",
                         @"H:[miaoShaView]",@"H:[timer(==80)]", @"H:[photoMiaoSha(==50)]",
                         @"V:|-topEdge-[miaoShaView(==20)]-space5-[timer]-space5-[photoMiaoSha(==50)]-downEdge-|",
                         @"H:|-defEdge-[iconMiaoSha(==17)]-2-[labelMiaoSha]-defEdge-|", @"V:|-2-[iconMiaoSha]-2-|", @"V:|-defEdge-[labelMiaoSha]-defEdge-|",
                         @"H:[manJianView]",@"H:|-5-[labelItem]-5-|", @"H:[photoManJian(==50)]",
                         @"V:|-topEdge-[manJianView(==20)]-space5-[labelItem]-space5-[photoManJian(==50)]-downEdge-|",
                          @"H:|-defEdge-[iconManJian(==17)]-2-[labelManJian]-defEdge-|", @"V:|-2-[iconManJian]-2-|", @"V:|-defEdge-[labelManJian]-defEdge-|",
                         
                         @"H:[tuanView]",@"H:|-defEdge-[priceView]-defEdge-|", @"H:[photoTuan(==50)]",
                         @"V:|-topEdge-[tuanView(==20)]-space5-[priceView]-space5-[photoTuan(==50)]-downEdge-|",
                         @"H:|-defEdge-[iconTuan(==17)]-2-[labelTuan]-defEdge-|", @"V:|-2-[iconTuan]-2-|", @"V:|-defEdge-[labelTuan]-defEdge-|",
                         @"H:|-leftEdge-[labelPrice]-leftEdge-|", @"V:|-defEdge-[labelPrice]-defEdge-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"space":@(1), @"leftEdge":@(10), @"topEdge":@(5), @"space5":@(5),@"downEdge":@(3)};
    NSDictionary* views = @{ @"btnMiaoSha":self.btnMiaoSha, @"btnManJian":self.btnManJian, @"btnTuan":self.btnTuan,
                              @"miaoShaView":self.miaoShaView, @"photoMiaoSha":self.photoMiaoSha, @"timer":self.timer,
                             @"labelMiaoSha":self.labelMiaoSha, @"iconMiaoSha":self.iconMiaoSha,
                              @"manJianView":self.manJianView, @"labelItem":self.labelItem, @"photoManJian":self.photoManJian,
                              @"labelManJian":self.labelManJian, @"iconManJian":self.iconManJian,
                              @"tuanView":self.tuanView, @"priceView":self.priceView, @"photoTuan":self.photoTuan,
                            @"labelTuan":self.labelTuan,  @"iconTuan":self.iconTuan,
                             @"labelTuanItem":self.labelTuanItem, @"labelPrice":self.labelPrice
                             };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @" %@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.timer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnMiaoSha attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnMiaoSha addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.photoMiaoSha attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnMiaoSha attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnMiaoSha addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.photoManJian attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnManJian attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnManJian addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.photoTuan attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnTuan attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnTuan addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.miaoShaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnMiaoSha attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnMiaoSha addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.manJianView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnManJian attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnManJian addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.tuanView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.btnTuan attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self.btnTuan addConstraint:constraint];
}

-(void)beginBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* endTimeStr = [self.dictMiaoSha objectForKey: @"enddate"];
        NSDate* endData = [WMHelper convertToDateWithStr:endTimeStr format:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* nowDate = [NSDate date];
        NSTimeInterval secondsInterval= [endData timeIntervalSinceDate:nowDate];
        self.timer.countDownTimeInterval = secondsInterval;
    });
}
-(void)endBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.timer.countDownTimeInterval = 0;
    });
}


#pragma mark =====================================================  SEL
-(IBAction)miaoShaTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedMiaoSha)]){
        [self.delegate didSelectedMiaoSha];
    }
}

-(IBAction)manJianTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedManJian)]){
        [self.delegate didSelectedManJian];
    }
}

-(IBAction)tuanTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTuan)]){
        [self.delegate didSelectedTuan];
    }
}





-(void)loadDataWithMiaoSha:(NSDictionary *)miaoSha manJian:(NSDictionary *)manJian tuan:(NSDictionary *)tuan{
    if(miaoSha){
        _dictMiaoSha = miaoSha;
        [self.photoMiaoSha sd_setImageWithURL:[NSURL URLWithString:[miaoSha objectForKey: @"default_image"]] placeholderImage:nil options:SDWebImageRefreshCached];
        
        NSString* startTimeStr = [miaoSha objectForKey: @"startdate"];
        NSDate* beginDate = [WMHelper convertToDateWithStr:startTimeStr format:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* nowDate = [NSDate date];
        NSTimeInterval beginInterval= [nowDate timeIntervalSinceDate:beginDate];
        
        NSString* endTimeStr = [miaoSha objectForKey: @"enddate"];
        NSDate* endData = [WMHelper convertToDateWithStr:endTimeStr format:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];
        if(endInterval>=0){
            self.timer.countDownTimeInterval = 0;
        }else{
            if(beginInterval>0){
                self.timer.countDownTimeInterval = -endInterval;
                [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
            }else{
                self.timer.countDownTimeInterval = -beginInterval;
                [NSTimer scheduledTimerWithTimeInterval:-beginInterval target:self selector:@selector(beginBuy) userInfo:nil repeats:NO];
            }
        }
    }else{
        [self.photoMiaoSha setImage:[UIImage imageNamed:kDefaultMiaoShaImage]];
    }
    
    if(manJian){
        self.labelManJian.text = [manJian objectForKey: @"title"];
        self.labelItem.text = [manJian objectForKey: @"sub_title"];
        [self.photoManJian sd_setImageWithURL:[NSURL URLWithString:[manJian objectForKey: @"thumb"]] placeholderImage:nil options:SDWebImageRefreshCached];
    }else{
        [self.photoManJian setImage:[UIImage imageNamed:kDefaultManJianImage]];
        self.labelManJian.text =  @"";
        self.labelItem.text =  @"";
    }
    
    if(tuan){
        
        NSURL *url;
        if([tuan objectForKey: @"default_image"]){
            url = [NSURL URLWithString:@"http:\/\/admin.wm.wm0530.com\/Upload\/Food\/19_5928dd8495bfb.jpg"];
        }else {
            url = [NSURL URLWithString:@"http:\/\/admin.wm.wm0530.com\/Upload\/Food\/19_5928dd8495bfb.jpg"];
        }
        
        [self.photoTuan sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
       NSString* tuanStr = [NSString stringWithFormat: @"%@人团/",[tuan objectForKey: @"pingnum"]];
        NSString* price =  [NSString stringWithFormat: @"￥%@",[tuan objectForKey: @"price"]];
        NSString* str = [NSString stringWithFormat: @"%@￥%@",tuanStr,[tuan objectForKey: @"price"]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
         [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:tuanStr]];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:price]];
        self.labelPrice.attributedText = attributeStr;
        self.labelPrice.textAlignment = NSTextAlignmentCenter;
       // _labelTuanItem.text = [NSString stringWithFormat: @"%@人团",[tuan objectForKey: @"pingnum"]];
    }else{
        [self.photoTuan setImage:[UIImage imageNamed:kDefaultTuanImage]];
        //self.labelTuanItem.text =  @"";
        self.labelPrice.text =  @"";
    }
}

#pragma mark =====================================================  property package

-(UIButton *)btnMiaoSha{
    if(!_btnMiaoSha){
        _btnMiaoSha = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMiaoSha.backgroundColor = [UIColor whiteColor];
        [_btnMiaoSha addTarget:self action:@selector(miaoShaTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnMiaoSha.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnMiaoSha;
}

-(UIView *)miaoShaView{
    if(!_miaoShaView){
        _miaoShaView = [[UIView alloc]init];
        _miaoShaView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _miaoShaView;
}

-(UILabel *)labelMiaoSha{
    if(!_labelMiaoSha){
        _labelMiaoSha = [[UILabel alloc]init];
        _labelMiaoSha.text =  @"秒杀活动";
        _labelMiaoSha.font = [UIFont boldSystemFontOfSize:14.f];
        _labelMiaoSha.textColor = [UIColor colorWithRed:251/255.f green:86/255.f blue:111/255.f alpha:1.0];
        _labelMiaoSha.textAlignment = NSTextAlignmentCenter;
        _labelMiaoSha.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMiaoSha;
}

-(UIImageView *)iconMiaoSha{
    if(!_iconMiaoSha){
        _iconMiaoSha = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"home_newActThree_first"]];
        _iconMiaoSha.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconMiaoSha;
}

-(ZQCountDownView *)timer{
    if(!_timer){
        _timer = [[ZQCountDownView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelMiaoSha.frame), 0, 80, 20.f)];
        _timer.themeColor = [UIColor colorWithRed:87/255.f green:87/255.f blue:87/255.f alpha:1.0];
        _timer.textColor = [UIColor whiteColor];
        _timer.textFont = [UIFont boldSystemFontOfSize:10];
        _timer.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timer;
}

-(UIImageView *)photoMiaoSha{
    if(!_photoMiaoSha){
        _photoMiaoSha = [[UIImageView alloc]init];
        _photoMiaoSha.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoMiaoSha;
}
//线的问题
-(UIImageView *)lineLeft{
    if(!_lineLeft){
        _lineLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"line-vertical-home"]];
        _lineLeft.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _lineLeft;
}

//设置秒杀，满减，团购的中间的线长
-(UIButton *)btnManJian{
    if(!_btnManJian){
        _btnManJian = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnManJian.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, 0.5, xianchang);
        border.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"line-vertical-home"]].CGColor;
        [_btnManJian.layer addSublayer:border];
        [_btnManJian addTarget:self action:@selector(manJianTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnManJian.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnManJian;
}

-(UIView *)manJianView{
    if(!_manJianView){
        _manJianView = [[UIView alloc]init];
        _manJianView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _manJianView;
}

-(UILabel *)labelManJian{
    if(!_labelManJian){
        _labelManJian = [[UILabel alloc]init];
        _labelManJian.text =  @"天天满减";
        _labelManJian.textColor = [UIColor colorWithRed:253/255.f green:124/255.f blue:59/255.f alpha:1.0];
        _labelManJian.font = [UIFont boldSystemFontOfSize:14.f];
        _labelManJian.textAlignment = NSTextAlignmentCenter;
        _labelManJian.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelManJian;
}

-(UIImageView *)iconManJian{
    if(!_iconManJian){
        _iconManJian = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"home_newActThree_second"]];
        _iconManJian.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconManJian;
}

-(UILabel *)labelItem{
    if(!_labelItem){
        _labelItem = [[UILabel alloc]init];
        _labelItem.font = [UIFont systemFontOfSize:12.f];
        _labelItem.textColor = [UIColor grayColor];
        _labelItem.textAlignment = NSTextAlignmentCenter;
        _labelItem.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelItem;
}

-(UIImageView *)photoManJian{
    if(!_photoManJian){
        _photoManJian = [[UIImageView alloc]init];
        _photoManJian.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoManJian;
}

-(UIImageView *)lineRight{
    if(!_lineRight){
        _lineRight = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"line-vertical-home"]];
        _lineRight.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _lineRight;
}

-(UIButton *)btnTuan{
    if(!_btnTuan){
        _btnTuan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTuan.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, 0.5, xianchang);
        border.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"line-vertical-home"]].CGColor;
        [_btnTuan.layer addSublayer:border];
        [_btnTuan addTarget:self action:@selector(tuanTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnTuan.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnTuan;
}

-(UIView *)tuanView{
    if(!_tuanView){
        _tuanView = [[UIView alloc]init];
        _tuanView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tuanView;
}

-(UILabel *)labelTuan{
    if(!_labelTuan){
        _labelTuan = [[UILabel alloc]init];
        _labelTuan.text =  @"拼团购";
        _labelTuan.textColor =  [UIColor colorWithRed:105/255.f green:187/255.f blue:56/255.f alpha:1.0];
        _labelTuan.font = [UIFont boldSystemFontOfSize:14.f];
        _labelTuan.textAlignment = NSTextAlignmentCenter;
        _labelTuan.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTuan;
}

-(UIImageView *)iconTuan{
    if(!_iconTuan){
        _iconTuan = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"home_newActThree_third"]];
        _iconTuan.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconTuan;
}

-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
        _priceView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceView;
}

-(UILabel *)labelTuanItem{
    if(!_labelTuanItem){
        _labelTuanItem = [[UILabel alloc]init];
        _labelTuanItem.font = [UIFont systemFontOfSize:12.f];
        _labelTuanItem.textColor = [UIColor grayColor];
        _labelTuanItem.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTuanItem;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UIImageView *)photoTuan{
    if(!_photoTuan){
        _photoTuan = [[UIImageView alloc]init];
        _photoTuan.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoTuan;
}


@end
