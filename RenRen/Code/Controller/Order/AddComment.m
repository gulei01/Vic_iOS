//
//  AddComment.m
//  KYRR
//
//  Created by kyjun on 16/4/19.
//
//

#import "AddComment.h"
#import "TQStarRatingView.h"
#import "TagTypeCell.h"

@interface AddComment ()<UITextViewDelegate,StarRatingViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UIScrollView* mainScroll;

@property(nonatomic,strong) UIView* timeView;
@property(nonatomic,strong) UILabel* labelTime;
@property(nonatomic,strong) UIButton* btnOnTime;
@property(nonatomic,strong) UIButton* btnTimeOut;

@property(nonatomic,strong) UIControl* scoreView;
@property(nonatomic,strong) UILabel* labelScore;
@property(nonatomic,strong) UILabel* labelTotal;
@property(nonatomic,strong) TQStarRatingView* starTotal;
@property(nonatomic,strong) UILabel* labelFood;
@property(nonatomic,strong) TQStarRatingView* starFood;
@property(nonatomic,strong) UILabel* labelService;
@property(nonatomic,strong) TQStarRatingView* starService;
@property(nonatomic,strong) NSLayoutConstraint* collectionConstraint;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) NSArray* arrayTag;
@property(nonatomic,strong) UIControl* commentView;

@property(nonatomic,strong) UILabel* labelComment;
@property(nonatomic,strong) UITextView* txtComment;
@property(nonatomic,strong) UIButton* btnConfirm;

@property(nonatomic,strong) NSString* mark;
@property(nonatomic,strong) NSString* onTime;
@property(nonatomic,strong) NSString* scoreToal;
@property(nonatomic,strong) NSString* scoreFood;
@property(nonatomic,strong) NSString* scoreService;

@property(nonatomic,strong) NSString* orderID;


@end

static NSString* const cellIdentifier =  @"TagTypeCell";

@implementation AddComment

-(instancetype)initWithOrderID:(NSString *)orderID{
    self = [super init];
    if(self){
        _orderID = orderID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = theme_table_bg_color;
    self.onTime = @"1";
    self.scoreToal = @"5";
    self.scoreFood = @"5";
    self.scoreService = @"5";
    // Do any additional setup after loading the view.
    self.mark = Localized(@"Let_review");
    [self layoutUI];
    self.automaticallyAdjustsScrollViewInsets = YES;
    //[self queryData];
    //UIBarButtonItem* rBtn = [[UIBarButtonItem alloc]initWithTitle:Localized(@"") style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyBoard)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.labelTime.text = Localized(@"Delivery_time");
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  Localized(@"Add_comment");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard{
    NSLog(@"hideKeyBoard");
    [self.view endEditing:YES];
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    UIControl* myView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [myView addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:myView];
    [self.view addSubview:self.btnConfirm];
    [self.mainScroll addSubview:self.timeView];
    [self.timeView addSubview:self.labelTime];
    [self.timeView addSubview:self.btnOnTime];
    [self.timeView addSubview:self.btnTimeOut];
    [self.mainScroll addSubview:self.scoreView];
    [self.scoreView addSubview:self.labelScore];
    [self.scoreView addSubview:self.labelTotal];
    [self.scoreView addSubview:self.starTotal];
    [self.scoreView addSubview:self.labelFood];
    [self.scoreView addSubview:self.starFood];
    [self.scoreView addSubview:self.labelService];
    [self.scoreView addSubview:self.starService];
    [self.mainScroll addSubview:self.collectionView];
    [self.mainScroll addSubview:self.commentView];
    [self.commentView addSubview:self.labelComment];
    [self.commentView addSubview:self.txtComment];
    
    NSArray* formats = @[@"H:|-defEdge-[mainScroll]-defEdge-|",@"H:|-defEdge-[btnConfirm]-defEdge-|", @"V:|-defEdge-[mainScroll][btnConfirm(==bottomHeight)]-bottomMargin-|",
                         @"H:|-defEdge-[timeView(==defWidth)]-defEdge-|",@"H:|-defEdge-[scoreView]-defEdge-|",@"H:|-defEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[commentView]-defEdge-|",
                         @"V:|-defEdge-[timeView(==60)][scoreView(==140)][collectionView][commentView(==150)]-defEdge-|",
                         @"H:|-leftEdge-[labelTime(==titleWidth)][btnOnTime(==150)][btnTimeOut]-leftEdge-|",
                         @"V:|-30-[labelTime]-defEdge-|", @"V:|-30-[btnOnTime]-defEdge-|", @"V:|-30-[btnTimeOut]-defEdge-|",
                         @"H:|-leftEdge-[labelScore]-leftEdge-|",
                         @"H:|-leftEdge-[labelTotal(==titleWidth)]-leftEdge-[starTotal(==125)]",
                         @"H:|-leftEdge-[labelFood(==titleWidth)]-leftEdge-[starFood(==125)]",
                         @"H:|-leftEdge-[labelService(==titleWidth)]-leftEdge-[starService(==125)]",
                         @"V:|-defEdge-[labelScore][labelTotal(labelScore)][labelFood(labelScore)][labelService(labelScore)]-defEdge-|",
                         @"V:[labelScore]-5-[starTotal(starTotal)]-5-[starFood(starTotal)]-5-[starService(starTotal)]-5-|",
                         @"H:|-leftEdge-[labelComment]-leftEdge-|",@"H:|-defEdge-[txtComment]-defEdge-|",
                         @"V:|-defEdge-[labelComment(==lineHeight)][txtComment]-defEdge-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"bottomHeight":@(50), @"bottomMargin":@(TabbarSafeBottomMargin),@"titleWidth":@(120), @"defWidth":@(SCREEN_WIDTH), @"lineHeight":@(30)};
    NSDictionary* views = @{ @"mainScroll":self.mainScroll, @"btnConfirm":self.btnConfirm,
                             @"timeView":self.timeView, @"scoreView":self.scoreView, @"collectionView":self.collectionView, @"commentView":self.commentView,
                             @"labelTime":self.labelTime, @"btnOnTime":self.btnOnTime, @"btnTimeOut":self.btnTimeOut,
                             @"labelScore":self.labelScore, @"labelTotal":self.labelTotal, @"starTotal":self.starTotal, @"labelFood":self.labelFood, @"starFood":self.starFood,
                             @"labelService":self.labelService, @"starService":self.starService,
                             @"labelComment":self.labelComment, @"txtComment":self.txtComment
                             };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       // NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
}

#pragma mark =====================================================  DataSoruce
-(void)queryData{
    [self showHUD];
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories requestPost:@{ @"ince": @"get_comment_option"} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            self.arrayTag = [response objectForKey: @"data"];
            
            NSInteger weights = 30;
            NSInteger row=1;
            CGFloat width = SCREEN_WIDTH-20;
            CGFloat emptyWidth = 0;
            NSInteger maxIndex = self.arrayTag.count -1;
            for (NSInteger i = 0; i<self.arrayTag.count; i++) {
                NSString* str = self.arrayTag[i] ;
                CGFloat empty = [WMHelper calculateTextWidth:str font:[UIFont systemFontOfSize:14.f]];
                emptyWidth =emptyWidth + empty+weights;
                if(emptyWidth == width){
                    if(i == maxIndex){
                    }else{
                        row = row+1;
                        emptyWidth = empty+weights;
                    }
                }else if (emptyWidth>width){
                    row = row+1;
                    emptyWidth = empty+weights;
                }else{
                    if(i == maxIndex){
                        
                    }else{
                        
                    }
                }
            }
            
            CGFloat collectionHeight = row*45;
            
            if(self.collectionConstraint){
                [self.collectionView removeConstraint:self.collectionConstraint];
            }
            self.collectionConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:collectionHeight];
            self.collectionConstraint.priority = 999;
            [self.collectionView addConstraint:self.collectionConstraint];
            
            [self hidHUD];
        }else{
            [self hidHUD:message];
        }
        [self.collectionView reloadData];
    }];
}

#pragma mark =====================================================  <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrayTag.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagTypeCell* cell = (TagTypeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tagType = self.arrayTag[indexPath.row];
    return cell;
}


#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [WMHelper calculateTextWidth:self.arrayTag[indexPath.row] font:[UIFont systemFontOfSize:14.f]];
    return CGSizeMake(width+20, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark =====================================================  <UICollectionViewDeleate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* str = self.arrayTag[indexPath.row];
    
    if([self.txtComment.text isEqualToString:self.mark])
        self.txtComment.text  = @"";
    NSString* text = self.txtComment.text;
    if(![text containsString:str]){
        self.txtComment.text = [text stringByAppendingString:[NSString stringWithFormat: @" %@",str]];
    }else{
        self.txtComment.text = [text stringByReplacingOccurrencesOfString: [NSString stringWithFormat: @" %@",str] withString: @""];
    }
    if([self.txtComment.text isEqualToString:@""])
        self.txtComment.text  = self.mark;
}

#pragma mark =====================================================  UITextView 协议实现
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.txtComment.text isEqualToString:self.mark])
        self.txtComment.text  = @"";
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([self.txtComment.text isEqualToString:@""])
        self.txtComment.text  = self.mark;
}
//输入换行 隐藏键盘
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if([text isEqualToString:@"\n"]){
//        [self.txtComment resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}


#pragma mark =====================================================  <StarRatingViewDelegate>
-(void)starRatingView:(TQStarRatingView *)view score:(float)score{
    if(view == self.starTotal){
        self.scoreToal = [NSString stringWithFormat:@"%0.f",score  ];
    }else if (view == self.starFood){
          self.scoreFood = [NSString stringWithFormat:@"%0.f",score  ];
    }else{
          self.scoreService = [NSString stringWithFormat:@"%0.f",score ];
    }
}

#pragma mark =====================================================  SEL
-(IBAction)confirmTouch:(id)sender{
    if ([self checkForm]) {
        [self showHUD];
        NSDictionary* arg = @{@"a":@"add_comment",@"order_id":self.orderID,@"comment":self.txtComment.text,@"score":self.scoreToal,@"score1":self.scoreFood,@"score2":self.scoreService,@"righttime":self.onTime,@"uid":self.Identity.userInfo.userID};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories updateComment:arg complete:^(NSInteger react, id obj, NSString *message) {
            [self hidHUD];
            if(react == 1){
                [self alertHUD: Localized(@"Success_txt") complete:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];

            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
            }
        }];
    }
    
}

-(IBAction)onTimeTouch:(UIButton*)sender{
    if(sender == self.btnOnTime){
        self.btnOnTime.selected = YES;
        self.btnTimeOut.selected = NO;
        self.onTime = @"1";
    }else{
        self.btnOnTime.selected = NO;
        self.btnTimeOut.selected = YES;
        self.onTime = @"2";
    }
}

#pragma mark =====================================================  private method
-(BOOL)checkForm{
//    if([self.txtComment.text isEqualToString:self.mark]|| self.txtComment.text.length<3){
//        [self alertHUD:Localized(@"Please_enter_three")];
//        return NO;
//    }else
    if (!([self.scoreToal floatValue]>0.f) || !([self.scoreFood floatValue]>0.f) || !([self.scoreService floatValue]>0.f)){
        [self alertHUD:Localized(@"Rating_not_empty")];
        return NO;
    }
    return YES;
}

#pragma mark =====================================================  property package

#pragma mark =====================================================  property package

-(UIScrollView *)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.bounces = YES;
        _mainScroll.pagingEnabled = YES;
        _mainScroll.userInteractionEnabled = YES;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.backgroundColor=theme_table_bg_color;
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainScroll;
}

-(UIView *)timeView{
    if(!_timeView){
        _timeView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        border.backgroundColor = theme_table_bg_color.CGColor;
        [_timeView.layer addSublayer:border];
        _timeView.backgroundColor = [UIColor whiteColor];
        _timeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timeView;
}


-(UILabel *)labelTime{
    if(!_labelTime){
        _labelTime = [[UILabel alloc]init];
        _labelTime.text =  Localized(@"Delivery_time");
        _labelTime.font = [UIFont systemFontOfSize:14.f];
        _labelTime.textColor = [UIColor colorWithRed:67/255.f green:67/255.f blue:67/255.f alpha:1.0];
        _labelTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTime;
}

-(UIButton *)btnOnTime{
    if(!_btnOnTime){
        _btnOnTime = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnOnTime setTitleColor:[UIColor colorWithRed:247/255.f green:157/255.f blue:34/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnOnTime setImage:[UIImage imageNamed:@"icon-ontime-enter"] forState:UIControlStateSelected];
        [_btnOnTime setImage:[UIImage imageNamed:@"icon-ontime-default"] forState:UIControlStateNormal];
        [_btnOnTime setTitle:Localized(@"On_time") forState:UIControlStateNormal];
        [_btnOnTime setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        _btnOnTime.selected = YES;
        [_btnOnTime addTarget:self action:@selector(onTimeTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnOnTime.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnOnTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnOnTime;
}

-(UIButton *)btnTimeOut{
    if(!_btnTimeOut){
        _btnTimeOut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTimeOut setTitleColor:[UIColor colorWithRed:247/255.f green:157/255.f blue:34/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnTimeOut setImage:[UIImage imageNamed:@"icon-ontime-enter"] forState:UIControlStateSelected];
        [_btnTimeOut setImage:[UIImage imageNamed:@"icon-ontime-default"] forState:UIControlStateNormal];
        [_btnTimeOut setTitle:Localized(@"No_on_time") forState:UIControlStateNormal];
        [_btnTimeOut setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [_btnTimeOut addTarget:self action:@selector(onTimeTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnTimeOut.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnTimeOut.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnTimeOut;
}

-(UIControl *)scoreView{
    if(!_scoreView){
        _scoreView = [[UIControl alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        border.backgroundColor = theme_table_bg_color.CGColor;
        [_scoreView.layer addSublayer:border];
        _scoreView.backgroundColor = [UIColor whiteColor];
        _scoreView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scoreView addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scoreView;
}

-(UILabel *)labelScore{
    if(!_labelScore){
        _labelScore = [[UILabel alloc]init];
        _labelScore.textColor = [UIColor colorWithRed:113/255.f green:133/255.f blue:133/255.f alpha:1.0];
        _labelScore.font = [UIFont systemFontOfSize:14.f];
        _labelScore.text = Localized(@"Product_comment");
        _labelScore.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelScore;
}

-(UILabel *)labelTotal{
    if(!_labelTotal){
        _labelTotal = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
        _labelTotal.textColor = [UIColor colorWithRed:67/255.f green:67/255.f blue:67/255.f alpha:1.0];
        _labelTotal.font = [UIFont systemFontOfSize:14.f];
        _labelTotal.text = Localized(@"Total_comment");
        _labelTotal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTotal;
}

-(TQStarRatingView *)starTotal{
    if(!_starTotal){
        _starTotal = [[TQStarRatingView alloc]initWithFrame:CGRectMake(100, 10, 125, 25) numberOfStar:5];
        _starTotal.delegate = self;
        [_starTotal setScore:0.f withAnimation:YES];
        _starTotal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _starTotal;
}

-(UILabel *)labelFood{
    if(!_labelFood){
        _labelFood = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 80, 20)];
        _labelFood.textColor = [UIColor colorWithRed:67/255.f green:67/255.f blue:67/255.f alpha:1.0];
        _labelFood.font = [UIFont systemFontOfSize:14.f];
        _labelFood.text = Localized(@"Product_comment");
        _labelFood.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelFood;
}

-(TQStarRatingView *)starFood{
    if(!_starFood){
        _starFood = [[TQStarRatingView alloc]initWithFrame:CGRectMake(100, 50, 125, 25) numberOfStar:5];
        _starFood.delegate = self;
        [_starFood setScore:0.f withAnimation:YES];
        _starFood.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _starFood;
}

-(UILabel *)labelService{
    if(!_labelService){
        _labelService = [[UILabel alloc]initWithFrame:CGRectMake(10,90, 80, 20)];
        _labelService.textColor = [UIColor colorWithRed:67/255.f green:67/255.f blue:67/255.f alpha:1.0];
        _labelService.font = [UIFont systemFontOfSize:14.f];
        _labelService.text = Localized(@"Delivery_service");
        _labelService.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelService;
}

-(TQStarRatingView *)starService{
    if(!_starService){
        _starService = [[TQStarRatingView alloc]initWithFrame:CGRectMake(100, 90, 125, 25) numberOfStar:5];
        _starService.delegate = self;
        [_starService setScore:0.f withAnimation:YES];
        _starService.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _starService;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TagTypeCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}


-(UIControl *)commentView{
    if(!_commentView){
        _commentView = [[UIControl alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        border.backgroundColor = theme_table_bg_color.CGColor;
        [_commentView.layer addSublayer:border];
        _commentView.backgroundColor = [UIColor whiteColor];
        _commentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_commentView addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentView;
}


-(UILabel *)labelComment{
    if(!_labelComment){
        _labelComment = [[UILabel alloc]init];
        _labelComment.textColor = [UIColor colorWithRed:109/255.f green:109/255.f blue:109/255.f alpha:1.0];
        _labelComment.font = [UIFont systemFontOfSize:14.f];
        _labelComment.text = @"...";
        _labelComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelComment;
}

-(UITextView *)txtComment{
    if(!_txtComment){
        _txtComment = [[UITextView alloc]init];
        _txtComment.text = self.mark;
        _txtComment.delegate =self;
        _txtComment.editable = YES;
        _txtComment.textColor = [UIColor colorWithRed:189/255.f green:189/255.f blue:189/255.f alpha:1.0];
        _txtComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtComment;
}


-(UIButton *)btnConfirm{
    if(!_btnConfirm){
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.backgroundColor =theme_navigation_color;
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnConfirm setTitle:Localized(@"Submit_comment") forState:UIControlStateNormal];
        [_btnConfirm addTarget:self action:@selector(confirmTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnConfirm;
}

@end
