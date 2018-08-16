//
//  RandomBuyHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/5.
//
//

#import "RandomBuyHeader.h"
#import "HRAdView.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface RandomBuyHeader ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UIView* topView;

@property(nonatomic,strong) UIButton* btnDelivery;
@property(nonatomic,strong) UIImageView* iconDelivery;
@property(nonatomic,strong) UILabel* labelDelivery;
@property(nonatomic,strong) UIImageView* deliveryArrow;

@property(nonatomic,strong) UIView* searchView;

@property(nonatomic,strong) UIButton* btnSearch;

@property(nonatomic,strong) UICollectionView* headerCollectionView;
@property(nonatomic,strong) NSLayoutConstraint* bottomConstraint;
@property(nonatomic,strong) UIView* bottomView;

@property(nonatomic,strong) UIView* orderView;
@property(nonatomic,strong) NSLayoutConstraint* orderConstraints;
@property(nonatomic,strong) HRAdView* marqueeView;
@property(nonatomic,strong) UIImageView* orderArrow;

@property(nonatomic,strong) UIView* bannerView;
@property(nonatomic,strong) UIButton* banner;

@property(nonatomic,strong) UIView* sectionView;
@property(nonatomic,strong) UILabel* labelTitle;

@property(nonatomic,strong) NSArray* arrayType;
@property(nonatomic,strong) NSArray* arrayBanner;
@property(nonatomic,strong) NSDictionary* item;



@end

@implementation RandomBuyHeader{
    CGFloat bannerHeight;
    NSInteger orderHeight;
}

static NSString* const cellIdentifier =  @"RandomBuyHeaderCell";

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.topView];
    [self.topView addSubview:self.btnDelivery];
    [self.btnDelivery addSubview:self.iconDelivery];
    [self.btnDelivery addSubview:self.labelDelivery];
    [self.btnDelivery addSubview:self.deliveryArrow];
    [self.topView addSubview:self.searchView];
    [self.searchView addSubview:self.txtSearch];
    [self.topView addSubview:self.headerCollectionView];
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.orderView];
    [self.orderView addSubview:self.marqueeView];
    [self.orderView addSubview:self.orderArrow];
    [self.bottomView addSubview:self.bannerView];
    [self.bannerView addSubview:self.banner];
    [self.bottomView addSubview:self.sectionView];
    [self.sectionView addSubview:self.labelTitle];
}

-(void)layoutConstraints{
    NSInteger defEdge =0,leftEdge = 10,topEdge=10,iconSize=20,arrowWidth=8,arrowHeight=14,
    //topHeight=190,
    deliveryHeight=40,searchHeight=60,collectionHeight= 70,
    bottomHeight=130,sectionHeight=30;
    orderHeight = 40;
    bannerHeight= 0.f;
    
    
    
    NSArray* formats = @[ @"H:|-defEdge-[topView]-defEdge-|", @"H:|-defEdge-[bottomView]-defEdge-|", @"V:|-defEdge-[topView(==topHeight)]-defEdge-[bottomView]-defEdge-|",
                          
                          @"H:|-defEdge-[btnDelivery]-defEdge-|",@"H:|-defEdge-[searchView]-defEdge-|", @"H:|-defEdge-[collectionView]-defEdge-|",
                          @"V:|-defEdge-[btnDelivery(==deliveryHeight)]-defEdge-[searchView(==60)]-topEdge-[collectionView(==collectionHeight)]-topEdge-|",
                          
                          @"H:|-defEdge-[orderView]-defEdge-|",@"H:|-defEdge-[bannerView]-defEdge-|", @"H:|-defEdge-[sectionView]-defEdge-|",
                          @"V:|-defEdge-[orderView]-defEdge-[bannerView]-topEdge-[sectionView(==sectionHeight)]-defEdge-|",
                          
                          @"H:[iconDelivery(==iconSize)]-leftEdge-[labelDelivery]-leftEdge-[deliveryArrow(==arrowWidth)]",
                          @"V:|-iconTopEdge-[iconDelivery(==iconSize)]-iconTopEdge-|", @"V:|-defEdge-[labelDelivery]-defEdge-|", @"V:|-arrowTopEdge-[deliveryArrow(==arrowHeight)]-arrowTopEdge-|",
                          
                          @"H:|-leftEdge-[txtSearch]-leftEdge-|", @"V:|-defEdge-[txtSearch]-topEdge-|",
                          
                          @"H:|-leftEdge-[marqueeView]-leftEdge-[orderArrow(==arrowWidth)]-leftEdge-|",
                          @"V:|-defEdge-[marqueeView]-defEdge-|", @"V:|-topEdge-[orderArrow(==arrowHeight)]",
                          
                          @"H:|-defEdge-[banner]-defEdge-|", @"V:|-defEdge-[banner]-defEdge-|",
                          
                          @"H:|-leftEdge-[labelTitle]-defEdge-|", @"V:|-defEdge-[labelTitle]-defEdge-|"
                          ];
    NSDictionary* metrics = @{ @"defEdge":@(defEdge), @"leftEdge":@(leftEdge), @"topEdge":@(topEdge),
                               @"deliveryHeight":@(deliveryHeight), @"iconSize":@(iconSize), @"iconTopEdge":@((deliveryHeight-iconSize)/2),
                               @"arrowWidth":@(arrowWidth), @"arrowHeight":@(arrowHeight), @"arrowTopEdge":@((deliveryHeight-arrowHeight)/2),
                               @"topHeight":@(190),@"bottomHeight":@(bottomHeight), @"collectionHeight":@(collectionHeight), @"orderHeight":@(orderHeight), @"bannerHeight":@(bannerHeight),@"sectionHeight":@(sectionHeight)
                               };
    
    NSDictionary* views = @{ @"topView":self.topView,
                             @"btnDelivery":self.btnDelivery,@"searchView":self.searchView, @"collectionView":self.headerCollectionView,
                             @"iconDelivery":self.iconDelivery, @"labelDelivery":self.labelDelivery, @"deliveryArrow":self.deliveryArrow,
                             @"txtSearch":self.txtSearch,
                             @"bottomView":self.bottomView,
                             @"orderView":self.orderView,@"bannerView":self.bannerView, @"sectionView":self.sectionView,
                             @"marqueeView":self.marqueeView,@"orderArrow":self.orderArrow,
                             @"txtSearch":self.txtSearch, @"banner":self.banner,
                             @"labelTitle":self.labelTitle
                             };
    
    for (NSString* format in formats) {
        // NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
    
    self.orderConstraints = [NSLayoutConstraint constraintWithItem:self.orderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:orderHeight];
    [self.orderView addConstraint:self.orderConstraints];
    
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:bannerHeight];
}


#pragma mark =====================================================  <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayType.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RandomBuyHeaderCell* cell = (RandomBuyHeaderCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.item = self.arrayType[indexPath.row];
    return cell;
}


#pragma mark =====================================================  <UICollectionViewFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-30)/4, 70.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* item =  self.arrayType[indexPath.row];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelecteType:)]){
        [self.delegate didSelecteType:item];
    }
}


-(void)loadDataWithType:(NSArray *)arrayType banners:(NSArray *)banners orders:(NSArray *)orders section:(NSDictionary *)item complete:(RandomBuyHeaderComplete)complete{
    _arrayType = arrayType;
    _arrayBanner = banners;
    _item = item;
    NSArray* empty = [[item objectForKey:@"prompt"] componentsSeparatedByString: @","];
    NSString* str =  [NSString stringWithFormat: @"%@.%@",[empty firstObject],[empty lastObject]];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.f]} range:[str rangeOfString:[empty firstObject]]];
    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:[empty lastObject]]];
    self.labelTitle.attributedText = attributeStr;
//
    [self.banner sd_setImageWithURL:[NSURL URLWithString:[[self.arrayBanner firstObject] objectForKey: @"image"]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(bannerHeight == 0.f){
            bannerHeight =   (image.size.height/image.size.width)*SCREEN_WIDTH;
            complete(bannerHeight);
        }
    }];
    [self.headerCollectionView reloadData];
    if(orders.count>0){
        self.marqueeView.adTitles = orders;
        
    }else{
        if(self.orderConstraints)
            [self.orderView removeConstraint:self.orderConstraints];
        self.orderConstraints = [NSLayoutConstraint constraintWithItem:self.orderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f];
        self.orderConstraints.priority = 999;
        [self.orderView addConstraint:self.orderConstraints];
    }
    if(self.bottomConstraint){
        [self.bottomView removeConstraint:self.bottomConstraint];
    }
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:bannerHeight];
    self.bottomConstraint.priority = 999;
    [self.bottomView addConstraint:self.bottomConstraint];
   
    if(self.marqueeView.adTitles.count>0)
        [self.marqueeView beginScroll];
    
    
}

-(void)loadDataDelivery:(NSString *)count{
    if(![WMHelper isEmptyOrNULLOrnil:count]){
        NSString* str = [NSString stringWithFormat:@"附近有 %@ 位骑士为您服务",count];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:count]];
        self.labelDelivery.attributedText = attributeStr;
        NSInteger width = [self.labelDelivery intrinsicContentSize].width;
        width+= 48;
        /*
         NSLayoutConstraint* constraint =[NSLayoutConstraint constraintWithItem:self.btnDelivery attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(SCREEN_WIDTH - width)];
         constraint.priority = 999;
         [self.btnDelivery addConstraint:constraint];*/
        NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.iconDelivery attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnDelivery attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(SCREEN_WIDTH-width)/2];
        constraint.priority = 999;
        [self.btnDelivery addConstraint:constraint];
    }
}

#pragma mark =====================================================  SEL
-(IBAction)btnSearchTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(randomSearch:)]){
        [self.delegate randomSearch:self.txtSearch.text];
    }
}

-(IBAction)btnDeliveryTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(showRandomMap:)]){
        [self.delegate showRandomMap:sender];
    }
}

-(IBAction)btnAdvTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectedAdPhoto:)]){
        [self.delegate selectedAdPhoto:sender];
    }
}

#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIButton *)btnDelivery{
    if(!_btnDelivery){
        _btnDelivery = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelivery addTarget:self action:@selector(btnDeliveryTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnDelivery.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnDelivery;
}

-(UIImageView *)iconDelivery{
    if(!_iconDelivery){
        _iconDelivery = [[UIImageView alloc]init];
        [_iconDelivery setImage:[UIImage imageNamed: @"icon-random-buy"]];
        _iconDelivery.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconDelivery;
}


-(UILabel *)labelDelivery{
    if(!_labelDelivery){
        _labelDelivery = [[UILabel alloc]init];
        _labelDelivery.textColor = [UIColor grayColor];
        _labelDelivery.text =@"附近有 10 位骑士为您服务";
        _labelDelivery.font = [UIFont systemFontOfSize:14.f];
        _labelDelivery.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDelivery;
}

-(UIImageView *)deliveryArrow{
    if(!_deliveryArrow){
        _deliveryArrow = [[UIImageView alloc]init];
        [_deliveryArrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
        _deliveryArrow.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _deliveryArrow;
}

-(UIView *)searchView{
    if(!_searchView){
        _searchView = [[UIView alloc]init];
        _searchView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _searchView;
}

-(UITextField *)txtSearch{
    if(!_txtSearch){
        UILabel* label =[[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 10, 50);
        label.backgroundColor =[UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
        _txtSearch = [[UITextField alloc]init];
        _txtSearch.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0];
        _txtSearch.layer.borderColor =[UIColor colorWithRed:146/255.f green:92/255.f blue:108/255.f alpha:1.0].CGColor;
        _txtSearch.layer.borderWidth = 0.5f;
        _txtSearch.layer.masksToBounds = YES;
        _txtSearch.layer.cornerRadius = 25.f;
        _txtSearch.borderStyle = UITextBorderStyleNone;
        _txtSearch.placeholder = @"输入您想买的商品,例如:拖鞋一双";
        _txtSearch.font = [UIFont systemFontOfSize:14.f];
        _txtSearch.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
        _txtSearch.rightView = self.btnSearch;
        _txtSearch.rightViewMode = UITextFieldViewModeAlways;
        _txtSearch.leftView = label;
        _txtSearch.leftViewMode = UITextFieldViewModeAlways;
        _txtSearch.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtSearch;
}

-(UIButton *)btnSearch{
    if(!_btnSearch){
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.frame = CGRectMake(0, 0, 80, 50);
        [_btnSearch setTitle:@"去下单" forState:UIControlStateNormal];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnSearch.backgroundColor = [UIColor redColor];
        _btnSearch.layer.masksToBounds = YES;
        _btnSearch.layer.borderColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0].CGColor;
        _btnSearch.layer.borderWidth = 5.f;
        _btnSearch.layer.cornerRadius = 25.f;
        [_btnSearch addTarget:self action:@selector(btnSearchTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSearch;
}

-(UICollectionView *)headerCollectionView{
    if(!_headerCollectionView){
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _headerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _headerCollectionView.backgroundColor = [UIColor whiteColor];
        _headerCollectionView.delegate = self;
        _headerCollectionView.dataSource = self;
        _headerCollectionView.scrollEnabled = NO;
        _headerCollectionView.showsHorizontalScrollIndicator = NO;
        [_headerCollectionView registerClass:[RandomBuyHeaderCell class] forCellWithReuseIdentifier:cellIdentifier];
        _headerCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _headerCollectionView;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 1.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_bottomView.layer addSublayer:border];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UIView *)orderView{
    if(!_orderView){
        _orderView = [[UIView alloc]init];
        _orderView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _orderView;
}
-(HRAdView *)marqueeView{
    if(!_marqueeView){
        _marqueeView = [[HRAdView alloc]initWithTitles:nil];
        _marqueeView.textAlignment = NSTextAlignmentLeft;//默认
        _marqueeView.isHaveTouchEvent = YES;
        _marqueeView.labelFont = [UIFont systemFontOfSize:14];
        _marqueeView.color = [UIColor grayColor];
        _marqueeView.time = 2.0f;
        _marqueeView.edgeInsets = UIEdgeInsetsMake(5, 5,5, 5);
        __weak typeof(self) weakself = self;
        _marqueeView.clickAdBlock = ^(NSUInteger index){
            if(weakself.delegate && [weakself.delegate respondsToSelector:@selector(showRandomOrder:)]){
                [weakself.delegate showRandomOrder:nil];
            }
        };
        _marqueeView.headImg = [UIImage imageNamed:@"icon-all-order-buy"];
        _marqueeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _marqueeView;
}
-(UIImageView *)orderArrow{
    if(!_orderArrow){
        _orderArrow = [[UIImageView alloc]init];
        [_orderArrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
        _orderArrow.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _orderArrow;
}

-(UIView *)bannerView{
    if(!_bannerView){
        _bannerView = [[UIView alloc]init];
        _bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bannerView;
}

-(UIButton *)banner{
    if(!_banner){
        _banner = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_banner addTarget:self action:@selector(btnAdvTouch:) forControlEvents:UIControlEventTouchUpInside];
        _banner.enabled = NO;
        _banner.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _banner;
}

-(UIView *)sectionView{
    if(!_sectionView){
        _sectionView = [[UIView alloc]init];
        _sectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _sectionView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor redColor];
        _labelTitle.font = [UIFont systemFontOfSize:20.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

@end


#pragma mark =====================================================  RandomBuyHeaderCell

@interface RandomBuyHeaderCell()

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation RandomBuyHeaderCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.icon];
    [self addSubview:self.labelTitle];
}

-(void)layoutConstraints{
    NSArray* formats = @[ @"H:[icon(==iconHeight)]", @"V:|-0-[icon(==iconHeight)]",@"H:[labelTitle(==titleWidth)]", @"V:[labelTitle(==titleHeight)]-5-|"];
    NSDictionary* metrics = @{ @"iconHeight":@(45), @"titleWidth":@(60), @"titleHeight":@(15)};
    NSDictionary* views = @{ @"icon":self.icon, @"labelTitle":self.labelTitle};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        [self.icon sd_setImageWithURL:[NSURL URLWithString: [item objectForKey: @"img"]]];
        self.labelTitle.text = [item objectForKey: @"text"];
    }
}

#pragma mark =====================================================  property packge
-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font =[UIFont systemFontOfSize:12.f];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}


@end
