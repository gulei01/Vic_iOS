//
//  RandomSaleInfo.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import "RandomSaleInfo.h"
#import "TagTypeCell.h"
#import "RandomSaleInfoHeader.h"
#import "RandomSaleInfoFooter.h"

@interface RandomSaleInfo ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,RandomSaleInfoFooterDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) NSArray* arrayTag;
@property(nonatomic,strong) NSArray* arrayPrice;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIButton* btnCancel;
@property(nonatomic,strong) UIButton* btnOK;

@property(nonatomic,strong) UIPickerView* pickerView;
@property(nonatomic,strong) UITextField* txtMoney;
@property(nonatomic,strong) NSString* type;

@property(nonatomic,assign) NSInteger limitWeight;
@property(nonatomic,assign) NSInteger weight;
@property(nonatomic,strong) NSString* priceID;

@property(nonatomic,strong) NSString* cellRow;
@end

static NSString* const cellIdentfier  = @"TagTypeCell";
static NSString* const headerIdentifier =  @"SectonHeader";
static NSString* const footerIdentifer =  @"SectionFooter";

@implementation RandomSaleInfo

-(instancetype)initWithType:(NSString *)type{
    self = [super init];
    if(self){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellRow =  @"";
    self.view.backgroundColor = theme_line_color;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.btnCancel];
    [self.bottomView addSubview:self.btnOK];
    
    NSArray* formats = @[ @"H:|-defEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|", @"V:|-defEdge-[collectionView]-defEdge-[bottomView(==bottomHeight)]-defEdge-|",
                          @"H:|-defEdge-[btnCancel]-defEdge-[btnOK(btnCancel)]-defEdge-|", @"V:|-defEdge-[btnCancel]-defEdge-|", @"V:|-defEdge-[btnOK]-defEdge-|"
                          ];
    NSDictionary* metrics = @{
                              @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"bottomHeight":@(50), @"cancelWidth":@(SCREEN_WIDTH/2)
                              };
    NSDictionary* views = @{ @"topView":self.topLayoutGuide, @"collectionView":self.collectionView, @"bottomView":self.bottomView, @"btnCancel":self.btnCancel, @"btnOK":self.btnOK};
    
    for (NSString* format in formats) {
        //NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
    
    NSUserDefaults* conf = [NSUserDefaults standardUserDefaults];
    NSDictionary* item = [conf objectForKey:kRandomBuyConfig];
    self.limitWeight = [[item objectForKey: @"weight_limit"]integerValue];
    self.weight = 1;
    
    [self queryData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"商品信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories randomNetConfirm:@{ @"ince": @"get_send_tag", @"Key": @"send"} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            NSDictionary* data = [response objectForKey: @"data"];
            self.arrayTag = [data objectForKey: @"item_type"];
            self.arrayPrice = [data objectForKey: @"price_kind"];
            self.txtMoney.text = [[self.arrayPrice firstObject] objectForKey:@"value"];
            self.priceID = [[self.arrayPrice firstObject] objectForKey: @"setting_id"];
            [self.collectionView reloadData];
        }else{
            [self alertHUD:message];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark =====================================================  <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrayTag.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagTypeCell* cell = (TagTypeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentfier forIndexPath:indexPath];
    cell.tagType = self.arrayTag[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RandomSaleInfoHeader* empty = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        return empty;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        RandomSaleInfoFooter* empty = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifer forIndexPath:indexPath];
        empty.delegate = self;
        self.txtMoney = empty.txtMoney;
        empty.txtMoney.inputView = self.pickerView;
        return empty;
    }
    return nil;
}


#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [WMHelper calculateTextWidth:self.arrayTag[indexPath.row] font:[UIFont systemFontOfSize:14.f]];
    return CGSizeMake(width+20, 30);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_WIDTH, 60);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 120);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark =====================================================  <UICollectionViewDeleate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* str = self.arrayTag[indexPath.row];
    TagTypeCell* cell = (TagTypeCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if(![self.cellRow containsString:str]){
        cell.labelTag.backgroundColor = [UIColor yellowColor];
        self.cellRow = [self.cellRow stringByAppendingString:[NSString stringWithFormat: @"%@,",str]];
    }else{
        cell.labelTag.backgroundColor = [UIColor whiteColor];
        self.cellRow = [self.cellRow stringByReplacingOccurrencesOfString: [NSString stringWithFormat: @"%@,",str] withString: @""];
    }
}


#pragma mark =====================================================  <RandomSaleInfoFooterDelegate>
-(void)addWeight{
    self.weight ++;
}

-(void)subWeight{
    self.weight --;
}


#pragma mark =====================================================  UIPickerView 协议实现

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrayPrice.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *item = self.arrayPrice[row];
    return [item objectForKey:@"value"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *item = self.arrayPrice[row];
    self.txtMoney.text = [item objectForKey:@"value"];
    self.priceID = [item objectForKey: @"setting_id"];
}

#pragma mark =====================================================  SEL
-(IBAction)btnOkTouch:(id)sender{
    if([self checkForm]){
        NSDictionary* empty = @{ @"value":self.txtMoney.text, @"setting_id":self.priceID, @"weight":[WMHelper integerConvertToString:self.weight], @"name":self.cellRow};
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSelectRandomSaleInfo object:empty];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction)btnCancelTouch:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)checkForm{
    self.cellRow = [self.cellRow stringByReplacingOccurrencesOfString: @" " withString: @""];
    if(self.cellRow.length>1){
        return YES;
    }else{
        [self alertHUD: @"商品类别不能为空"];
        return NO;
    }
}

#pragma mark =====================================================  property package
-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout* block = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:block];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[TagTypeCell class] forCellWithReuseIdentifier:cellIdentfier];
        [_collectionView registerClass:[RandomSaleInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [_collectionView registerClass:[RandomSaleInfoFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifer];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_bottomView.layer addSublayer:border];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UIButton *)btnCancel{
    if(!_btnCancel){
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_btnCancel setTitle: @"取消" forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnCancel;
}

-(UIButton *)btnOK{
    if(!_btnOK){
        _btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOK.backgroundColor = [UIColor redColor];
        [_btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnOK setTitle: @"确认" forState:UIControlStateNormal];
        [_btnOK addTarget:self action:@selector(btnOkTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnOK.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnOK;
}

-(UIPickerView *)pickerView{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
