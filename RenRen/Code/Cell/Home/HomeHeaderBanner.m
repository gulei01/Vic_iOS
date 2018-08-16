//
//  HomeHeaderBanner.m
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import "HomeHeaderBanner.h"
#import "MAdv.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <MarqueeLabel/MarqueeLabel.h>
#import "ActivityPart.h"

@interface HomeHeaderBanner()<SDCycleScrollViewDelegate>

@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) SDCycleScrollView* topAdvView;
@property(nonatomic,strong) MarqueeLabel* marqueeLabel;
@property(nonatomic,strong) UIView* typeView;
@property(nonatomic,strong) UIImageView* imgArrow;
@property(nonatomic,strong) ActivityPart* activityView;
@property(nonatomic,copy) NSString* notice;
@property(nonatomic,strong) MBuyNow* buyNow;
@property(nonatomic,strong) MFightGroup* fightGroup;
@end

@implementation HomeHeaderBanner
{
    BOOL hasTopAdv,hasBottomAdv;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = theme_default_color;
    [self layoutUI];
    [self layoutConstraints];
}

-(void)layoutUI{
    
    UIButton* leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"icon-search"]  forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor colorWithRed:244/255.f green:107/255.f blue:16/255.f alpha:1.0];
    [rightBtn addTarget:self action:@selector(btnSearchTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.txtSearch = [[UITextField alloc]init];
    self.txtSearch.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 30);
    [self addSubview:self.txtSearch];
    self.txtSearch.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
    self.txtSearch.layer.borderColor =[UIColor colorWithRed:244/255.f green:107/255.f blue:16/255.f alpha:1.0].CGColor;
    self.txtSearch.layer.borderWidth = 0.5f;
    self.txtSearch.borderStyle = UITextBorderStyleNone;
    self.txtSearch.leftView = leftBtn;
    self.txtSearch.placeholder = @"零食屯起来吧! Duang~~";
    self.txtSearch.leftViewMode =UITextFieldViewModeAlways;
    self.txtSearch.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.txtSearch.rightView = rightBtn;
    self.txtSearch.rightViewMode = UITextFieldViewModeAlways;
    self.middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.txtSearch.frame)+5, SCREEN_WIDTH, 160+ADVHEIGHT+180)];
    [self addSubview:self.middleView];
    self.topAdvView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADVHEIGHT) imageURLStringsGroup:nil];
    self.topAdvView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.topAdvView.delegate = self;
    self.topAdvView.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.topAdvView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.middleView addSubview:self.topAdvView];
    self.marqueeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topAdvView.frame), SCREEN_WIDTH, 0.f);
    [self.middleView addSubview:self.marqueeLabel];
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary* conf = [userDef dictionaryForKey:kRandomBuyConfig];
    NSString* empty = [conf objectForKey: @"title"];
    NSString* str = [WMHelper isEmptyOrNULLOrnil:empty]? @"随意购":empty;
    NSArray* arrayTitle=  @[@"超市",@"新鲜水果",@"美食外卖",@"鲜花蛋糕",@"秒杀活动",str,@"拼团购",@"外卖郎酒库"];
    NSArray* arrayImg =   @[@"icon-super-store",@"icon-fruit",@"icon-food",@"icon-flowers",@"icon-buynow",@"icon-random-buy",@"icon-fightGroup",@"icon-drug"];
    
    self.typeView = [[UIView alloc]init];
    self.typeView.frame =CGRectMake(0, CGRectGetMaxY(self.marqueeLabel.frame), SCREEN_WIDTH, 160);
    [self.middleView addSubview:self.typeView];
    for (int row= 0; row<2; row++) {
        for (int columns=0; columns<4; columns++) {
            NSInteger index = 4*row+columns;
            CGRect fram =CGRectMake(SCREEN_WIDTH*columns/4, 160/2*row, SCREEN_WIDTH/4, 160/2);
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = index;
            btn.frame =fram;
            [btn addTarget:self action:@selector(categoryTouch:) forControlEvents:UIControlEventTouchUpInside];
            [self.typeView addSubview:btn];
            UIImageView* photo = [[UIImageView alloc]init];
            photo.frame = CGRectMake((fram.size.width-50)/2, (fram.size.height-20-50)/2, 50, 50);
            [photo setImage:[UIImage imageNamed:arrayImg[index]]];
            [btn addSubview:photo];
            UILabel* title = [[ UILabel alloc]init];
            title.frame = CGRectMake(0, 55, fram.size.width, 20);
            title.text = arrayTitle[index];
            title.textAlignment = NSTextAlignmentCenter;
            title.font = [UIFont systemFontOfSize:14.f];
            [btn addSubview:title];
        }
    }
    
    self.activityView = [[ActivityPart alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeView.frame), SCREEN_WIDTH, 180.f)];
    [self.middleView addSubview:self.activityView];
    self.btnSection = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSection.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnSection.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-35);
    self.btnSection.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnSection setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
    [self.btnSection addTarget:self action:@selector(btnSectionTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSection setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    self.btnSection.titleLabel.font = [UIFont systemFontOfSize:14.f];
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,1.0f);
    border.backgroundColor = theme_line_color.CGColor;
    [self.btnSection.layer addSublayer:border];
    [self addSubview:self.btnSection];
    
    self.imgArrow = [[UIImageView alloc]init];
    [self.imgArrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    [self.btnSection addSubview:self.imgArrow];
    
}


-(void)layoutConstraints{
    self.btnSection .translatesAutoresizingMaskIntoConstraints = NO;
    self.imgArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnSection addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.btnSection addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnSection attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnSection addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnSection attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectBannerPhoto:)]){
        [self.delegate didSelectBannerPhoto:index];
    }
}


-(void)loadAdvWithTop:(NSArray *)top{
    NSMutableArray* empty = [[NSMutableArray alloc]init];
    [top enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [empty addObject:((MAdv*)obj).photoUrl];
    }];
    [self.topAdvView clearCache];
    self.topAdvView.imageURLStringsGroup = empty;
    
}

-(void)loadBuyNow:(MBuyNow*)buyNow fightGroup:(MFightGroup*)fightGroup{
    if([WMHelper isNULLOrnil:buyNow] && [WMHelper isNULLOrnil:fightGroup]){
        _buyNow = nil;
        _fightGroup = nil;
        self.middleView.frame = CGRectMake(0, CGRectGetMaxY(self.txtSearch.frame)+5, SCREEN_WIDTH, 200+ADVHEIGHT+180);
        if(self.notice){
            self.marqueeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topAdvView.frame), SCREEN_WIDTH, 40.f);
        }else{
            self.marqueeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topAdvView.frame), SCREEN_WIDTH, 0.f);
        }
        self.typeView.frame =CGRectMake(0, CGRectGetMaxY(self.marqueeLabel.frame), SCREEN_WIDTH, 160);
        self.activityView.frame = CGRectMake(0, CGRectGetMaxY(self.typeView.frame), SCREEN_WIDTH, 0.f);
        self.activityView.hidden = YES;
    }else{
        _buyNow = buyNow;
        _fightGroup = fightGroup;
        self.middleView.frame = CGRectMake(0, CGRectGetMaxY(self.txtSearch.frame)+5, SCREEN_WIDTH, 200+ADVHEIGHT+180);
        if(self.notice){
            self.marqueeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topAdvView.frame), SCREEN_WIDTH, 40.f);
        }else{
            self.marqueeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topAdvView.frame), SCREEN_WIDTH, 0.f);
        }
        self.typeView.frame =CGRectMake(0, CGRectGetMaxY(self.marqueeLabel.frame), SCREEN_WIDTH, 160);
        self.activityView.frame = CGRectMake(0, CGRectGetMaxY(self.typeView.frame), SCREEN_WIDTH, 180.f);
        self.activityView.hidden = NO;
        [self.activityView loadData:buyNow fightGroup:fightGroup];
    }
}

-(void)loadNotice:(NSString *)notice{
    if(notice){
        _notice = notice;
        self.middleView.frame = CGRectMake(0, CGRectGetMaxY(self.txtSearch.frame)+5, SCREEN_WIDTH, 200+ADVHEIGHT+180);
        self.marqueeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topAdvView.frame), SCREEN_WIDTH, 40.f);
        self.typeView.frame =CGRectMake(0, CGRectGetMaxY(self.marqueeLabel.frame), SCREEN_WIDTH, 160);
        if([WMHelper isNULLOrnil:self.buyNow] && [WMHelper isNULLOrnil:self.fightGroup]){
            self.activityView.frame = CGRectMake(0, CGRectGetMaxY(self.typeView.frame), SCREEN_WIDTH, 180.f);
            self.activityView.hidden = NO;
        }else{
            self.activityView.frame = CGRectMake(0, CGRectGetMaxY(self.typeView.frame), SCREEN_WIDTH, 0.f);
            self.activityView.hidden = YES;
        }
        self.marqueeLabel.text = notice;
    }else{
        _notice = nil;
    }
}
-(IBAction)btnSectionTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(sectionTouch:)])
        [self.delegate sectionTouch:sender];
}


-(IBAction)btnSearchTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(homeSectionSearch:)])
        [self.delegate homeSectionSearch:self.txtSearch.text];
}

-(IBAction)categoryTouch:(id)sender{
    UIButton* btn = (UIButton*)sender;
    CGRect rec= btn.frame;
    CGSize size =   btn.intrinsicContentSize;
   // NSLog(@"x=%.2f  y = %.2f  width = %.2f  height = %.2f",rec.origin.x,rec.origin.y,rec.size.width,rec.size.height);
    //NSLog(@"x=%.2f  y = %.2f  width = %.2f  height = %.2f",rec.origin.x,rec.origin.y,size.width,size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectType:)])
        [self.delegate didSelectType:sender];
}



#pragma mark =====================================================  property package
-(MarqueeLabel *)marqueeLabel{
    if(!_marqueeLabel){
        _marqueeLabel = [[MarqueeLabel alloc]init];
        _marqueeLabel.marqueeType = MLContinuous;
        _marqueeLabel.scrollDuration = 20.0f;
        _marqueeLabel.fadeLength = 10.0f;
        _marqueeLabel.trailingBuffer = 30.0f;
        
        _marqueeLabel.textColor = [UIColor whiteColor];
        _marqueeLabel.backgroundColor = [UIColor redColor];
        _marqueeLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _marqueeLabel;
}
@end
