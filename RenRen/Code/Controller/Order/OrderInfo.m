//
//  OrderInfo.m
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import "OrderInfo.h"
#import "OrderDetail.h"
#import "OrderStatus.h"
#import "Feedback.h"
#import "AddComment.h"
#import "MOrderStatus.h"

@interface OrderInfo ()

@property(nonatomic,strong) UIView* menuView;
@property(nonatomic,strong) UIButton* btnExpress;
@property(nonatomic,strong) UIButton* btnDetail;
@property(nonatomic,strong) UILabel* labelSymbol;

@property(nonatomic,strong) UIScrollView* mainScroll;
@property(nonatomic,strong) OrderStatus* expressController;
@property(nonatomic,strong) OrderDetail* detailController;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIButton* btnComplaints;
@property(nonatomic,strong) UIButton* btnComment;

@property(nonatomic,strong) MOrderStatus* orderStatus;

@end

@implementation OrderInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = theme_table_bg_color;
    
    [self layoutUI];
    [self layoutConstraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderStatusNotification:) name:NotificationShowComment object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([self.entity.status isEqualToString:@"3"] || [self.entity.status isEqualToString:@"6"] || [self.entity.status isEqualToString:@"5"]|| [self.entity.status isEqualToString:@"0"]){
        self.bottomView.hidden = YES;
        [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f]];
    }else{
        if(![self.entity.status isEqualToString:@"4"] || [self.entity.isComment isEqualToString:@"2"]){
            [self.btnComplaints addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(SCREEN_WIDTH-30)]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
            self.btnComment.hidden = YES;
            [self.bottomView updateConstraints];
        }else if([self.entity.status isEqualToString:@"4"] && [self.entity.isComment isEqualToString:@"1"]){
            
            [self.btnComment addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:65.f]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
            
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnComment attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10.f]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
            self.btnComment.hidden = NO;
            [self.bottomView updateConstraints];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self.entity.status isEqualToString:@"3"] || [self.entity.status isEqualToString:@"6"] || [self.entity.status isEqualToString:@"5"]|| [self.entity.status isEqualToString:@"0"]){
        self.bottomView.hidden = YES;
        
        self.mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH*2, CGRectGetHeight(self.mainScroll.frame));
    }else{
        self.mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH*2, CGRectGetHeight(self.mainScroll.frame));
        if([self.entity.status isEqualToString:@"4"] && [self.entity.isComment isEqualToString:@"1"]){
            [self changeOption:self.btnDetail];
        }
    }
    self.navigationItem.title = Localized(@"Order_detail");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ===================================================== user interface layout
-(void)layoutUI{
    
    [self.view addSubview:self.menuView];
    [self.menuView addSubview:self.btnExpress];
    [self.menuView addSubview:self.btnDetail];
    [self.menuView addSubview:self.labelSymbol];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.btnComplaints];
    [self.bottomView addSubview:self.btnComment];
    
    [self.view addSubview:self.mainScroll];
    self.detailController = [[OrderDetail alloc]init];
    self.detailController.orderNO = self.orderID;
    self.expressController = [[OrderStatus alloc]init];
    self.expressController.orderID = self.orderID;
    [self addChildViewController:self.detailController];
    [self addChildViewController:self.expressController];
    [self.mainScroll addSubview:self.expressController.view];
    [self.mainScroll addSubview:self.detailController.view];
    
    
}

-(void)layoutConstraints{
    self.menuView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnDetail.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnExpress.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSymbol.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnComplaints.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnComment.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainScroll.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.expressController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.menuView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.menuView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    
    [self.btnExpress addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExpress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExpress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExpress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExpress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnDetail addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDetail attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDetail attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDetail attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDetail attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelSymbol addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSymbol attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.labelSymbol addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSymbol attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:3.f]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSymbol attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.menuView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSymbol attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnComment addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:65.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComment attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnComment attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.mainScroll attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.menuView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.mainScroll attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.mainScroll attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.mainScroll attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.expressController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.expressController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.mainScroll addConstraint:[NSLayoutConstraint constraintWithItem:self.expressController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.mainScroll attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.mainScroll addConstraint:[NSLayoutConstraint constraintWithItem: self.expressController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mainScroll attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.mainScroll addConstraint:[NSLayoutConstraint constraintWithItem:self.expressController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.mainScroll attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.detailController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.detailController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.mainScroll addConstraint:[NSLayoutConstraint constraintWithItem:self.detailController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.mainScroll attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.mainScroll addConstraint:[NSLayoutConstraint constraintWithItem: self.detailController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mainScroll attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.mainScroll addConstraint:[NSLayoutConstraint constraintWithItem:self.detailController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.expressController.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    
}


#pragma mark =====================================================  SEL
-(IBAction)changeOption:(UIButton*)sender{
    if(self.btnDetail == sender){
        self.btnDetail.selected = YES;
        self.btnExpress.selected = NO;
    }else{
        self.btnDetail.selected = NO;
        self.btnExpress.selected = YES;
    }
    [self changeMarkPosition:sender.tag];
}

-(IBAction)complaintsToutch:(id)sender{
    Feedback* controller = [[Feedback alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

// TODO : 修改评论  
-(IBAction)commentTouch:(id)sender{
    
    AddComment* controller = [[AddComment alloc]initWithOrderID:self.entity.rowID];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  Notificaiton
-(void)orderStatusNotification:(NSNotification*)notification{
    self.orderStatus = notification.object;
    [UIView animateWithDuration:0.5 animations:^{
        if([self.entity.isComment isEqualToString:@"2"]){
            [self.btnComplaints addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(SCREEN_WIDTH-30)]];
            [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnComplaints attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
            self.btnComment.hidden = YES;
        }
        [self.bottomView updateConstraints];
    }];
}

#pragma mark =====================================================  private method
-(void)changeMarkPosition:(NSInteger)tag{
    [UIView animateWithDuration:0.5 animations:^{
        self.labelSymbol.frame = CGRectMake(SCREEN_WIDTH/2*tag, CGRectGetHeight(self.menuView.frame)-3, SCREEN_WIDTH/2, 3.f);
        CGRect arect =CGRectMake(SCREEN_WIDTH*tag, 0, SCREEN_WIDTH, CGRectGetHeight(self.mainScroll.frame));
        [self.mainScroll scrollRectToVisible:arect animated:YES];
    }];
}
#pragma mark =====================================================  property package

-(UIView *)menuView{
    if(!_menuView){
        _menuView = [[UIView alloc]init];
        _menuView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:249/255.f];
    }
    return _menuView;
}

-(UIButton *)btnDetail{
    if(!_btnDetail){
        _btnDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDetail.tag = 1;
        [_btnDetail setTitleColor:theme_navigation_color forState:UIControlStateNormal];
        [_btnDetail setTitle:Localized(@"Order_detail") forState:UIControlStateNormal];
        [_btnDetail addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDetail;
}

-(UIButton *)btnExpress{
    if(!_btnExpress){
        _btnExpress =[UIButton buttonWithType:UIButtonTypeCustom];
        _btnExpress.tag = 0;
        [_btnExpress setTitleColor:theme_navigation_color forState:UIControlStateNormal];
        [_btnExpress setTitle:Localized(@"Order_status") forState:UIControlStateNormal];
        /*  CALayer* border = [[CALayer alloc]init];
         border.frame = CGRectMake(SCREEN_WIDTH/2-1, 10.f, 1.f, 20.f);
         border.backgroundColor = [UIColor colorWithRed:207/255.f green:207/255.f blue:207/255.f alpha:1.0].CGColor;
         [_btnExpress.layer addSublayer:border];*/
        [_btnExpress addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnExpress;
}

-(UILabel *)labelSymbol{
    if(!_labelSymbol){
        _labelSymbol = [[UILabel alloc]init];
        _labelSymbol.backgroundColor = [UIColor colorWithRed:247/255.f green:155/255.f blue:21/255.f alpha:1.0];
    }
    return _labelSymbol;
}

-(UIScrollView *)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.bounces = YES;
        _mainScroll.pagingEnabled = YES;
        _mainScroll.userInteractionEnabled = YES;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.backgroundColor=[UIColor clearColor];
        _mainScroll.scrollEnabled=NO;
    }
    return _mainScroll;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

-(UIButton *)btnComplaints{
    if(!_btnComplaints){
        _btnComplaints = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComplaints.layer.masksToBounds = YES;
        _btnComplaints.layer.cornerRadius = 5.f;
        _btnComplaints.layer.borderColor = [UIColor colorWithRed:207/255.f green:207/255.f blue:207/255.f alpha:1.0].CGColor;
        _btnComplaints.layer.borderWidth = 1.f;
        [_btnComplaints setTitleColor:[UIColor colorWithRed:84/255.f green:84/255.f blue:84/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnComplaints setTitle:Localized(@"Order_complaint") forState:UIControlStateNormal];
        _btnComplaints.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnComplaints addTarget:self action:@selector(complaintsToutch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnComplaints;
}

-(UIButton *)btnComment{
    if(!_btnComment){
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.backgroundColor = [UIColor colorWithRed:247/255.f green:157/255.f blue:34/255.f alpha:1.0];
        _btnComment.layer.masksToBounds = YES;
        _btnComment.layer.cornerRadius = 5.f;
        [_btnComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnComment setTitle:Localized(@"To_comment") forState:UIControlStateNormal];
        _btnComment.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnComment addTarget:self action:@selector(commentTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnComment;
}

@end
