//
//  NewHomeFooter.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import "NewHomeFooter.h"
#import "HomeActive.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface NewHomeFooter ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong) SDCycleScrollView* themeView;
//秒杀、满减、团设置在view上
@property(nonatomic,strong) HomeActive* middleView;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIImageView* leftLine;
@property(nonatomic,strong) UIImageView* iconStore;
@property(nonatomic,strong) UILabel* labelStore;
@property(nonatomic,strong) UIImageView* rightLine;

@property(nonatomic,strong) NSMutableArray* arrayAdvImg;

@end

@implementation NewHomeFooter{
    NSInteger advHeight, middleHeight,bottomHeight;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        advHeight = 10;
        middleHeight = 0;//xianchang;
        bottomHeight= 50;
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    //NSArray* views = @[self.themeView,self.middleView,self.bottomView];
    NSArray* views = @[self.themeView,self.bottomView];
    [views enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView* empty = (UIView*)obj;
        empty.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:empty];
        
    }];
    
    [self.bottomView addSubview:self.leftLine];
    [self.bottomView addSubview:self.iconStore];
    [self.bottomView addSubview:self.labelStore];
    [self.bottomView addSubview:self.rightLine];
}

-(void)layoutConstraints{
    //    饕餮
    NSArray* formats = @[@"H:|-defEdge-[themeView]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|",
                         @"V:|-topEdge-[themeView][bottomView(==bottomHeight)]-defEdge-|",
                         @"H:|-leftEdge-[leftLine]-leftEdge-[iconStore(==20)]-leftEdge-[labelStore(==80)]-leftEdge-[rightLine(leftLine)]-leftEdge-|",
                         @"V:[leftLine(==1)]", @"V:|-15-[iconStore(==20)]-15-|", @"V:|-defEdge-[labelStore]-defEdge-|", @"V:[rightLine(==1)]"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"middleHeight":@(middleHeight), @"bottomHeight":@(bottomHeight)};
    
    //
    NSDictionary* views = @{@"themeView":self.themeView, @"middleView":self.middleView, @"bottomView":self.bottomView,
                            @"leftLine":self.leftLine, @"iconStore":self.iconStore, @"labelStore":self.labelStore, @"rightLine":self.rightLine};
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@  %@ ",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        
        [self addConstraints:constraints];
    }];
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.leftLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f];
    [self.bottomView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.rightLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f];
    [self.bottomView addConstraint:constraint];
}


//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//}

#pragma mark =====================================================  <CDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTopicAtIndex: imgSize:)]){
        UIImageView* img = self.arrayAdvImg[index];
        [self.delegate didSelectedTopicAtIndex:index imgSize:img.image.size];
    }
}

-(void)loadDataWithTopic:(NSArray *)topic miaoSha:(NSDictionary *)miaoSha manJian:(NSDictionary *)manJian tuan:(NSDictionary *)tuan{
    if(topic){
        NSMutableArray* photos = [[NSMutableArray alloc]init];
        self.arrayAdvImg = [[NSMutableArray alloc]init];
        [topic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [photos addObject:((MAdv*)obj).photoUrl];
            UIImageView* img = [[UIImageView alloc]init];
            [img sd_setImageWithURL:[NSURL URLWithString:((MAdv*)obj).bigPhotoUrl ]];
            [self.arrayAdvImg addObject:img];
        }];
        [self.themeView clearCache];
        [self.themeView setImageURLStringsGroup:photos];

    }
    [self.middleView loadDataWithMiaoSha:miaoSha manJian:manJian tuan:tuan];
}

#pragma mark =====================================================  property package
-(SDCycleScrollView *)themeView{
    if(!_themeView){
         _themeView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, advHeight) imageURLStringsGroup:nil];
        _themeView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _themeView.delegate = self;
        _themeView.dotColor = [UIColor greenColor]; // 自定义分页控件小圆标颜色
        _themeView.translatesAutoresizingMaskIntoConstraints = NO;


    }
    return _themeView;
}

-(HomeActive *)middleView{
    if(!_middleView){
        _middleView = [[HomeActive alloc]init];
    }
    return _middleView;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}

-(UIImageView *)leftLine{
    if(!_leftLine){
        _leftLine = [[UIImageView alloc]init];
        [_leftLine setImage:[UIImage imageNamed: @"line-near-store"]];
        _leftLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _leftLine;
}

-(UIImageView *)iconStore{
    if(!_iconStore) {
        _iconStore = [[UIImageView alloc]init];
        [_iconStore setImage:[UIImage imageNamed: @"icon-store-near"]];
        _iconStore.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconStore;
}

-(UILabel *)labelStore{
    if(!_labelStore){
        _labelStore = [[UILabel alloc]init];
        _labelStore.text =  Localized(@"Nearby_Shop");
        _labelStore.textColor = [UIColor grayColor];
        _labelStore.font = [UIFont systemFontOfSize:15.f];
        _labelStore.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStore;
}

-(UIImageView *)rightLine{
    if(!_rightLine){
        _rightLine  = [[UIImageView alloc]init];
        [_rightLine setImage:[UIImage imageNamed: @"line-near-store"]];
        _rightLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightLine;
}

-(void)setDelegate:(id<NewHomeDelegate>)delegate{
    _delegate = delegate;
    self.middleView.delegate = delegate;
}
@end
