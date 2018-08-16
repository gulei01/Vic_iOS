//
//  StoreListCell.m
//  KYRR
//
//  Created by kyjun on 15/10/29.
//
//

#import "StoreListCell.h"

@interface StoreListCell ()<UITableViewDataSource>
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* photoLogo;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UILabel* labelStoreName;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UILabel* labelServiceTime;
@property(nonatomic,strong) UILabel* labelShip;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIImageView* photoSender;
@property(nonatomic,strong) UITableView* activeTableView;
@property(nonatomic,strong) UILabel* labelLine;


@end

@implementation StoreListCell

 
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = theme_default_color;
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark ===================================================== 试图布局
-(void)layoutUI{
    [self addSubview:self.topView];
    [self.topView addSubview:self.photoLogo];
    [self.topView addSubview:self.rightView];
    [self.rightView addSubview:self.labelStoreName];
    [self.rightView addSubview:self.photoSender];
    [self.rightView addSubview:self.labelStatus];
    [self.rightView addSubview:self.labelServiceTime];
    [self.rightView addSubview:self.labelShip];
    [self.rightView addSubview:self.labelSale];
    [self addSubview:self.activeTableView];
    [self addSubview:self.labelLine];
}

-(void)layoutConstraints{
    
    NSArray* formats = @[ @"H:|-0-[topView]-0-|", @"V:|-0-[topView(==90)][activeTableView(>=0@751)][labelLine(==15)]-0-|", @"H:|-0-[labelLine]-0-|", @"H:|-105-[activeTableView]-0-|",
                          @"H:|-0-[photoLogo(==105)]", @"V:|-10-[photoLogo(==70)]", @"H:[photoLogo]-10-[rightView]-10-|", @"V:|-10-[rightView(photoLogo)]",
                          @"H:|-0-[labelStoreName][labelSale]-0-|",
                          @"H:|-0-[labelStatus(==60)][labelServiceTime]-0-|",
                          @"H:|-0-[labelShip][photoSender(==60)]-0-|",
                          @"V:|-0-[labelSale]-5-[labelServiceTime(labelSale)]-7-[photoSender(==15)]-0-|",
                          @"V:|-0-[labelStoreName]-5-[labelStatus(labelStoreName)]-5-[labelShip(labelStoreName)]-0-|"
                          ];
    NSDictionary* metrics = @{};
    NSDictionary* views = @{ @"topView":self.topView , @"labelLine":self.labelLine,@"photoLogo":self.photoLogo, @"rightView":self.rightView, @"labelSale":self.labelSale, @"labelStoreName":self.labelStoreName, @"labelStatus":self.labelStatus, @"photoSender":self.photoSender, @"labelShip":self.labelShip, @"labelServiceTime":self.labelServiceTime, @"activeTableView":self.activeTableView};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
}


-(void)setEntity:(MStore *)entity{
    if(entity){
        _entity = entity;
        [self.photoLogo sd_setImageWithURL:[NSURL URLWithString:entity.logo] placeholderImage:[UIImage imageNamed:kDefaultImage]];
        self.labelStoreName.text = entity.storeName;
        NSInteger status = [entity.status integerValue];
        if(status==1){//开启
            self.labelStatus.backgroundColor =theme_navigation_color;;
            self.labelStatus.text = @"营业中";
            self.labelServiceTime.hidden = NO;
        }else{//休息
            self.labelStatus.backgroundColor =[UIColor colorWithRed:181/255.f green:181/255.f blue:181/255.f alpha:1.0];
            self.labelStatus.text = @"休息中";
            self.labelServiceTime.hidden = YES;
        }
        self.labelServiceTime.text = [NSString stringWithFormat:@"营业时间:%@ - %@",entity.servicTimeBegin,entity.serviceTimerEnd];
        self.labelSale.text = [NSString stringWithFormat:@"月售%@",entity.sale];
        self.labelShip.text = [NSString stringWithFormat:@"起送￥%@ 配送￥%@",entity.freeShip,entity.shipFee];
        self.photoSender.hidden = [entity.shipUnit integerValue]==1;
        [self.activeTableView reloadData];
    }
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.entity.arrayActive.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreActiveCell* cell = [tableView dequeueReusableCellWithIdentifier: @"StoreActiveCell" forIndexPath:indexPath];
    cell.item = self.entity.arrayActive[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UILabel alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 89.5,SCREEN_WIDTH, .5f);
        border.backgroundColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:0.5f].CGColor;
        [_topView.layer addSublayer:border];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIImageView *)photoLogo{
    if(!_photoLogo){
        _photoLogo = [[UIImageView alloc]init];
        _photoLogo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoLogo;
}
-(UIView *)rightView {
    if(!_rightView){
        _rightView = [[UIView alloc]init];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}
-(UILabel *)labelStoreName{
    if(!_labelStoreName){
        _labelStoreName = [[UILabel alloc]init];
        _labelStoreName.font=[UIFont systemFontOfSize:15.f];
        _labelStoreName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStoreName;
}
-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.layer.masksToBounds = YES;
        _labelStatus.layer.cornerRadius=10.f;
        _labelStatus.textColor = [UIColor whiteColor];
        _labelStatus.font = [UIFont systemFontOfSize:14.f];
        _labelStatus.textAlignment = NSTextAlignmentCenter;
        _labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStatus;
}
-(UILabel *)labelServiceTime{
    if(!_labelServiceTime){
        _labelServiceTime = [[UILabel alloc]init];
        _labelServiceTime.font = [UIFont systemFontOfSize:12.f];
        _labelServiceTime.textColor = [UIColor lightGrayColor];
        _labelServiceTime.textAlignment = NSTextAlignmentRight;
        _labelServiceTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelServiceTime;
}
-(UILabel *)labelShip{
    if(!_labelShip){
        _labelShip = [[UILabel alloc]init];
        _labelShip.font = [UIFont systemFontOfSize:12.f];
        _labelShip.textColor = [UIColor lightGrayColor];
        _labelShip.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShip;
}
-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.font = [UIFont systemFontOfSize:12.f];
        _labelSale.textColor = [UIColor lightGrayColor];
        _labelSale.textAlignment = NSTextAlignmentRight;
        _labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSale;
}
-(UIImageView *)photoSender{
    if(!_photoSender){
        _photoSender  =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-sender"]];
        _photoSender.translatesAutoresizingMaskIntoConstraints =  NO;
    }
    return _photoSender;
}

-(UITableView *)activeTableView{
    if(!_activeTableView){
        _activeTableView = [[UITableView alloc]init];
        _activeTableView.backgroundColor = [UIColor whiteColor];
        _activeTableView.dataSource = self;
        _activeTableView.rowHeight = 25.f;
        _activeTableView.userInteractionEnabled = NO;
        _activeTableView.scrollEnabled = NO;
        _activeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_activeTableView registerClass:[StoreActiveCell class] forCellReuseIdentifier: @"StoreActiveCell"];
        _activeTableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _activeTableView;
}

-(UILabel *)labelLine{
    if(!_labelLine){
        _labelLine = [[UILabel alloc]init];
        _labelLine.backgroundColor = theme_line_color;
        _labelLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelLine;
}
@end

#pragma mark =====================================================  StoreListTableCell
@interface StoreListTableCell()<UITableViewDataSource>
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* photoLogo;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UILabel* labelStoreName;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UILabel* labelServiceTime;
@property(nonatomic,strong) UILabel* labelShip;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIImageView* photoSender;
@property(nonatomic,strong) UITableView* activeTableView;
@property(nonatomic,strong) UILabel* labelLine;


@end
@implementation StoreListTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = theme_default_color;
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
} 
#pragma mark ===================================================== 试图布局
-(void)layoutUI{
    [self addSubview:self.topView];
    [self.topView addSubview:self.photoLogo];
    [self.topView addSubview:self.rightView];
    [self.rightView addSubview:self.labelStoreName];
    [self.rightView addSubview:self.photoSender];
    [self.rightView addSubview:self.labelStatus];
    [self.rightView addSubview:self.labelServiceTime];
    [self.rightView addSubview:self.labelShip];
    [self.rightView addSubview:self.labelSale];
    [self addSubview:self.activeTableView];
    [self addSubview:self.labelLine];
}

-(void)layoutConstraints{
    
    NSArray* formats = @[ @"H:|-0-[topView]-0-|", @"V:|-0-[topView(==90)][activeTableView(>=0@751)][labelLine(==15)]-0-|", @"H:|-0-[labelLine]-0-|", @"H:|-105-[activeTableView]-0-|",
                          @"H:|-0-[photoLogo(==105)]", @"V:|-10-[photoLogo(==70)]", @"H:[photoLogo]-10-[rightView]-10-|", @"V:|-10-[rightView(photoLogo)]",
                          @"H:|-0-[labelStoreName][labelSale]-0-|",
                          @"H:|-0-[labelStatus(==60)][labelServiceTime]-0-|",
                          @"H:|-0-[labelShip][photoSender(==60)]-0-|",
                          @"V:|-0-[labelSale]-5-[labelServiceTime(labelSale)]-7-[photoSender(==15)]-0-|",
                          @"V:|-0-[labelStoreName]-5-[labelStatus(labelStoreName)]-5-[labelShip(labelStoreName)]-0-|"
                          ];
    NSDictionary* metrics = @{};
    NSDictionary* views = @{ @"topView":self.topView , @"labelLine":self.labelLine,@"photoLogo":self.photoLogo, @"rightView":self.rightView, @"labelSale":self.labelSale, @"labelStoreName":self.labelStoreName, @"labelStatus":self.labelStatus, @"photoSender":self.photoSender, @"labelShip":self.labelShip, @"labelServiceTime":self.labelServiceTime, @"activeTableView":self.activeTableView};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
}


-(void)setEntity:(MStore *)entity{
    if(entity){
        _entity = entity;
        [self.photoLogo sd_setImageWithURL:[NSURL URLWithString:entity.logo] placeholderImage:[UIImage imageNamed:kDefaultImage]];
        self.labelStoreName.text = entity.storeName;
        NSInteger status = [entity.status integerValue];
        if(status==1){//开启
            self.labelStatus.backgroundColor =theme_navigation_color;;
            self.labelStatus.text = @"营业中";
            self.labelServiceTime.hidden = NO;
        }else{//休息
            self.labelStatus.backgroundColor =[UIColor colorWithRed:181/255.f green:181/255.f blue:181/255.f alpha:1.0];
            self.labelStatus.text = @"休息中";
            self.labelServiceTime.hidden = YES;
        }
        self.labelServiceTime.text = [NSString stringWithFormat:@"营业时间:%@ - %@",entity.servicTimeBegin,entity.serviceTimerEnd];
        self.labelSale.text = [NSString stringWithFormat:@"月售%@",entity.sale];
        self.labelShip.text = [NSString stringWithFormat:@"起送￥%@ 配送￥%@",entity.freeShip,entity.shipFee];
        self.photoSender.hidden = [entity.shipUnit integerValue]==1;
        [self.activeTableView reloadData];
    }
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.entity.arrayActive.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreActiveCell* cell = [tableView dequeueReusableCellWithIdentifier: @"StoreActiveCell" forIndexPath:indexPath];
    cell.item = self.entity.arrayActive[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UILabel alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 89.5,SCREEN_WIDTH, .5f);
        border.backgroundColor = [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:0.5f].CGColor;
        [_topView.layer addSublayer:border];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIImageView *)photoLogo{
    if(!_photoLogo){
        _photoLogo = [[UIImageView alloc]init];
        _photoLogo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photoLogo;
}
-(UIView *)rightView {
    if(!_rightView){
        _rightView = [[UIView alloc]init];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}
-(UILabel *)labelStoreName{
    if(!_labelStoreName){
        _labelStoreName = [[UILabel alloc]init];
        _labelStoreName.font=[UIFont systemFontOfSize:15.f];
        _labelStoreName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStoreName;
}
-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.layer.masksToBounds = YES;
        _labelStatus.layer.cornerRadius=10.f;
        _labelStatus.textColor = [UIColor whiteColor];
        _labelStatus.font = [UIFont systemFontOfSize:14.f];
        _labelStatus.textAlignment = NSTextAlignmentCenter;
        _labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStatus;
}
-(UILabel *)labelServiceTime{
    if(!_labelServiceTime){
        _labelServiceTime = [[UILabel alloc]init];
        _labelServiceTime.font = [UIFont systemFontOfSize:12.f];
        _labelServiceTime.textColor = [UIColor lightGrayColor];
        _labelServiceTime.textAlignment = NSTextAlignmentRight;
        _labelServiceTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelServiceTime;
}
-(UILabel *)labelShip{
    if(!_labelShip){
        _labelShip = [[UILabel alloc]init];
        _labelShip.font = [UIFont systemFontOfSize:12.f];
        _labelShip.textColor = [UIColor lightGrayColor];
        _labelShip.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelShip;
}
-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.font = [UIFont systemFontOfSize:12.f];
        _labelSale.textColor = [UIColor lightGrayColor];
        _labelSale.textAlignment = NSTextAlignmentRight;
        _labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSale;
}
-(UIImageView *)photoSender{
    if(!_photoSender){
        _photoSender  =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-sender"]];
        _photoSender.translatesAutoresizingMaskIntoConstraints =  NO;
    }
    return _photoSender;
}

-(UITableView *)activeTableView{
    if(!_activeTableView){
        _activeTableView = [[UITableView alloc]init];
        _activeTableView.backgroundColor = [UIColor whiteColor];
        _activeTableView.dataSource = self;
        _activeTableView.rowHeight = 25.f;
        _activeTableView.userInteractionEnabled = NO;
        _activeTableView.scrollEnabled = NO;
        _activeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_activeTableView registerClass:[StoreActiveCell class] forCellReuseIdentifier: @"StoreActiveCell"];
        _activeTableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _activeTableView;
}

-(UILabel *)labelLine{
    if(!_labelLine){
        _labelLine = [[UILabel alloc]init];
        _labelLine.backgroundColor = theme_line_color;
        _labelLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelLine;
}

@end

#pragma mark =====================================================  StoreActiveCell
@interface StoreActiveCell ()

@property(nonatomic,strong) UILabel* labelIcon;
@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation StoreActiveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.labelIcon];
    [self addSubview:self.labelTitle];
}
-(void)layoutConstraints{
    NSArray* formats = @[ @"H:|-10-[labelIcon(==15)]-10-[labelTitle]-0-|", @"V:|-5-[labelIcon(==15)]", @"V:|-0-[labelTitle]-0-|"];
    NSDictionary* metrics = @{};
    NSDictionary* views = @{ @"labelIcon":self.labelIcon, @"labelTitle":self.labelTitle};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSString* key = [[item allKeys]firstObject];
        self.labelIcon.text = key;
        if([key isEqualToString: @"满"]){
            self.labelIcon.text =  @"减";
            self.labelIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"icon-full-cut"]];
        }else{
            self.labelIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"icon-first-cut"]];
        }
        
        self.labelTitle.text = [item objectForKey:key];
    }
}
#pragma mark =====================================================  property package
-(UILabel *)labelIcon{
    if(!_labelIcon){
        _labelIcon = [[UILabel alloc]init];
        _labelIcon.backgroundColor = [UIColor colorWithRed:rand()%255/255.f green:rand()%255/255.f blue:rand()%255/255.f alpha:1.0];
        _labelIcon.font = [UIFont systemFontOfSize:12.f];
        _labelIcon.textColor = [UIColor whiteColor];
        _labelIcon.layer.masksToBounds = YES;
        _labelIcon.layer.cornerRadius = 3.f;
        _labelIcon.textAlignment = NSTextAlignmentCenter;
        _labelIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelIcon;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:12.f];
        _labelTitle.textColor = [UIColor grayColor];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}



@end
