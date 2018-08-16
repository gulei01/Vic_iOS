//
//  FightGroupItemHeader.m
//  KYRR
//
//  Created by kyjun on 16/6/17.
//
//

#import "FightGroupItemHeader.h"
#import "TuanCell.h"
#import "GroupBuy.h"
#import "TuanRuleInfo.h"
#import <SVWebViewController/SVWebViewController.h>

@interface FightGroupItemHeader ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,TuanCellDelegate>
@property(nonatomic,strong) UIView* headerView;

@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIView* contentView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UILabel* labelMark;
@property(nonatomic,strong) UIView* tuansView;
@property(nonatomic,strong) UILabel* labelTuans;

@property(nonatomic,strong) UIView* footerView;
@property(nonatomic,strong) UIView* ruleView;
@property(nonatomic,strong) TuanRuleInfo* btnInfo;
@property(nonatomic,strong) UIView* descView;
@property(nonatomic,strong) UILabel* labelDesc;

@property(nonatomic,strong) MFightGroup* entity;

@property(nonatomic,strong) NSString* url;

@property(nonatomic,strong) UITableView* subTableView;
@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,copy) NSString* cellIdentifier;

@end

@implementation FightGroupItemHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.cellIdentifier = @"TuanCell";
    [self layoutUI];
    [self layoutConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout

-(void)layoutUI{
    [self.view addSubview:self.subTableView];
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH+150.f);
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 135.f);
    self.subTableView.tableHeaderView = self.headerView;
    self.subTableView.tableFooterView = self.footerView;
    
    [self.headerView addSubview:self.photo];
    [self.headerView addSubview:self.contentView];
    
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.priceView];
    [self.priceView addSubview:self.labelPrice];
    [self.priceView addSubview:self.labelSale];
    [self.contentView addSubview:self.labelMark];
    [self.contentView addSubview:self.tuansView];
    [self.tuansView addSubview:self.labelTuans];
    
    [self.footerView addSubview:self.ruleView];
    [self.ruleView addSubview:self.btnInfo];
    [self.footerView addSubview:self.descView];
    [self.descView addSubview:self.labelDesc];
    
}

-(void)layoutConstraints{
    self.subTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.photo.translatesAutoresizingMaskIntoConstraints =NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    self.tuansView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTuans.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.ruleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnInfo.translatesAutoresizingMaskIntoConstraints = NO;
    self.descView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDesc.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.labelMark addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelMark addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.tuansView addConstraint:[NSLayoutConstraint constraintWithItem:self.tuansView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.tuansView addConstraint:[NSLayoutConstraint constraintWithItem:self.tuansView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.tuansView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelMark attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.tuansView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTuans addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTuans attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelTuans addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTuans attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20]];
    [self.tuansView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTuans attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tuansView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.tuansView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTuans attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tuansView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    
    [self.ruleView addConstraint:[NSLayoutConstraint constraintWithItem:self.ruleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:95.f]];
    [self.ruleView addConstraint:[NSLayoutConstraint constraintWithItem:self.ruleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.ruleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.ruleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90.f]];
    [self.btnInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.ruleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ruleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.ruleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.ruleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ruleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant: 10.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f]];
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
}

#pragma mark =====================================================  <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TuanCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.entity = self.arrayData[indexPath.row];
    
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MTuan* item = self.arrayData[indexPath.row];
    GroupBuy *controller = [[GroupBuy alloc]initWithRowID:item.rowID];
    [self.navigationController pushViewController:controller animated:YES];
}



-(void)loadData:(MFightGroupInfo *)entity complete:(void (^)(CGSize))complete{
    if(entity){
        self.arrayData = entity.arrayTuan;
        
        if(self.arrayData.count>0){
            self.labelTuans.hidden = NO;
        }else{
            self.labelTuans.hidden = YES;
        }
        _entity = entity.fightGroup;
        NSInteger num = [self.entity.pingNum integerValue];
        if(num>1){
            self.labelMark.text = [NSString stringWithFormat:@"支付开团并邀请%@人参团，人数不足自动退款",[WMHelper integerConvertToString:(num-1)]];
        }else{
            self.labelMark.text =@"支付开团并邀请0人参团，人数不足自动退款";
        }
        NSString* strIcon = @"￥";
        NSString* marktPrice = [NSString stringWithFormat:@"￥%@",self.entity.marketPrice];
        NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,self.entity.tuanPrice,marktPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:self.entity.tuanPrice]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:marktPrice]];
        [self.labelPrice setAttributedText:attributeStr];
        self.labelSale.text = [NSString stringWithFormat:@"累计销量:%@件",self.entity.goodsSales];
        self.labelTitle.text = self.entity.goodsName;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:self.entity.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(CGSizeEqualToSize(self.entity.thumbnailsSize, CGSizeZero)){
                CGFloat width = SCREEN_WIDTH;
                CGFloat height = image.size.height*width/image.size.width;
                self.entity.thumbnailsSize=CGSizeMake(width, height);
                //  complete(self.entity.thumbnailsSize);
            }
        }];
        self.url = entity.tuanInfoUrl;
       // [_btnInfo sd_setImageWithURL:[NSURL URLWithString:entity.tuanInfoPhoto] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed: @"default-tuan-info"]];
        [self.subTableView reloadData];
    }
}

#pragma mark =====================================================  SEL
-(void)tuanViewTouch:(UITapGestureRecognizer *)gestureRecognizer{
    NSURL *URL = [NSURL URLWithString:self.url];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark =====================================================  property package

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

-(UITableView *)subTableView{
    if(!_subTableView){
        _subTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _subTableView.delegate = self;
        _subTableView.dataSource = self;
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_subTableView registerClass:[TuanCell class] forCellReuseIdentifier:self.cellIdentifier];
    }
    return _subTableView;
}

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]init];
    }
    return _headerView;
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}

-(UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor colorWithRed:238/255.f green:239/255.f blue:240/255.f alpha:1.0];
    }
    return _contentView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.backgroundColor = [UIColor colorWithRed:238/255.f green:239/255.f blue:240/255.f alpha:1.0];
        _labelTitle.textColor = [UIColor colorWithRed:42/255.f green:42/255.f blue:42/255.f alpha:1.0];
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

-(UILabel *)labelPrice {
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
    }
    return _labelPrice;
}

-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.textColor = [UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0];
        _labelSale.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelSale;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0];
        _labelMark.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelMark;
}

-(UIView *)tuansView{
    if(!_tuansView){
        _tuansView = [[UIView alloc]init];
        _tuansView.backgroundColor = [UIColor whiteColor];
    }
    return _tuansView;
}

-(UILabel *)labelTuans{
    if(!_labelTuans){
        _labelTuans = [[UILabel alloc]init];
        _labelTuans.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0];
        _labelTuans.font = [UIFont systemFontOfSize:12.f];
        _labelTuans.text =  @"以下小伙伴正在发起团购、您可以直接参与";
    }
    return _labelTuans;
}

-(UIView *)footerView{
    if(!_footerView){
        _footerView = [[UIView alloc]init];
       // _footerView.backgroundColor = [UIColor redColor];
    }
    return _footerView;
}

-(UIView *)ruleView{
    if(!_ruleView){
        _ruleView = [[UIView alloc]init];
        _ruleView.backgroundColor = [UIColor whiteColor];
    }
    return _ruleView;
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

-(TuanRuleInfo *)btnInfo{
    if(!_btnInfo){
        _btnInfo = [[TuanRuleInfo alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90.f)];
        _btnInfo.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuanViewTouch:)];
        [_btnInfo addGestureRecognizer:singleTap];
    }
    return _btnInfo;
}
@end
