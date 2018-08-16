//
//  SearchAddress.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/9.
//
//

#import "SearchAddress.h"
#import "EditAddressMapCell.h"

@interface SearchAddress ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong) NSString* cellIdentifier;

@end

@implementation SearchAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellIdentifier =  @"EditAddressMapCell";
    self.tableView.rowHeight = 50.f;
    [self.tableView registerClass:[EditAddressMapCell class] forCellReuseIdentifier:self.cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditAddressMapCell* cell = (EditAddressMapCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    AMapPOI* item = self.arrayResult[indexPath.row];
    [cell loadData:item.name subTitle:item.address];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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


@end
