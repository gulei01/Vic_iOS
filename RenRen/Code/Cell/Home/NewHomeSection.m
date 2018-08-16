//
//  NewHomeSection.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import "NewHomeSection.h"
#import "NewHomeCell.h"

@interface NewHomeSection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property(nonatomic,strong) UIImageView* imgRecommend;

@property(nonatomic,strong) UILabel* labelStoreName;
@property(nonatomic,strong) UIImageView* line;
@property(nonatomic,strong) UIImageView* shopCar;

@property(nonatomic,strong) UIView* shipView;
@property(nonatomic,strong) UILabel* labelShip;
@property(nonatomic,strong) UILabel* labelShipTime;
@property(nonatomic,strong) UIView* saleView;
@property(nonatomic,strong) UIView* starView;
@property(nonatomic,strong) NSMutableArray* arrayStar;
@property(nonatomic,strong) UIImageView* lineSale;
@property(nonatomic,strong) UILabel* labelSale;

@property(nonatomic,strong) NSLayoutConstraint* storeConstraint;

@property(nonatomic,strong) UILabel* labelActiveType;
@property(nonatomic,strong) UILabel* labelActive;

@property(nonatomic,strong) UIView* contentView;
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* storeLogo;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UICollectionView* subCollectionView;
@end

static NSString *const cellIdentifier =  @"NewHomeCell";

@implementation NewHomeSection
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
    }
    return self;
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.contentView];
    
    
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.storeLogo];
    [self.topView addSubview:self.rightView];
    
    [self.rightView addSubview:self.labelStoreName];
    [self.rightView addSubview:self.line];
    [self.rightView addSubview:self.shopCar];
    
    [self.rightView addSubview:self.shipView];
    
    [self.shipView addSubview:self.labelShip];
    [self.shipView addSubview:self.labelShipTime];
    
    [self.rightView addSubview:self.saleView];
    [self.saleView addSubview:self.starView];
    [self.saleView addSubview:self.labelSale];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelActiveType];
    [self.bottomView addSubview:self.labelActive];
    [self.contentView addSubview:self.imgRecommend];
    [self.contentView addSubview:self.subCollectionView];
    
    self.arrayStar =[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(12*i, 0, 10, 10);
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-star-default"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-star-enter"] forState:UIControlStateSelected];
        [self.starView addSubview:btn];
        [self.arrayStar addObject:btn];
    }
    
    
    NSArray* formats  = @[@"H:|-leftEdge-[contentView]-leftEdge-|", @"V:|-defEdge-[contentView]-defEdge-|",
                          @"H:|-defEdge-[imgRecommend(==35)]", @"V:|-defEdge-[imgRecommend(==35)]",
                          @"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|",@"H:|-defEdge-[subCollectionView]-defEdge-|",
                          @"V:|-defEdge-[topView(==topHeight)][bottomView(==bottomHeight)][subCollectionView]-defEdge-|",
                          @"H:|-leftEdge-[storeLogo(==90)]-leftEdge-[rightView]-defEdge-|", @"V:|-topEdge-[storeLogo]-topEdge-|", @"V:|-topEdge-[rightView]-topEdge-|",
                          @"H:|-defEdge-[labelStoreName]-defEdge-|",@"H:|-defEdge-[shipView]-defEdge-|",@"H:|-defEdge-[saleView]-defEdge-|",
                          @"V:|-defEdge-[labelStoreName][shipView][saleView]-defEdge-|",
                          @"H:|-defEdge-[labelShip(==60)]-leftEdge-[labelShipTime]-defEdge-|", @"V:|-5-[labelShip]-5-|", @"V:|-defEdge-[labelShipTime]-defEdge-|",
                          @"H:|-defEdge-[starView(==60)][labelSale]-defEdge-|", @"V:|-3-[starView]-defEdge-|", @"V:|-defEdge-[labelSale]-defEdge-|",
                          @"H:[line(==1)]-leftEdge-[shopCar(==carSize)]-leftEdge-|", @"V:|-defEdge-[shopCar(==carSize)]", @"V:|-defEdge-[line(==carSize)]",
                          @"H:|-leftEdge-[labelActiveType(==35)]-leftEdge-[labelActive]-defEdge-|",
                          @"V:|-defEdge-[labelActiveType]-topEdge-|", @"V:|-defEdge-[labelActive]-topEdge-|"
                          ];
    NSDictionary*  metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"topHeight":@(80), @"bottomHeight":@(25), @"carSize":@(20)};
    NSDictionary*  views = @{ @"contentView":self.contentView,
                              @"imgRecommend":self.imgRecommend,
                              @"topView":self.topView, @"bottomView":self.bottomView, @"subCollectionView":self.subCollectionView,
                              @"storeLogo":self.storeLogo, @"rightView":self.rightView,
                              @"labelStoreName":self.labelStoreName, @"shipView":self.shipView, @"saleView":self.saleView,
                              @"labelShip":self.labelShip, @"labelShipTime":self.labelShipTime,
                              @"starView":self.starView, @"labelSale":self.labelSale,
                              @"line":self.line, @"shopCar":self.shopCar,
                              @"labelActiveType":self.labelActiveType, @"labelActive":self.labelActive
                              };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @" %@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    
}


#pragma mark =====================================================  <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *foods = [self.item objectForKey: @"foods"];
    if(foods){
        return foods.count>=4?4:foods.count;
    }
    return 0;
    //return foods.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewHomeCell* cell = (NewHomeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSArray *foods = [self.item objectForKey: @"foods"];
    cell.item = foods[indexPath.row];
    return  cell;
}
#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *foods = [self.item objectForKey: @"foods"];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedGoods:goods:)]){
        [self.delegate didSelectedGoods:self.item goods:foods[indexPath.row]];
    }
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 60; //(SCREEN_WIDTH-20-1)/4;
    return CGSizeMake((SCREEN_WIDTH-20-1)/4, height+30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}


-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        
        self.labelActive.text = [item objectForKey: @"full_discount"];
        [self.storeLogo sd_setImageWithURL:[NSURL URLWithString:[item objectForKey: @"logo"]] placeholderImage:[UIImage imageNamed:kDefStoreLogo]];
        self.labelStoreName.text = [item objectForKey: @"site_name"];
        self.labelShip.text = [item objectForKey: @"send"];
        self.labelShipTime.text = [item objectForKey: @"time"];
        self.labelSale.text = [NSString stringWithFormat: @" | 月售%@单",[item objectForKey: @"shop_sale"]];
        NSInteger star = [[item objectForKey: @"score"] integerValue];
        for (UIButton *btn in self.arrayStar) {
            if(btn.tag< star){
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
        
        [self.subCollectionView reloadData];
    }
}

#pragma mark =====================================================  SEL
-(IBAction)gestureTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedStore:)]){
        [self.delegate didSelectedStore:self.item];
    }
}

#pragma mark =====================================================  propertyp packge

-(UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.borderWidth = 1.f;
        _contentView.layer.cornerRadius = 5.f;
        _contentView.layer.borderColor = theme_line_color.CGColor;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        UITapGestureRecognizer *tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTouch:)];
        [_topView addGestureRecognizer:tapgr];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIImageView *)storeLogo{
    if(!_storeLogo){
        _storeLogo = [[UIImageView alloc]init];
        _storeLogo.layer.borderColor = theme_line_color.CGColor;
        _storeLogo.layer.borderWidth = 1.f;
        _storeLogo.layer.masksToBounds = YES;
        _storeLogo.layer.cornerRadius = 5.f;
        _storeLogo.translatesAutoresizingMaskIntoConstraints= NO;
    }
    return _storeLogo;
}

-(UIView *)rightView{
    if(!_rightView){
        _rightView = [[UIView alloc]init];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}

-(UILabel *)labelStoreName{
    if(!_labelStoreName){
        _labelStoreName = [[UILabel alloc]init];
        _labelStoreName.font = [UIFont systemFontOfSize:15.f];
        _labelStoreName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStoreName;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        [_line setImage:[UIImage imageNamed: @"line-vertical-home"]];
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}

-(UIImageView *)shopCar{
    if(!_shopCar){
        _shopCar = [[UIImageView alloc]init];
        [_shopCar setImage:[UIImage imageNamed: @"icon-car-gay"]];
        _shopCar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _shopCar;
}

-(UIView *)shipView{
    if(!_shipView){
        _shipView = [[UIView alloc]init];
        _shipView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _shipView;
}

-(UILabel *)labelShip{
    if(!_labelShip){
        _labelShip = [[UILabel alloc]init];
        _labelShip.textColor = [UIColor whiteColor];
        _labelShip.backgroundColor = theme_navigation_color;
        _labelShip.font = [UIFont systemFontOfSize:12.f];
        _labelShip.textAlignment = NSTextAlignmentCenter;
        _labelShip.layer.masksToBounds = YES;
        _labelShip.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShip;
}

-(UILabel *)labelShipTime{
    if(!_labelShipTime){
        _labelShipTime = [[UILabel alloc]init];
        _labelShipTime.textColor = [UIColor grayColor];
        _labelShipTime.font = [UIFont systemFontOfSize:12.f];
        _labelShipTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShipTime;
}

-(UIView *)saleView{
    if(!_saleView){
        _saleView = [[UIView alloc]init];
        _saleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _saleView;
}

-(UIView *)starView{
    if(!_starView){
        _starView = [[UIView alloc]init];
        _starView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _starView;
}

-(UIImageView *)lineSale{
    if(!_lineSale){
        _lineSale = [[UIImageView alloc]init];
        [_lineSale setImage:[UIImage imageNamed: @"line-vertical-home"]];
        _lineSale.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _lineSale;
}

-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.textColor = [UIColor grayColor];
        _labelSale.font = [UIFont systemFontOfSize:12.f];
        _labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSale;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}


-(UILabel *)labelActiveType{
    if(!_labelActiveType){
        _labelActiveType = [[UILabel alloc]init];
        _labelActiveType.backgroundColor = [UIColor redColor];
        _labelActiveType.font = [UIFont systemFontOfSize:12.f];
        _labelActiveType.textColor = [UIColor whiteColor];
        _labelActiveType.layer.masksToBounds = YES;
        _labelActiveType.text =  @"满减";
        _labelActiveType.textAlignment = NSTextAlignmentCenter;
        _labelActiveType.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelActiveType;
}

-(UILabel *)labelActive{
    if(!_labelActive){
        _labelActive = [[UILabel alloc]init];
        _labelActive.textColor = [UIColor grayColor];
        _labelActive.font = [UIFont systemFontOfSize:12.f];
        _labelActive.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelActive;
}
-(UIImageView *)imgRecommend{
    if(!_imgRecommend){
        _imgRecommend = [[UIImageView alloc]init];
        [_imgRecommend setImage:[UIImage imageNamed: @"icon-recommend"]];
        _imgRecommend.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgRecommend;
}

-(UICollectionView *)subCollectionView{
    if(!_subCollectionView){
        _subCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _subCollectionView.delegate = self;
        _subCollectionView.dataSource = self;
        _subCollectionView.backgroundColor = [UIColor whiteColor];
        [_subCollectionView registerClass:[NewHomeCell class] forCellWithReuseIdentifier:cellIdentifier];
        _subCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _subCollectionView;
}


@end
