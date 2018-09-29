//
//  StoreInfoController.m
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import "StoreInfoController.h"

@interface StoreInfoController ()<UIAlertViewDelegate>

@property(nonatomic,strong) UIView* headerView;


@property(nonatomic,strong) NSArray* arrayData;
@property(nonatomic,strong) NSString* cellIdentifier;

@end

@implementation StoreInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellIdentifier = @"UITableViewCell";
    
    [self layoutUI];
    [self layoutConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20.f);
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)layoutConstraints{
    
    
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.entity){
        return 4;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    
    UIImageView* icon =[[UIImageView alloc]init];
    icon.frame =CGRectMake(10, 25/2, 20.f, 20.f);
    UILabel* label =[[UILabel alloc]init];
    label.frame =CGRectMake(40.f, 0, SCREEN_WIDTH-50.f, 45.f);
    label.textColor = [UIColor colorWithRed:75/255.f green:75/255.f blue:75/255.f alpha:1.0];
    label.font = [UIFont systemFontOfSize:16.f];
    [cell.contentView addSubview:icon];
    [cell.contentView addSubview:label];
    if(indexPath.row ==0 ){
        [icon setImage:[UIImage imageNamed:@"icon-lock"]];
        NSString* star =[NSString stringWithFormat:@"%ld:00",[self.entity.servicTimeBegin integerValue]/60];
         NSString* end =[NSString stringWithFormat:@"%ld:00",[self.entity.serviceTimerEnd integerValue]/60];
        label.text = [NSString stringWithFormat:@"%@ : %@",Localized(@"Delivery_time"),self.entity.time];
    }else if (indexPath.row == 1){
        [icon setImage:[UIImage imageNamed:@"icon-boll"]];
        label.text = [NSString stringWithFormat:@"%@ : %@",Localized(@"Shop_phone"),[WMHelper isEmptyOrNULLOrnil:self.entity.phone]?self.entity.mobile:self.entity.phone];
        UIButton* btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH-50, 15/2, 30.f, 30.f);
        [btn setImage:[UIImage imageNamed:@"icon-phone"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(callPhoneTouch:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
    }else if (indexPath.row == 2){
        [icon setImage:[UIImage imageNamed:@"icon-loca"]];
        label.numberOfLines = 0;
        label.lineBreakMode =NSLineBreakByCharWrapping;
        label.text = [NSString stringWithFormat:@"%@ : %@",Localized(@"Shop_address"),self.entity.address];
    }else{
        [icon setImage:[UIImage imageNamed:@"icon-word"]];
        label.frame = CGRectMake(40.f, 0, 80.f, 25.f);
        label.text = [NSString stringWithFormat:@"%@ : ",Localized(@"Delivery_service")];
        
        
        UILabel* label1 =[[UILabel alloc]init];
        label1.backgroundColor = [UIColor colorWithRed:247/255.f green:157/255.f blue:34/255.f alpha:1.0];
        label1.textColor =[UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font =[UIFont systemFontOfSize:14.f];
        label1.frame =CGRectMake(CGRectGetMaxX(label.frame), 2, 60, 20.f);
        label1.layer.cornerRadius = 5.f;
        label1.layer.masksToBounds = YES;
        //garfunkel modify
        if(self.entity.send){
            label1.text = Localized(@"Platform_deli");
        }else{
            label1.text = Localized(@"Store_txt");
        }
        UILabel* label2 =[[UILabel alloc]init];
        label2.font =[UIFont systemFontOfSize:14.f];
        label2.frame =CGRectMake(CGRectGetMaxX(label1.frame), 2, 130, 20.f);
        label2.text = Localized(@"High_deli_service");
        
        UILabel* label3 =[[UILabel alloc]init];
        label3.frame =CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(label1.frame)+2, 60, 20.f);
        label3.textColor =[UIColor colorWithRed:66/255. green:191/255.f blue:72/255.f alpha:1.0];
        label3.font =[UIFont systemFontOfSize:14.f];
        label3.layer.cornerRadius = 5.f;
        label3.layer.masksToBounds = YES;
        label3.layer.borderColor =[UIColor colorWithRed:98/255.f green:196/255.f blue:111/255.f alpha:1.0].CGColor;
        label3.layer.borderWidth= 0.5f;
        label3.textAlignment = NSTextAlignmentCenter;
        label3.text = Localized(@"Delivery_fast");
        
        UILabel* label4 =[[UILabel alloc]init];
        label4.frame =CGRectMake(CGRectGetMaxX(label3.frame)+5, CGRectGetMaxY(label1.frame)+2, 60, 20.f);
        label4.textColor =[UIColor colorWithRed:66/255. green:191/255.f blue:72/255.f alpha:1.0];
        label4.font =[UIFont systemFontOfSize:14.f];
        label4.layer.cornerRadius = 5.f;
        label4.layer.masksToBounds = YES;
        label4.layer.borderColor =[UIColor colorWithRed:98/255.f green:196/255.f blue:111/255.f alpha:1.0].CGColor;
        label4.layer.borderWidth = 0.5f;
        label4.textAlignment = NSTextAlignmentCenter;
        label4.text = Localized(@"Arrive_time");
        
        [cell.contentView addSubview:label1];
        [cell.contentView addSubview:label2];
        [cell.contentView addSubview:label3];
        [cell.contentView addSubview:label4];
        
    }
    
    UIImageView* line = [[UIImageView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
    line.frame = CGRectMake(10, 49, SCREEN_WIDTH, 1.0);
    [cell.contentView addSubview:line];
    
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
#pragma mark =====================================================  <UIAlertViewDelegate>
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"Tel:%@",alertView.message]]];
    }
}
#pragma mark =====================================================  SEL
-(IBAction)callPhoneTouch:(UIButton*)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Localized(@"Whether_call") message:[WMHelper isEmptyOrNULLOrnil:self.entity.phone]?self.entity.mobile:self.entity.phone delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
    [alert show];
}

#pragma mark =====================================================  property package
-(void)setEntity:(MStore *)entity{
    if(entity){
        _entity =entity;
        [self.tableView reloadData];
    }
}

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor =[UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1.0];
    }
    return _headerView;
}


@end
