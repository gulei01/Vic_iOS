//
//  FightGroupInfo.m
//  KYRR
//
//  Created by kyjun on 16/6/16.
//
//

#import "FightGroupInfo.h"
#import "CustomerCell.h"
#import "TuanCell.h"
#import "FightGroupInfoHeader.h"
#import "FightGroupDesc.h"
#import "MTuan.h"

@interface FightGroupInfo ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy) NSString* rowID;

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelMarktPrice;
@property(nonatomic,strong) UIButton* btnTuanPrice;
@property(nonatomic,strong) MFightGroupInfo* entity;

@property(nonatomic,copy) NSString* tuanIdentifier;
@property(nonatomic,copy) NSString* tuanHeader;
@property(nonatomic,copy) NSString* customerIdentifier;
@property(nonatomic,copy) NSString* customerHeader;


@end

@implementation FightGroupInfo

-(instancetype)initWithRowID:(NSString *)rowID{
    self = [super init];
    if(self){
        _rowID = rowID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tuanIdentifier = @"TuanCell";
    self.tuanHeader = @"FightGroupDesc";
    self.customerIdentifier = @"CustomerCell";
    self.customerHeader = @"FightGroupInfoHeader";
    
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshSection:) name:NotificationrefReshFightGroupInfoSection object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelMarktPrice];
    [self.bottomView addSubview:self.btnTuanPrice];
}

-(void)layoutConstraints{
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelMarktPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnTuanPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelMarktPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarktPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.btnTuanPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnTuanPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchFightGroups:@{@"ince":@"get_pintuan_foodinfo",@"fid":self.rowID} complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MFightGroupInfo*)obj;
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.entity){
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.entity){
        if(section == 0){
            return  self.entity.arrayTuan.count;
        }else{
            return self.entity.arrayCustomer.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        TuanCell* cell = [tableView dequeueReusableCellWithIdentifier:self.tuanIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:self.customerIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.entity = self.entity.arrayCustomer[indexPath.row];
        return cell;
    }
}


#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 70.f;
    }else{
        return  40.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   if(section == 0){
        if(CGSizeEqualToSize(self.entity.fightGroup.thumbnailsSize, CGSizeZero)){
            return 120+100.f;
        }else{
            return 120+self.entity.fightGroup.thumbnailsSize.height;
        }
    }else{
        if(CGSizeEqualToSize(self.entity.fightGroup.contentSize, CGSizeZero)){
            return 30+200.f;
        }else{
            return 30+self.entity.fightGroup.contentSize.height;
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        FightGroupInfoHeader* empty = (FightGroupInfoHeader*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:self.tuanHeader];
        [empty loadData:self.entity.fightGroup complete:^(CGSize size) {
            dispatch_async(dispatch_get_main_queue(), ^{
                empty.frame = CGRectMake(0, 0,SCREEN_WIDTH, 120+size.height);
               // [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            });
        }];
        return empty;
    }else if (section == 1){
        FightGroupDesc* empty = (FightGroupDesc*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:self.customerHeader];
        [empty loadData:self.entity.fightGroup complete:^(CGSize size) {
            dispatch_async(dispatch_get_main_queue(), ^{
                empty.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30+size.height);
                empty.txtView.scrollEnabled = NO;
               empty.txtView.showsVerticalScrollIndicator = NO;
                 [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            });

        }];
        return empty;
    }
    return  nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

#pragma mark =====================================================  Notification
-(void)refreshSection:(NSNotification*)notification{
    NSIndexSet* indexSet = notification.object;
    //[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
   // [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    //[self.tableView reloadData];
}
#pragma mark =====================================================  property package
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TuanCell class] forCellReuseIdentifier:self.tuanIdentifier];
        [_tableView registerClass:[CustomerCell class] forCellReuseIdentifier:self.customerIdentifier];
        [_tableView registerClass:[FightGroupDesc class] forHeaderFooterViewReuseIdentifier:self.customerHeader];
        [_tableView registerClass:[FightGroupInfoHeader class] forHeaderFooterViewReuseIdentifier:self.tuanHeader];
        
    }
    return _tableView;
}

-(UILabel *)labelMarktPrice{
    if(!_labelMarktPrice){
        _labelMarktPrice = [[UILabel alloc]init];
    }
    return _labelMarktPrice;
}

-(UIButton *)btnTuanPrice{
    if(!_btnTuanPrice){
        _btnTuanPrice = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnTuanPrice;
}
@end

