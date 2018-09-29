//
//  OrderStatus.m
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import "OrderStatus.h"
#import "OrderStatusCell.h"
#import "MapCell.h"
#import "MOrderStatus.h"
#import "MapAnnotation.h"

@interface OrderStatus ()<OrderStatusCellDelegate>

@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,strong) NSString* cellIdentifier;
@property(nonatomic,strong) NSString* cellMapIdentifier;
/**
 *  经度
 */
@property(nonatomic,assign) double lng;
/**
 *  维度
 */
@property(nonatomic,assign) double lat;

@end

@implementation OrderStatus

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellIdentifier = @"OrderStatusCell";
    self.cellMapIdentifier =  @"MapCell";
    self.lng = 0.00000000;
    self.lat = 0.00000000;
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


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.tableView registerClass:[OrderStatusCell class] forCellReuseIdentifier:self.cellIdentifier];
    [self.tableView registerClass:[MapCell class] forCellReuseIdentifier:self.cellMapIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)layoutConstraints{
    
}

#pragma mark =====================================================  data source
-(void)queryData{
    
    //NSDictionary* arg = @{@"ince":@"get_order_status",@"order_id":self.orderID};
    NSDictionary* arg = @{@"a":@"getOrderStatus",@"order_id":self.orderID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryOrderStatus:arg complete:^(NSInteger react, NSArray *list,NSDictionary* dict, NSString *message) {
        if(react == 1){
            [self.arrayData removeAllObjects];
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
            NSString* strLng = [dict objectForKey: @"lng"];
            NSString* strLat = [dict objectForKey: @"lat"];
            if(![WMHelper isNULLOrnil:strLng]){
                 self.lng = [strLng doubleValue];
            }
            if(![WMHelper isNULLOrnil:strLat]){
                self.lat = [strLat doubleValue];
            }
            
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2  && self.lng>0.0 && self.lat>0.0){
    return 200.f;
    }
    return 70.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2  && self.lng>0.0 && self.lat>0.0){
        MapCell  * cell = [tableView dequeueReusableCellWithIdentifier:self.cellMapIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadAnnotation:self.lat lng:self.lng entity:self.arrayData[indexPath.row]];
        return cell;
    }else{
        OrderStatusCell  * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        cell.entity = self.arrayData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}

#pragma mark =====================================================  <UITableViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        MapAnnotation *controller = [[MapAnnotation alloc]initWith:self.lng lat:self.lat entity:self.arrayData[indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)orderStatusCall:(NSString *)phone{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Localized(@"Whether_call") message:phone delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
    [alert show];
}

#pragma mark =====================================================  <UIAlertViewDelegate>
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"Tel:%@",alertView.message]]];
    }
}

#pragma mark =====================================================  property package
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
