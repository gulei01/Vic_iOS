//
//  Address.m
//  KYRR
//
//  Created by kyjun on 15/11/3.
//
//

#import "Address.h"
#import "EditAddress.h"
#import "MAddress.h"
#import "AddressCell.h"
#import "AppDelegate.h"


@interface Address ()<AddressCellDelegate,UIAlertViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIButton* btnAdd;
@property(nonatomic,strong) UIImageView* lineBlock;
@property(nonatomic,strong) UILabel* labelTitle;

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) UIBarButtonItem* leftBarItem;

@property(nonatomic,strong) UIAlertView* alertDefault;
@property(nonatomic,strong) MAddress* emptyItem;
@property(nonatomic,strong) UIAlertView* alertDel;


@end

@implementation Address

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.leftBarButtonItem = self.leftBarItem;
    [self layoutUI];
    [self layoutConstraints];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = Localized(@"Manager_address");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  试图布局
-(void)layoutUI{
    self.headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.f)];
    self.headerView.backgroundColor = theme_default_color;
    self.btnAdd  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAdd setTitleColor:theme_title_color forState:UIControlStateNormal];
    [self.btnAdd setTitle:Localized(@"Add_new_address") forState:UIControlStateNormal];
    self.btnAdd.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [self.btnAdd addTarget:self action:@selector(addAddressTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.btnAdd];
    
    self.lineBlock = [[UIImageView alloc]init];
    self.lineBlock.backgroundColor = theme_line_color;
    [self.headerView addSubview:self.lineBlock];
    
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.text = Localized(@"Historical_address");
    self.labelTitle.font = [UIFont systemFontOfSize:14.f];
    [self.headerView addSubview:self.labelTitle];
    CALayer* border = [[CALayer alloc]init];
    border.frame= CGRectMake(0, 39.f, SCREEN_WIDTH, 1.f);
    border.backgroundColor = theme_line_color.CGColor;
    [self.labelTitle.layer addSublayer:border];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.tableHeaderView = self.headerView;
}

-(void)layoutConstraints{
    self.btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineBlock.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20]];
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.lineBlock addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBlock attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.lineBlock addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBlock attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBlock attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnAdd attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBlock attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineBlock attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
}
#pragma mark =====================================================  数据源
-(void)queryData{
    
    //NSDictionary* arg = @{@"ince":@"get_user_addr_ince",@"uid":self.Identity.userInfo.userID,@"is_default":@"0"};
    NSDictionary* arg = @{@"a":@"getUserAddress",@"uid":self.Identity.userInfo.userID,@"is_default":@"0"};
        NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryAddress:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayData removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
           // [self alertHUD:message];
        }
        [self.tableView reloadData];
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
    AddressCell *cell = (AddressCell*)[tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    if(!cell)
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressCell"];
    
    cell.entity = self.arrayData[indexPath.row];
    [cell disabledDelegate];
    cell.delegate =self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


#pragma mark =====================================================  AddressCell 协议shixian
-(void)setDefaultAddress:(MAddress *)item{
    self.emptyItem = item;
    if(!self.alertDefault)
        self.alertDefault = [[UIAlertView alloc] initWithTitle:nil message:Localized(@"Setting_default_address") delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
    [self.alertDefault show];
    
}
-(void)editAddress:(MAddress *)item{
    EditAddress* controller = [[EditAddress alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)delAddress:(MAddress *)item{
    self.emptyItem = item;
    if(!self.alertDel)
        self.alertDel = [[UIAlertView alloc] initWithTitle:nil message:Localized(@"Want_to_dele") delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
    [self.alertDel show];
    
}
#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:tipEmptyDataTitle attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString:tipEmptyDataDescription attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return roundf(self.tableView.frame.size.height/10.0);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  UIAlertView 协议实现
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == self.alertDefault){
        if (buttonIndex==1){
            [self setDefaultAddress];
        }
    } else if(alertView == self.alertDel){
        if (buttonIndex==1){
            [self delAddress];
        }
    }
}

#pragma mark =====================================================  SEL
-(IBAction)addAddressTouch:(id)sender{
    EditAddress* controller = [[EditAddress alloc]initWithItem:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  私有方法
-(void)setDefaultAddress{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            [self showHUD];
            //NSDictionary* arg = @{@"ince":@"set_default_map",@"uid":self.Identity.userInfo.userID,@"itemid":self.emptyItem.rowID};
            NSDictionary* arg = @{@"a":@"setDefaultAdr",@"uid":self.Identity.userInfo.userID,@"itemid":self.emptyItem.rowID};
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories updateAddres:arg complete:^(NSInteger react, id obj, NSString *message) {
                if(react == 1){
                    [self hidHUD:Localized(@"Success_txt")];
                    [self.tableView.mj_header beginRefreshing];
                }else if(react == 400){
                    [self hidHUD:message];
                }else{
                    [self hidHUD:message];
                }
            }];
        }
    }];
    
}

-(void)delAddress{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            [self showHUD];
            NSDictionary* arg = @{@"a":@"delUserAddress",@"uid":self.Identity.userInfo.userID,@"itemid":self.emptyItem.rowID};
            NetRepositories* repositories = [[NetRepositories alloc]init];
            [repositories updateAddres:arg complete:^(NSInteger react, id obj, NSString *message) {
                if(react == 1){
                    [self hidHUD:Localized(@"Success_txt")];
                    [self.tableView.mj_header beginRefreshing];
                }else if(react == 400){
                    [self hidHUD:message];
                }else{
                    [self hidHUD:message];
                }
            }];
        }
    }];
    
}

#pragma mark =====================================================  属性封装
-(NSMutableArray *)arrayData{
    if(!_arrayData)
        _arrayData = [[NSMutableArray alloc]init];
    return _arrayData;
}

-(UIBarButtonItem *)leftBarItem{
    if(!_leftBarItem){
        UIButton* btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(-200, 0, 44, 44);
        [btn setImage:[UIImage imageNamed: @"icon-back-white"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        _leftBarItem =  [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    return _leftBarItem;
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
