//
//  EmptyController.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/26.
//
//

#import "Empty2Controller.h"

@interface Empty2Controller ()
@property(nonatomic,strong) NSArray* arrayData;

@end

static NSString* const cellIdentifier =  @"UITableViewCell";

@implementation Empty2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayData = @[@"American Typewriter",@"AmericanTypewriter",@"AmericanTypewriter-Bold",@"AppleGothic",@"AppleGothic",@"Arial",@"ArialMT",@"Arial-BoldMT",@"Arial-BoldItalicMT",
                       @"Arial-ItalicMT",@"Arial Rounded MT Bold",@"ArialRoundedMTBold",@"Arial Unicode MS",@"ArialUnicodeMS",@"Courier",@"Courier",@"Courier-BoldOblique",
                       @"Courier-Oblique",@"Courier-Bold",@"Courier New",@"CourierNewPS-BoldMT",@"CourierNewPS-ItalicMT",@"CourierNewPS-BoldItalicMT",@"CourierNewPSMT",
                       @"DB LCD Temp",@"DBLCDTempBlack",@"Georgia",@"Georgia-Bold",@"Georgia",@"Georgia-BoldItalic",@"Georgia-Italic",@"Helvetica",@"Helvetica-Oblique",
                       @"Helvetica-BoldOblique",@"Helvetica",@"Helvetica-Bold",@"Helvetica Neue",@"HelveticaNeue",@"HelveticaNeue-Bold",@"Hiragino Kaku Gothic **** W3",
                       @"HiraKakuProN-W3",@"Hiragino Kaku Gothic **** W6",@"HiraKakuProN-W6",@"Marker Felt",@"MarkerFelt-Thin",@"STHeiti J",@"STHeitiJ-Medium",@"STHeitiJ-Light",
                       @"STHeiti K",@"STHeitiK-Medium",@"STHeitiK-Light",@"STHeiti SC",@"STHeitiSC-Medium",@"STHeitiSC-Light",@"STHeiti TC",@"STHeitiTC-Light",@"STHeitiTC-Medium",
                       @"Times New Roman",@"TimesNewRomanPSMT",@"TimesNewRomanPS-BoldMT",@"TimesNewRomanPS-BoldItalicMT",@"TimesNewRomanPS-ItalicMT",@"Trebuchet MS",
                       @"TrebuchetMS-Italic",@"TrebuchetMS",@"Trebuchet-BoldItalic",@"TrebuchetMS-Bold",@"Verdana",@"Verdana-Bold",@"Verdana-BoldItalic",@"Verdana",
                       @"Verdana-Italic",@"Zapfino", @"Zapfino"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UILabel* label = cell.textLabel;
    label.font = [UIFont fontWithName:self.arrayData[indexPath.row] size:11.f];
    label.textColor  = [UIColor colorWithRed:61/255.0 green:61/255.0 blue:61/255.0 alpha:1.0];
    label.text = [NSString stringWithFormat: @"超市鲜果    美食外卖     鲜花蛋糕 %@",self.arrayData[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

@end
