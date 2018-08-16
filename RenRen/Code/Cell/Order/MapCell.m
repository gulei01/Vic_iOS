//
//  MapCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/19.
//
//

#import "MapCell.h"
#import "KCAnnotation.h"
@interface MapCell ()<MKMapViewDelegate>
@property(nonatomic,strong) MKMapView* mapView;
@property(nonatomic,strong) MOrderStatus* entity;
@property(nonatomic,strong) UIView* infoView;;
@property(nonatomic,strong) UIImageView* infoBackground;

@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UIButton* btnMark;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIImageView* lineTop;
@property(nonatomic,strong) UIImageView* lineBottom;
@end

@implementation MapCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = theme_table_bg_color;
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.infoView];
    [self.infoView addSubview:self.infoBackground];
    [self.infoView addSubview:self.labelStatus];
    [self.infoView addSubview:self.btnMark];
    [self.infoView addSubview:self.labelCreateDate];
    [self.contentView addSubview:self.lineTop];
    [self.contentView addSubview:self.lineBottom];
    
    self.mapView=[[MKMapView alloc]init];
    [self.contentView addSubview:_mapView];
    //设置代理
    self.mapView.delegate=self;
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    self.mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    self.mapView.mapType=MKMapTypeStandard;
    
}

-(void)layoutConstraints{
    self.lineTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineBottom.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoView.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoBackground.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnMark.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    //[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.lineTop addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    
    [self.lineBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.btnMark addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.self.labelStatus attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.mapView addConstraint:[NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:130.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.mapView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}


#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//头像
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }else {
        return nil;
    }
}


-(void)loadAnnotation:(double)lat lng:(double)lng entity:(MOrderStatus *)entity{
    if(entity){
        _entity = entity;
        self.labelStatus.text = entity.name;
        self.labelCreateDate.text = entity.createDate;
        self.btnMark.userInteractionEnabled = NO;
        [self.btnMark setTitle:entity.mark forState:UIControlStateNormal];
        NSString* imageName = [NSString stringWithFormat:@"icon-order-status-%@",entity.status];
        [self.icon setImage:[UIImage imageNamed:imageName]];
        if([entity.status isEqualToString:@"1"]){
            self.lineTop.hidden = YES;
        }
        if([entity.status integerValue]>3){
            self.lineBottom.hidden = YES;
        }
        CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(lat,lng);
        KCAnnotation *annotation1=[[KCAnnotation alloc]init];
        annotation1.title=entity.mark;
        annotation1.coordinate=location1;
        annotation1.image=[UIImage imageNamed:@"icon-express"];
        [_mapView addAnnotation:annotation1];
    }
}


-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

-(UIImageView *)lineTop{
    if(!_lineTop){
        _lineTop = [[UIImageView alloc]init];
        [_lineTop setImage:[UIImage imageNamed:@"icon-line-ver"]];
    }
    return _lineTop;
}

-(UIImageView *)lineBottom{
    if(!_lineBottom){
        _lineBottom = [[UIImageView alloc]init];
        [_lineBottom setImage:[UIImage imageNamed:@"icon-line-ver"]];
    }
    return _lineBottom;
}

-(UIView *)infoView{
    if(!_infoView){
        _infoView = [[UIView alloc]init];
    }
    return _infoView;
}

-(UIImageView *)infoBackground{
    if(!_infoBackground){
        _infoBackground = [[UIImageView alloc]init];
        [_infoBackground setImage:[UIImage imageNamed:@"icon-order-background"]];
    }
    return _infoBackground;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
    }
    return _labelStatus;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.textColor = [UIColor colorWithRed:164/255.f green:164/255.f blue:164/255.f alpha:1.0];
        _labelCreateDate.font = [UIFont systemFontOfSize:12.f];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
    }
    return _labelCreateDate;
}

-(UIButton *)btnMark{
    if(!_btnMark){
        _btnMark = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMark setTitleColor:[UIColor colorWithRed:164/255.f green:164/255.f blue:164/255.f alpha:1.0] forState:UIControlStateNormal];
        _btnMark.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnMark.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnMark.userInteractionEnabled = NO;
        //[_btnMark addTarget:self action:@selector(callPhoneTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMark;
}

@end
