//
//  Feedback.m
//  KYRR
//
//  Created by kyjun on 15/11/10.
//
//

#import "Feedback.h"
#import "AppDelegate.h"

@interface Feedback ()<UITextViewDelegate>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UILabel* labelDescription;
@property(nonatomic,strong) UITextView* txtRemark;
@property(nonatomic,strong) UIButton* btnSend;

@end

@implementation Feedback

-(instancetype)init{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self layoutConstraints];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     self.navigationItem.title = @"意见反馈";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.labelDescription = [[UILabel alloc]init];
    self.labelDescription.font = [UIFont systemFontOfSize:14.f];
    self.labelDescription.text = @"我知道我们的业务还不成熟，还有许多需要改进的地方、所以我们需要您的吐槽来帮助我们发现问题。您的意见是我们前进的动力!";
    self.labelDescription.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelDescription.numberOfLines = 0.f;
    [self.headerView addSubview:self.labelDescription];
    
    self.txtRemark = [[UITextView alloc]init];
    self.txtRemark.text = @"请输入您的反馈意见";
    self.txtRemark.delegate =self;
    self.txtRemark.layer.masksToBounds = YES;
    self.txtRemark.layer.cornerRadius = 5.f;
    self.txtRemark.layer.borderColor = theme_line_color.CGColor;
    self.txtRemark.layer.borderWidth = 1.0;
    self.txtRemark.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    
    self.txtRemark.editable = YES;        //是否允许编辑内容，默认为“YES”
    [self.headerView addSubview:self.txtRemark];
    
    self.btnSend =[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSend.backgroundColor =theme_navigation_color;
    [self.btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnSend setTitle:@"发送" forState:UIControlStateNormal];
    self.btnSend.layer.masksToBounds = YES;
    self.btnSend.layer.cornerRadius = 5.f;
    [self.btnSend addTarget:self action:@selector(btnSendTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.btnSend];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    
}

-(void)layoutConstraints{
    self.labelDescription.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtRemark.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnSend.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelDescription addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDescription attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20.f]];
    [self.labelDescription addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDescription attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.txtRemark addConstraint:[NSLayoutConstraint constraintWithItem:self.txtRemark attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20.f]];
    [self.txtRemark addConstraint:[NSLayoutConstraint constraintWithItem:self.txtRemark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtRemark attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelDescription attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtRemark attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.btnSend addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSend attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*4/5]];
    [self.btnSend addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSend attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSend attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtRemark attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSend attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
}

#pragma mark =====================================================  UITextView 协议实现
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.txtRemark.text isEqualToString:@"请输入您的反馈意见"])
        self.txtRemark.text  = @"";
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([self.txtRemark.text isEqualToString:@""])
        self.txtRemark.text  = @"请输入您的反馈意见";
}

#pragma mark =====================================================  私有方法
-(BOOL)checkForm{
    if([self.txtRemark.text isEqualToString:@"请输入您的反馈意见"]|| [self.txtRemark.text isEqualToString:@""]){
        [self alertHUD:@"请输入反馈意见"];
        return NO;
    }
    return YES;
}

#pragma mark =====================================================  SEL
-(IBAction)btnSendTouch:(id)sender{
    
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable)
        if ([self checkForm]) {
            [self showHUD];
            
            NSDictionary* arg = @{@"ince":@"feedback",@"content":self.txtRemark.text,@"uid":self.Identity.userInfo.userID};
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                if(react == 1){
                    [self hidHUD:@"提交成功!" success:YES complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else if(react == 400){
                    [self hidHUD:message];
                }else{
                     [self hidHUD:@"操作失败"];
                }
            }];
        }
    }];
}




@end
