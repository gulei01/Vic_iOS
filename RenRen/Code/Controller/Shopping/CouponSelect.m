//
//  RedEnvelopes.m
//  KYRR
//
//  Created by kyjun on 15/11/10.
//
//

#import "CouponSelect.h"
#import "RedEnvelopesCell.h"

@interface CouponSelect ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation CouponSelect

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Localized(@"Cancel_txt") style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = Localized(@"My_coupon");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
}
-(void)layoutConstraints{
    
}

-(IBAction)cancelTouch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        nil;//[[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:@""];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1)
        return self.arrayData.count;
    else
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return 40.f;
    else
        return 90.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        RedEnvelopesCell* cell = (RedEnvelopesCell*)[tableView dequeueReusableCellWithIdentifier:@"RedEnvelopesCell"];
        if(!cell)
            cell = [[RedEnvelopesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RedEnvelopesCell"];
        cell.entity = self.arrayData[indexPath.row];
        return cell;
    }else{
        UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        
        UIButton* no_select = [UIButton buttonWithType:UIButtonTypeCustom];
        no_select.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        [no_select setTitle:Localized(@"Donot_use") forState:UIControlStateNormal];
        [no_select setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        [no_select addTarget:self action:@selector(noUse) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:no_select];
        return cell;
    }
}

-(void)noUse{
    NSLog(@"garfunkel_log:onUse");
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCouponReturn object:@"-1"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"garfunkel_log:click_coupon:%ld",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCouponReturn object:[NSString stringWithFormat:@"%ld",indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
