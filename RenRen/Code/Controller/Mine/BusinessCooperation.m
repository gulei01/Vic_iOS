//
//  BusinessCooperation.m
//  KYRR
//
//  Created by kyjun on 15/11/10.
//
//

#import "BusinessCooperation.h"

@interface BusinessCooperation ()
@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIImageView* iconArrow;
@property(nonatomic,strong) UIImageView* line;

@property(nonatomic,strong) UILabel* labelContent;


@end

@implementation BusinessCooperation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"商务合作";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.headerView.backgroundColor = theme_default_color;
    
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.text = @"商家合作";
    self.labelTitle.textColor = theme_Fourm_color;
    self.labelTitle.font = [UIFont systemFontOfSize:14.f];
    [self.headerView addSubview:self.labelTitle];
    
    self.iconArrow  =[[UIImageView alloc]init];
    [self.iconArrow setImage:[UIImage imageNamed:@"icon-arrow-bottom-default"]];
    [self.headerView addSubview:self.iconArrow];
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.headerView addSubview:self.line];
    
    self.labelContent = [[UILabel alloc]init];
    
    self.labelContent.font = [UIFont systemFontOfSize:14.f];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[@"<p><span style=\"font-size:14px;\">商务合作</span>  </p><p> <span style=\"font-size:14px;\">微信/QQ :15350587575/531621308 </span><span style=\"font-size:14px;\"></span></p><p> <span style=\"font-size:14px;\">邮箱 :531621308@163.com</span> </p> <p><span style=\"font-size:14px;\">电话 :15350587575</span> </p><p><span style=\"font-size:14px;\">服务时间 :周一至周日09:00-18:00</span></p><p><span style=\"font-size:14px;\">温馨提示:寻求合作类的邮件、电话,若我方有合作意向，将会有专人与您取得联系:若无合作意向则不做回复、请您知悉，谢谢。</span> </p>" dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.labelContent.attributedText=attrStr;
    
    self.labelContent.numberOfLines = 0;
    self.labelContent.lineBreakMode = NSLineBreakByCharWrapping;
    [self.headerView addSubview:self.labelContent];
    
    
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)layoutConstraints{
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconArrow.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelContent.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.iconArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.iconArrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.iconArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.iconArrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconArrow attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:15.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconArrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelContent addConstraint:[NSLayoutConstraint constraintWithItem:self.labelContent attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20.f]];
    [self.labelContent addConstraint:[NSLayoutConstraint constraintWithItem:self.labelContent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelContent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    
}




@end
