//
//  Card.m
//  RenRen
//
//  Created by Garfunkel on 2018/10/18.
//

#import "Card.h"
#import "CardCell.h"
#import "EditCard.h"

@interface Card ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIButton* btnAdd;

@end

@implementation Card

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = Localized(@"Credit_card");
    if(self.fromMe && [self.fromMe integerValue] == 0)
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Localized(@"Cancel_txt") style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
}

-(void)layoutUI{
    self.headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.f)];
    self.headerView.backgroundColor = theme_default_color;
    self.btnAdd  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAdd setTitleColor:theme_title_color forState:UIControlStateNormal];
    [self.btnAdd setTitle:Localized(@"ADD_CREDIT_CARD") forState:UIControlStateNormal];
    self.btnAdd.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [self.btnAdd addTarget:self action:@selector(addCardTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.btnAdd];
    
    CALayer* border = [[CALayer alloc]init];
    border.frame= CGRectMake(0, 39.f, SCREEN_WIDTH, 1.f);
    border.backgroundColor = theme_line_color.CGColor;
    [self.btnAdd.layer addSublayer:border];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.emptyDataSetSource =self;
    self.tableView.emptyDataSetDelegate =self;
    self.tableView.tableHeaderView = self.headerView;
}

-(void)layoutConstraints{
    self.btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

-(void)queryData{
    NSDictionary* arg = @{@"a":@"getUserCard",@"uid":self.Identity.userInfo.userID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            self.arrayData = [response objectForKey:@"info"];
            [self.tableView reloadData];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                [weakSelf queryData];
            }else
                [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
}

-(IBAction)cancelTouch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)addCardTouch:(id)sender{
    EditCard* controller = [[EditCard alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  UITableView 协议实现

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = (CardCell*)[tableView dequeueReusableCellWithIdentifier:@"CardCell"];
    if(!cell)
        cell = [[CardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardCell"];
    
    cell.dict = self.arrayData[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"garfunkel_log:%ld",indexPath.row);
    //if(self.fromMe && [self.fromMe integerValue] == 0)
        [self setDefault:self.arrayData[indexPath.row]];
    //else
        //[self editAddress:self.arrayData[indexPath.row]];
}

//garfunkel add
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 *  左滑cell时出现什么按钮
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:Localized(@"Edit_txt") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        tableView.editing = YES;
        [self.tableView setEditing:YES animated:YES];
        
        [self editAddress:self.arrayData[indexPath.row]];
        // 收回左滑出现的按钮(退出编辑模式)
        //tableView.editing = NO;
    }];
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:Localized(@"Delete_txt") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self delAddress:self.arrayData[indexPath.row]];
        //        [self.arrayData removeObjectAtIndex:indexPath.row];
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return @[action1, action0];
}

-(void)setDefault:(NSDictionary*)dict{
    NSDictionary* arg = @{@"a":@"setDefaultCard",@"uid":self.Identity.userInfo.userID,@"card_id":[dict objectForKey:@"id"]};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            self.arrayData = [response objectForKey:@"info"];
            [self.tableView reloadData];
            if(self.fromMe && [self.fromMe integerValue] == 0)
                [self dismissViewControllerAnimated:YES completion:nil];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
    }];
}

-(void)setFromMe:(NSString *)fromMe{
    if(fromMe){
        _fromMe = fromMe;
    }
}

-(void)editAddress:(NSDictionary*)dict{
    EditCard* controller = [[EditCard alloc]init];
    controller.dict = dict;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)delAddress:(NSDictionary*)dict{
    [self showHUD];
    NSDictionary* arg = @{@"a":@"delCard",@"uid":self.Identity.userInfo.userID,@"card_id":[dict objectForKey:@"id"]};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            self.arrayData = [response objectForKey:@"info"];
            [self.tableView reloadData];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
    }];
}

@end
