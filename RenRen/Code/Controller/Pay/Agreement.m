//
//  Agreement.m
//  RenRen
//
//  Created by Garfunkel on 2018/10/30.
//

#import "Agreement.h"

@interface Agreement ()

@end

@implementation Agreement

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = theme_table_bg_color;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = Localized(@"Agreement_txt");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Localized(@"Cancel_txt") style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
    [self show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelTouch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)show{
//    UIScrollView* scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*6)];
//    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - TabbarSafeBottomMargin - StatusBarAndNavigationBarHeight);
//    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.tableHeaderView = scrollview;
//    
//    NSString *txtpath = [[NSBundle mainBundle] pathForResource:@"agreement" ofType:@"txt"];  //设置需要读取的文本名称路径
//    NSString *txt = [NSString stringWithContentsOfFile:txtpath encoding:NSUTF8StringEncoding error:nil];
//    
//    //把文本写到UILabel控件里
//    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10, scrollview.frame.size.width-10.0*2,scrollview.frame.size.height-10)];
//    contentLabel.backgroundColor = [UIColor clearColor];
//    contentLabel.numberOfLines = 0;
//    contentLabel.font =  [UIFont systemFontOfSize:16];
//    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    contentLabel.text = txt;
//    [scrollview addSubview:contentLabel];
//    
//    [self.view addSubview:scrollview];
}

@end
