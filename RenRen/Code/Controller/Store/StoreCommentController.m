//
//  StoreCommentController.m
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import "StoreCommentController.h"
#import "StoreCommentCell.h"
#import "StoreCommentV2Cell.h"
#import "MComment.h"

@interface StoreCommentController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UILabel* labelToal;
@property(nonatomic,strong) UILabel* labelFood;
@property(nonatomic,strong) UILabel* labelExpress;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIButton* btnAll;
@property(nonatomic,strong) UIButton* btnBest;
@property(nonatomic,strong) UIButton* btnGood;
@property(nonatomic,strong) UIButton* btnBad;

@property(nonatomic,strong) UILabel* emptyComment;
@property(nonatomic,strong) UILabel* emptyRelyComment;

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NSArray* arrayBtn;
@property(nonatomic,strong) NSString* cellIdentifier;
/**
 *  type(评论类型，0：全部，1：差评，2：中评；3：好评)
 */
@property(nonatomic,strong) NSString* typeID;

@property(nonatomic,strong) NetPage* page;

@property(nonatomic,strong) NSString* storeID;

@end

@implementation StoreCommentController

-(instancetype)initWithStoreID:(NSString *)storeID{
    self = [super init];
    if(self){
        _storeID = storeID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellIdentifier = @"StoreCommentCell";
    self.typeID = @"0";
    
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSString* score =[NSString stringWithFormat:@"%.2f",0.00];
//    NSString* str = [NSString stringWithFormat:@"%@\n总体评价",score];
//    NSMutableAttributedString* attributeStr  = [[NSMutableAttributedString alloc]initWithString:str];
//    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.f],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.f green:159/255.f blue:39/255.f alpha:1.0]} range:[str rangeOfString:score]];
//    self.labelToal.attributedText = attributeStr;
//    self.labelToal.textAlignment = NSTextAlignmentCenter;
//
//    score =[NSString stringWithFormat:@"%.2f",0.00];
//    str = [NSString stringWithFormat:@"%@\n菜品口味",score];
//    attributeStr  = [[NSMutableAttributedString alloc]initWithString:str];
//    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.f],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.f green:159/255.f blue:39/255.f alpha:1.0]} range:[str rangeOfString:score]];
//    self.labelFood.attributedText = attributeStr;
//    self.labelFood.textAlignment = NSTextAlignmentCenter;
//
//    score =[NSString stringWithFormat:@"%.2f",0.00];
//    str = [NSString stringWithFormat:@"%@\n配送服务",score];
//    attributeStr  = [[NSMutableAttributedString alloc]initWithString:str];
//    [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.f],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.f green:159/255.f blue:39/255.f alpha:1.0]} range:[str rangeOfString:score]];
//    self.labelExpress.attributedText = attributeStr;
//    self.labelExpress.textAlignment = NSTextAlignmentCenter;
    
    [self.btnAll setTitle:[NSString stringWithFormat:@"全部(%@)",@"0"] forState:UIControlStateNormal];
//    [self.btnBest setTitle:[NSString stringWithFormat:@"好评(%@)",@"0"] forState:UIControlStateNormal];
    [self.btnGood setTitle:[NSString stringWithFormat:@"好评(%@)",@"0"] forState:UIControlStateNormal];
    [self.btnBad setTitle:[NSString stringWithFormat:@"差评(%@)",@"0"] forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  User interface layout
-(void)layoutUI{
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50.f);
    self.tableView.tableHeaderView  = self.headerView;
    
//    [self.headerView addSubview:self.topView];
    [self.headerView addSubview:self.bottomView];
    
//    [self.topView addSubview:self.labelToal];
//    [self.topView addSubview:self.labelFood];
//    [self.topView addSubview:self.labelExpress];
    
    [self.bottomView addSubview:self.btnAll];
    //[self.bottomView addSubview:self.btnBest];
    [self.bottomView addSubview:self.btnGood];
    [self.bottomView addSubview:self.btnBad];
    
//    self.arrayBtn = @[self.btnAll,self.btnBad,self.btnGood,self.btnBest];
    self.arrayBtn = @[self.btnAll,self.btnBad,self.btnGood];
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[StoreCommentV2Cell class] forCellReuseIdentifier:self.cellIdentifier];
    
}

-(void)layoutConstraints{
//    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.labelToal.translatesAutoresizingMaskIntoConstraints = NO;
//    self.labelFood.translatesAutoresizingMaskIntoConstraints = NO;
//    self.labelExpress.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAll.translatesAutoresizingMaskIntoConstraints = NO;
//    self.btnBest.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnGood.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBad.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
//    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
//    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];

//    [self.labelToal addConstraint:[NSLayoutConstraint constraintWithItem:self.labelToal attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelToal attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelToal attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelToal attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
//
//    [self.labelFood addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFood attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFood attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFood attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelFood attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelToal attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
//
//    [self.labelExpress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
//    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelExpress attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    CGFloat width = (SCREEN_WIDTH-40)/3;
    
    [self.btnAll addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAll attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAll attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAll attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAll attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
//    [self.btnBest addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBest attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
//    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBest attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
//    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBest attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnAll attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
//    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBest attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    [self.btnGood addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGood attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGood attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGood attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnAll attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGood attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    [self.btnBad addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBad attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBad attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBad attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnGood attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBad attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    
    //NSDictionary* arg = @{@"ince":@"get_shop_comment_new",@"sid":self.storeID,@"type":self.typeID, @"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    //NSLog(@"garfunkel_log:type:%@",self.typeID);
    //type 0 全部 3好 2中 1差
    NSDictionary* arg = @{@"a":@"getCommentByStore",@"sid":self.storeID,@"type":self.typeID,};
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryComment:arg page:self.page complete:^(NSInteger react, NSArray *list, id model, NSString *message) {
        if(self.page.pageIndex == 1){
            [self.arrayData removeAllObjects];
        }
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            //  [self alertHUD:message];
        }else{
            //[self alertHUD:message];
        }
        [self loadData:model];
        [self.tableView reloadData];
        if(self.page.pageCount<=self.page.pageIndex){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if(self.page.pageIndex==1){
            [self.tableView.mj_header endRefreshing];
        }
        
    }];
    
    
}
-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page.pageIndex = 1;
        [weakSelf queryData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        weakSelf.page.pageIndex ++;
        [weakSelf queryData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat topHeight=60.f, commentHeight=0.f,replyHeight=0.f,padding = 10;;
    
    MComment* entity = self.arrayData[indexPath.row];
    self.emptyComment.text = entity.comment;
    commentHeight = self.emptyComment.intrinsicContentSize.height;
    entity.commentHeight = commentHeight;
    if(![ WMHelper isEmptyOrNULLOrnil:entity.replyComment]){
        self.emptyRelyComment.text = entity.replyComment;
        replyHeight = self.emptyRelyComment.intrinsicContentSize.height;
        replyHeight+=16.f;
        entity.replyCommentHeight = replyHeight;
    }
    
    return topHeight+commentHeight+replyHeight+padding;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreCommentV2Cell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:@"暂无数据" attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return roundf(self.tableView.frame.size.height/10.0);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  SEL
-(IBAction)changeTypeTouch:(UIButton*)sender{
    self.typeID  = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    sender.selected = YES;
    for (NSInteger i = 0; i<(NSInteger)self.arrayBtn.count; i++) {
        if(i != sender.tag){
            UIButton* btn = (UIButton*)self.arrayBtn[i];
            btn.selected = NO;
        }
    }
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  private method
-(void)loadData:(MOther *)item{
    if(item){
//        NSString* score =[NSString stringWithFormat:@"%.1f",[item.totalComment floatValue]];
//        NSString* str = [NSString stringWithFormat:@"%@\n总体评价",score];
//        NSMutableAttributedString* attributeStr  = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.f],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.f green:159/255.f blue:39/255.f alpha:1.0]} range:[str rangeOfString:score]];
//        self.labelToal.attributedText = attributeStr;
//        self.labelToal.textAlignment = NSTextAlignmentCenter;
//
//        score =[NSString stringWithFormat:@"%.1f",[item.foodComment floatValue]];
//        str = [NSString stringWithFormat:@"%@\n商品评价",score];
//        attributeStr  = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.f],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.f green:159/255.f blue:39/255.f alpha:1.0]} range:[str rangeOfString:score]];
//        self.labelFood.attributedText = attributeStr;
//        self.labelFood.textAlignment = NSTextAlignmentCenter;
//
//        score =[NSString stringWithFormat:@"%.1f",[item.shipComment floatValue]];
//        str = [NSString stringWithFormat:@"%@\n配送服务",score];
//        attributeStr  = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.f],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.f green:159/255.f blue:39/255.f alpha:1.0]} range:[str rangeOfString:score]];
//        self.labelExpress.attributedText = attributeStr;
//        self.labelExpress.textAlignment = NSTextAlignmentCenter;
        
        
        [self.btnAll setTitle:[NSString stringWithFormat:@"全部(%@)",item.totalNum] forState:UIControlStateNormal];
//        [self.btnBest setTitle:[NSString stringWithFormat:@"好评(%@)",item.bestNum] forState:UIControlStateNormal];
        [self.btnGood setTitle:[NSString stringWithFormat:@"好评(%@)",item.goodNum] forState:UIControlStateNormal];
        [self.btnBad setTitle:[NSString stringWithFormat:@"差评(%@)",item.badNum] forState:UIControlStateNormal];
    }
}

#pragma mark =====================================================  Property package
-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]init];
    }
    return _headerView;
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

-(UILabel *)labelToal{
    if(!_labelToal){
        _labelToal = [[UILabel alloc]init];
        _labelToal.numberOfLines = 0;
        _labelToal.backgroundColor = [UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1.0];
        _labelToal.lineBreakMode = NSLineBreakByCharWrapping;
        _labelToal.font = [UIFont systemFontOfSize:14.f];
        _labelToal.textColor = [UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0];
    }
    return _labelToal;
}

-(UILabel *)labelFood{
    if(!_labelFood){
        _labelFood = [[UILabel alloc]init];
        _labelFood.numberOfLines = 0;
        _labelFood.backgroundColor = [UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1.0];
        _labelFood.lineBreakMode = NSLineBreakByCharWrapping;
        _labelFood.font = [UIFont systemFontOfSize:14.f];
        _labelFood.textColor = [UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0];
    }
    return _labelFood;
}

-(UILabel *)labelExpress{
    if(!_labelExpress){
        _labelExpress = [[UILabel alloc]init];
        _labelExpress.numberOfLines = 0;
        _labelExpress.backgroundColor = [UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1.0];
        _labelExpress.lineBreakMode = NSLineBreakByCharWrapping;
        _labelExpress.font = [UIFont systemFontOfSize:14.f];
        _labelExpress.textColor = [UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0];
    }
    return _labelExpress;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

-(UIButton *)btnAll{
    if(!_btnAll){
        _btnAll  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAll.tag = 0;
        _btnAll.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnAll setBackgroundImage:[UIImage imageNamed:@"icon-comment-default"] forState:UIControlStateNormal];
        [_btnAll setBackgroundImage:[UIImage imageNamed:@"icon-comment-enter"] forState:UIControlStateSelected];
        [_btnAll setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnAll setTitleColor:[UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0] forState:UIControlStateNormal];
        _btnAll.selected = YES;
        [_btnAll addTarget:self action:@selector(changeTypeTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAll;
}

-(UIButton *)btnBest{
    if(!_btnBest){
        _btnBest = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBest.tag = 3;
        _btnBest.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnBest setBackgroundImage:[UIImage imageNamed:@"icon-comment-default"] forState:UIControlStateNormal];
        [_btnBest setBackgroundImage:[UIImage imageNamed:@"icon-comment-enter"] forState:UIControlStateSelected];
        [_btnBest setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnBest setTitleColor:[UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnBest addTarget:self action:@selector(changeTypeTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBest;
}


-(UIButton *)btnGood{
    if(!_btnGood){
        _btnGood = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnGood.tag = 2;
        _btnGood.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnGood setBackgroundImage:[UIImage imageNamed:@"icon-comment-default"] forState:UIControlStateNormal];
        [_btnGood setBackgroundImage:[UIImage imageNamed:@"icon-comment-enter"] forState:UIControlStateSelected];
        [_btnGood setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnGood setTitleColor:[UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnGood addTarget:self action:@selector(changeTypeTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGood;
}

-(UIButton *)btnBad{
    if(!_btnBad){
        _btnBad = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBad.tag = 1;
        _btnBad.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnBad setBackgroundImage:[UIImage imageNamed:@"icon-comment-default"] forState:UIControlStateNormal];
        [_btnBad setBackgroundImage:[UIImage imageNamed:@"icon-comment-enter"] forState:UIControlStateSelected];
        [_btnBad setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnBad setTitleColor:[UIColor colorWithRed:113/255.f green:113/255.f blue:113/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnBad addTarget:self action:@selector(changeTypeTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBad;
}

-(UILabel *)emptyComment{
    if(!_emptyComment){
        _emptyComment = [[UILabel alloc]init];
        _emptyComment.numberOfLines = 0;
        _emptyComment.font =[UIFont systemFontOfSize:14.f];
        _emptyComment.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
        _emptyComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyComment;
}
-(UILabel *)emptyRelyComment{
    if(!_emptyRelyComment){
        _emptyRelyComment = [[UILabel alloc]init];
        _emptyRelyComment.font = [UIFont systemFontOfSize:14.f];
        _emptyRelyComment.numberOfLines = 0;
        _emptyRelyComment.preferredMaxLayoutWidth = SCREEN_WIDTH-40;
        _emptyRelyComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyRelyComment;
}
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

-(NetPage *)page{
    if(!_page){
        _page = [[NetPage alloc]init];
        _page.pageIndex = 1;
    }
    return _page;
}
@end
