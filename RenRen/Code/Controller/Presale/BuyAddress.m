//
//  BuyAddress.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/10.
//
//

#import "BuyAddress.h"
#import "BuyAddressV2.h"
#import "EditAddressMapCell.h"
#import "MapLocationHeader.h"
#import "MapLocationAddressCell.h"

@interface BuyAddress ()<AMapLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,AMapSearchDelegate,DZNEmptyDataSetSource>
@property(nonatomic,strong) CLLocation* currentLocation;
@property(nonatomic,strong) NSString* keyWords;
@property (nonatomic, strong) AMapSearchAPI *mapSearch;

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong) UISearchDisplayController* dispalyController;
@property(nonatomic,strong) UITableView* addressTableView;

@property(nonatomic,strong) NSString* sectionIdentifier;
@property(nonatomic,strong) NSString* cellIdenterSection0;

@property(nonatomic,strong) NSString* cellResultIdentifier;

@property(nonatomic,strong) NSMutableArray* arraySearch;
@property(nonatomic,strong) NSMutableArray* arrayAddress;

@end

@implementation BuyAddress
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sectionIdentifier =  @"MapLocationHeader";
    self.cellIdenterSection0 =  @"MapLocationCurrentCell";
    
    self.cellResultIdentifier =  @"EditAddressMapCell";
    [self layoutUI];
    [self layoutConstraints];
    [self queryBuyAddress];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"选择购买地址";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.searchBar];
    [self.view addSubview:self.addressTableView];
    
    /*
    self.dispalyController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.dispalyController.delegate = self;
    [self.dispalyController.searchResultsTableView registerClass:[EditAddressMapCell class] forCellReuseIdentifier:self.cellResultIdentifier];
    self.dispalyController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dispalyController.searchResultsDelegate = self;
    self.dispalyController.searchResultsDataSource = self;
    */
}

-(void)layoutConstraints{
    NSArray* formats =@[ @"H:|-0-[topView]-0-|" , @"H:|-0-[addressTableView]-0-|",
                         @"V:[top][topView(==topViewHeight)][addressTableView][bottom]"
                         ];
    
    NSDictionary* metorics = @{ @"topViewHeight":@(44.f),
                                @"searchBarHeight":@(44.f)
                                };
    NSDictionary* views = @{ @"top":self.topLayoutGuide,
                             @"topView":self.topView,
                             @"addressTableView":self.addressTableView,
                             @"bottom":self.bottomLayoutGuide,
                             @"searchBar":self.searchBar
                             };
    
    for (NSString* format in formats) {
       // NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self.view addConstraints:constraints];
    }
    
}

#pragma mark =====================================================  Data Source
-(void)queryBuyAddress{
    NSMutableArray* empty = [FMDBHelper query: @"tableBuyAddress"];
    [self.arrayAddress removeAllObjects];
    if(empty.count>0){
        [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AMapPOI* item = [[AMapPOI alloc]init];
            item.uid = [obj objectForKey: @"rowID"];
            item.name = [obj objectForKey: @"name"];
            item.address = [obj objectForKey: @"address"];
            item.location = [AMapGeoPoint locationWithLatitude:[[obj objectForKey: @"mapLat"] floatValue] longitude:[[obj objectForKey: @"mapLng"] floatValue]];
            [self.arrayAddress addObject:item];
        }];
    }else{
        
    }
    [self.addressTableView reloadData];
}

#pragma mark =====================================================  <UISearchBarDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    BuyAddressV2* controller = [[BuyAddressV2 alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    return NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    [self.arraySearch removeAllObjects];
    self.keyWords = searchText;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar                     // called when cancel button pressed
{
    
}

#pragma mark =====================================================  <UISearchDisplayDelegate>
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString {
   // NSLog( @"shouldReloadTableForSearchString");
    [self queryKeywords];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
   // NSLog( @"shouldReloadTableForSearchScope");
    return YES;
}
#pragma mark =====================================================  <AMapSearchDelegate>
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [self.arraySearch addObject:obj];
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dispalyController.searchResultsTableView reloadData];
    });
}


#pragma mark =====================================================  <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.addressTableView){
        return 1;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.addressTableView){
        return self.arrayAddress.count;
        
    }else if(tableView == self.dispalyController.searchResultsTableView){
        return self.arraySearch.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.addressTableView){
        return 60.f;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        return 50.f;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.addressTableView){
        if(self.arrayAddress.count>0){
            EditAddressMapCell* cell = (EditAddressMapCell*)[tableView dequeueReusableCellWithIdentifier:self.cellResultIdentifier forIndexPath:indexPath];
            AMapPOI* item = self.arrayAddress[indexPath.row];
            [cell loadData:item.name subTitle:item.address];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        return nil;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        EditAddressMapCell* cell = (EditAddressMapCell*)[tableView dequeueReusableCellWithIdentifier:self.cellResultIdentifier forIndexPath:indexPath];
        AMapPOI* item = self.arraySearch[indexPath.row];
        [cell loadData:item.name subTitle:item.address];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView == self.addressTableView){
        MapLocationHeader* header = (MapLocationHeader*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:self.sectionIdentifier];
        
        if(self.arrayAddress.count>0){
            [header loadDataWithTitle: @"收货地址" imageName: @"icon-history"];
            return  header;
        }
        
        return nil;
    }else if (tableView == self.dispalyController.searchResultsTableView){
        return nil;
    }
    return nil;
    
}
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AMapPOI* item = self.arrayAddress[indexPath.row];
        [self.arrayAddress removeObject:item];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self deleteAddress:item.uid];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == self.addressTableView){
        
        return  40.f;
    }
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.addressTableView){
        if(self.arrayAddress.count>0){
            AMapPOI* item = self.arrayAddress[indexPath.row];
            [self saveLocation:item];
        }         
    }else{
        AMapPOI* item = self.arraySearch[indexPath.row];
        [self saveLocation:item];
    }
}
#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString: @"暂无可使用购买地址" attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString: @"请输入关键字搜索你的购买地址" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -roundf(self.addressTableView.frame.size.height/10);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//自己更改城市1
-(void)queryKeywords{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        request.keywords            = self.keyWords;
        request.city                = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedCityName];
        request.types               = @"商务住宅|学校信息|生活服务|公司企业|餐饮服务|购物服务|住宿服务|交通设施服务|娱乐场所|医院类型|银行类型|风景名胜|科教文化服务|汽车服务";
        request.requireExtension    = YES;
        request.offset              = 20;
        //  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。
        request.sortrule            = 0;
        request.cityLimit           = YES;
        request.requireSubPOIs      = YES;
        [self.mapSearch AMapPOIKeywordsSearch:request];
    }];
    
}

-(void)saveLocation:(AMapPOI*)item{
 
    NSMutableArray* empty = [FMDBHelper query: @"tableBuyAddress" where:@"name==?",item.name,nil];
    if(empty.count>0){
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationSelectedBuyAddress object:item];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSDictionary* arg = @{ @"name":item.name, @"address":item.address, @"mapLat":[NSString stringWithFormat: @"%.6f",item.location.latitude],@"mapLng":[NSString stringWithFormat: @"%.6f",item.location.longitude]};
      BOOL flag =   [FMDBHelper insert: @"tableBuyAddress" keyValues:arg];
        if(flag){
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationSelectedBuyAddress object:item];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //NSLog( @"insert fail");
        }
    }
}
-(void)deleteAddress:(NSString*)rowID{
    if( [FMDBHelper remove: @"tableBuyAddress" where: [NSString stringWithFormat:@"rowID=%@",rowID]]){
        
    }else{
       // NSLog( @"shanc shib ");
    }
}

#pragma mark =====================================================  property package

-(AMapSearchAPI *)mapSearch{
    if(!_mapSearch){
        _mapSearch = [[AMapSearchAPI alloc] init];
        _mapSearch.delegate = self;
    }
    return _mapSearch;
}
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.f);
        _searchBar.delegate = self;
        _searchBar.placeholder =  @"请输入购买地址";
        UIImage* searchBarBg = [WMHelper makeImageWithColor:[UIColor whiteColor] width:0.1 height:32.f];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor grayColor];
        searchField.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
        [searchField setValue:[UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5.f;
    }
    return _searchBar;
}

-(UITableView *)addressTableView{
    if(!_addressTableView){
        _addressTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _addressTableView.delegate = self;
        _addressTableView.dataSource = self;
        _addressTableView.emptyDataSetSource = self;
        [_addressTableView registerClass:[EditAddressMapCell class] forCellReuseIdentifier:self.cellResultIdentifier];
        [_addressTableView registerClass:[MapLocationHeader class] forHeaderFooterViewReuseIdentifier:self.sectionIdentifier];
        _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _addressTableView.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _addressTableView;
}

-(NSMutableArray *)arraySearch{
    if(!_arraySearch){
        _arraySearch = [[NSMutableArray alloc]init];
    }
    return _arraySearch;
}

-(NSMutableArray *)arrayAddress{
    if(!_arrayAddress){
        _arrayAddress = [[NSMutableArray alloc]init];
    }
    return _arrayAddress;
}

@end
