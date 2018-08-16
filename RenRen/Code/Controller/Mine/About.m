//
//  About.m
//  KYRR
//
//  Created by kyjun on 16/1/7.
//
//

#import "About.h"

@interface About ()
@property(nonatomic,strong) UIImageView* photoIcon;
@property(nonatomic,strong) UILabel* labelVersion;
//@property(nonatomic,strong) UIImageView* photoQRcode;
@property(nonatomic,strong) UILabel* labelCopyRight;

@end

@implementation About

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = theme_table_bg_color;
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"关于我们";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutUI{
    [self.view addSubview:self.photoIcon];
    [self.view addSubview:self.labelVersion];
    [self.view addSubview:self.labelCopyRight];
}

-(void)layoutConstraints{
    self.photoIcon.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelVersion.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCopyRight.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.photoIcon addConstraints:@[
                                     [NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3],
                                     [NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3],
                                     ]];

    [self.labelVersion addConstraint:[NSLayoutConstraint constraintWithItem:self.labelVersion attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    
    [self.labelCopyRight addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCopyRight attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    
    
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:SCREEN_HEIGHT/2 - 64 -130],
                                [NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.labelVersion attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photoIcon attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f],
                                [NSLayoutConstraint constraintWithItem:self.labelVersion attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.labelVersion attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f],
                                
                                [NSLayoutConstraint constraintWithItem:self.labelCopyRight attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f],
                                [NSLayoutConstraint constraintWithItem:self.labelCopyRight attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.labelCopyRight attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]
                                ]];
}

#pragma mark =====================================================  Property Package
-(UIImageView *)photoIcon{
    if(!_photoIcon){
        _photoIcon = [[UIImageView alloc]init];
        [_photoIcon setImage:[UIImage imageNamed:@"Icon-default-image"]];
        _photoIcon.layer.masksToBounds = YES;
        _photoIcon.layer.cornerRadius = 5.f;
    }
    return _photoIcon;
}

-(UILabel *)labelVersion{
    if(!_labelVersion){
        _labelVersion = [[UILabel alloc]init];
        NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
        NSString* buildVersion = [bundleDic objectForKey:@"CFBundleVersion"];
        NSString* releaseVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
        _labelVersion.text = [NSString stringWithFormat:@"For iPhone V%@  Build%@",releaseVersion,buildVersion != 0?buildVersion:releaseVersion];
        _labelVersion.textAlignment = NSTextAlignmentCenter;
        _labelVersion.font = [UIFont systemFontOfSize:14.f];
        _labelVersion.textColor = theme_Fourm_color;
    }
    return _labelVersion;
}



-(UILabel *)labelCopyRight{
    if(!_labelCopyRight){
        _labelCopyRight = [[UILabel alloc]init];
        NSAttributedString* attributeStr =[[NSAttributedString alloc]initWithString:@"完美网络科技有限公司 \n Copyright © 2016-2017 http://wm.wm0530.com" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14.0],NSForegroundColorAttributeName:theme_Fourm_color}];
        _labelCopyRight.attributedText = attributeStr;
        _labelCopyRight.textAlignment = NSTextAlignmentCenter;
        _labelCopyRight.numberOfLines = 0;
        _labelCopyRight.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _labelCopyRight;
}

@end
