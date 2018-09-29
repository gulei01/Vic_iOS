//
//  Language.m
//  RenRen
//
//  Created by Garfunkel on 2018/9/25.
//

#import "Language.h"

@interface Language ()
@property(nonatomic,strong) NSDictionary* langArray;
@end

@implementation Language

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = theme_table_bg_color;
    
    self.langArray = @{@"zh-Hans":languageName_zh,@"en":languageName_en};
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = Localized(@"Language");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.langArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    int i = 0;
    for(NSString* lang in self.langArray){
        if(indexPath.row == i){
            cell.textLabel.text = [self.langArray objectForKey:lang];
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"] isEqualToString:lang]){
                cell.textLabel.textColor = [UIColor redColor];
            }else{
                cell.textLabel.textColor = [UIColor grayColor];
            }
        }
        i++;
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self changeLanguage:indexPath.row];
}

-(void)changeLanguage:(NSInteger) row{
    NSInteger i = 0;
    for(NSString* lang in self.langArray){
        if(i == row){
            if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"] isEqualToString:lang]){
                [[NSUserDefaults standardUserDefaults] setObject:lang forKey:@"appLanguage"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        i++;
    }
    NSLog(@"garfunkel_log:user_language:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
