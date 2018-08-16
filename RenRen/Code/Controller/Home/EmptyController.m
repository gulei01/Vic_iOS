//
//  EmptyController.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/15.
//
//

#import "EmptyController.h"

@interface EmptyController ()

@property(nonatomic,strong) NSString* address;

@property(nonatomic,strong) UIView* emptyView;
@property(nonatomic,strong) UIImageView* emptyImage;

@end

@implementation EmptyController

-(instancetype)initWithAddress:(NSString *)address{
    self = [super init];
    if(self){
        _address = address;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.address;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.emptyView];
    [self.emptyView addSubview:self.emptyImage];
}

-(void)layoutConstraints{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat heigt = width*10/13;
    
    [self.emptyImage addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.emptyImage addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:heigt]];
    [self.emptyView addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emptyView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.emptyView addConstraint:[NSLayoutConstraint constraintWithItem:self.emptyImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.emptyView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  property package

-(UIView *)emptyView{
    if(!_emptyView){
        _emptyView = [[UIView alloc]init];
        _emptyView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyView;
}

-(UIImageView *)emptyImage{
    if(!_emptyImage){
        _emptyImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-not-stores"]];
        _emptyImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyImage;
}


@end
