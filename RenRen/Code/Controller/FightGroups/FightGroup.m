//
//  FightGroup.m
//  KYRR
//
//  Created by kuyuZJ on 16/11/8.
//
//

#import "FightGroup.h"
#import "CustomerCell.h"
#import "TuanCell.h"
#import "GroupBuy.h"
#import "OrderConfirm.h"
#import "WXApi.h"
#import <DTCoreText/DTCoreText.h>


@interface FightGroup ()<DTLazyImageViewDelegate,DTAttributedTextContentViewDelegate,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>
@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,strong) UIScrollView* mainScroll;
@property(nonatomic,strong) NSLayoutConstraint* thumnailConstraint;
@property(nonatomic,strong) UIView* thumbnailView;
@property(nonatomic,strong) UIImageView* imgThumbnail;
@property(nonatomic,strong) UIView* subjectView;
@property(nonatomic,strong) UILabel* labelSubject;
@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIView* tuanView;
@property(nonatomic,strong) UILabel* labelTuan;
@property(nonatomic,strong) NSLayoutConstraint* tuanConstraint;
@property(nonatomic,strong) UITableView* tuanTabelView;
@property(nonatomic,strong) NSLayoutConstraint* ruleConstraint;
@property(nonatomic,strong) UIView* ruleView;
@property(nonatomic,strong) UIImageView* imgRule;
@property(nonatomic,strong) UIView* introductionView;
@property(nonatomic,strong) UILabel* labelIntroduction;
@property(nonatomic,strong) NSLayoutConstraint* descriptionConstraint;
@property(nonatomic,strong) DTAttributedTextView* descriptionView;
@property(nonatomic,strong) UIView* joinView;
@property(nonatomic,strong) UILabel* labelJoin;
@property(nonatomic,strong) NSLayoutConstraint* customerConstraint;
@property(nonatomic,strong) UITableView* customerTableView;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelMarktPrice;
@property(nonatomic,strong) UIButton* btnTuanPrice;

@property(nonatomic,strong) MFightGroupInfo* entity;

@end

static NSString* const customerCellIdentifier =  @"CustomerCell";
static NSString* const tuanCellIdentifier =  @"TuanCell";

@implementation FightGroup{ 
    NSString *html;
    NSInteger subjectHeight;
    NSInteger introductionHeight;
    NSInteger joinHeight;
    NSInteger priceHeight;
    NSInteger tuanHeight;
}

-(instancetype)initWithRowID:(NSString *)rowID{
    self = [super init];
    if(self){
        _rowID = rowID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    subjectHeight = 55;
    introductionHeight = 30;
    joinHeight = 30;
    priceHeight = 50;
    tuanHeight = 40;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScroll];
    
    [self.mainScroll addSubview:self.thumbnailView];
    [self.thumbnailView addSubview:self.imgThumbnail];
    [self.mainScroll addSubview:self.subjectView];
    [self.subjectView addSubview:self.labelSubject];
    [self.mainScroll addSubview:self.priceView];
    [self.priceView addSubview:self.labelPrice];
    [self.priceView addSubview:self.labelSale];
    [self.mainScroll addSubview:self.tuanView];
    [self.tuanView addSubview:self.labelTuan];
    [self.mainScroll addSubview:self.tuanTabelView];
    [self.mainScroll addSubview:self.ruleView];
    [self.ruleView addSubview:self.imgRule];
    [self.mainScroll addSubview:self.introductionView];
    [self.introductionView addSubview:self.labelIntroduction];
    [self.mainScroll addSubview:self.descriptionView];
    [self.mainScroll addSubview:self.joinView];
    [self.joinView addSubview:self.labelJoin];
    [self.mainScroll addSubview:self.customerTableView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelMarktPrice];
    [self.bottomView addSubview:self.btnTuanPrice];
    
    
    NSArray* formats = @[@"H:|-defEdge-[mainScroll]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|", @"V:|-defEdge-[mainScroll][bottomView(==bottomHeight)]-defEdge-|",
                         @"H:|-defEdge-[thumbnailView(==defWidth)]-defEdge-|",@"H:|-defEdge-[subjectView]-defEdge-|",@"H:|-defEdge-[priceView]-defEdge-|",
                         @"H:|-defEdge-[tuanView]-defEdge-|",@"H:|-defEdge-[tuanTableView]-defEdge-|",@"H:|-defEdge-[ruleView]-defEdge-|",@"H:|-defEdge-[introductionView]-defEdge-|",
                         @"H:|-defEdge-[descriptionView]-defEdge-|",@"H:|-defEdge-[joinView]-defEdge-|",@"H:|-defEdge-[customerTableView]-defEdge-|",
                         @"V:|-defEdge-[thumbnailView][subjectView(==subjectHeight)][priceView(==priceHeight)][tuanView(==tuanHeight)][tuanTableView][ruleView][introductionView(==introductionHeight)][descriptionView(>=priceHeight)][joinView(==joinHeight)][customerTableView(>=1)]-defEdge-|",
                         @"H:|-leftEdge-[imgThumbnail]-leftEdge-|", @"V:|-defEdge-[imgThumbnail]-defEdge-|",
                         @"H:|-leftEdge-[labelSubject]-leftEdge-|", @"V:|-defEdge-[labelSubject]-defEdge-|",
                         @"H:|-leftEdge-[labelPrice][labelSale]-leftEdge-|", @"V:|-defEdge-[labelPrice]-defEdge-|", @"V:|-defEdge-[labelSale]-defEdge-|",
                         @"H:|-leftEdge-[labelTuan]-leftEdge-|", @"V:|-defEdge-[labelTuan]-defEdge-|",
                         @"H:|-leftEdge-[imgRule]-leftEdge-|", @"V:|-defEdge-[imgRule]-defEdge-|",
                         @"H:|-leftEdge-[labelIntroduction(==80)]", @"V:|-defEdge-[labelIntroduction]-defEdge-|",
                         @"H:|-leftEdge-[labelJoin]-leftEdge-|", @"V:|-defEdge-[labelJoin]-defEdge-|",
                         @"H:|-defEdge-[labelMarktPrice][btnTuanPrice(labelMarktPrice)]-defEdge-|", @"V:|-defEdge-[labelMarktPrice]-defEdge-|", @"V:|-defEdge-[btnTuanPrice]-defEdge-|",
                         ];
    
    NSDictionary* metrics = @{ @"defEdge":@(0),  @"leftEdge":@(10),@"priceHeight":@(priceHeight), @"introductionHeight":@(introductionHeight),
                               @"joinHeight":@(joinHeight),  @"subjectHeight":@(subjectHeight), @"tuanHeight":@(tuanHeight),@"defWidth":@(SCREEN_WIDTH),
                               @"bottomHeight":@(50)};
    NSDictionary* views =@{  @"mainScroll":self.mainScroll, @"bottomView":self.bottomView,
                             @"thumbnailView":self.thumbnailView, @"subjectView":self.subjectView, @"priceView":self.priceView,
                             @"tuanView":self.tuanView,  @"tuanTableView":self.tuanTabelView,@"ruleView":self.ruleView, @"introductionView":self.introductionView,
                             @"descriptionView":self.descriptionView,@"joinView":self.joinView,@"customerTableView":self.customerTableView,
                             @"imgThumbnail":self.imgThumbnail, @"labelSubject":self.labelSubject, @"labelPrice":self.labelPrice, @"labelSale":self.labelSale,
                             @"labelTuan":self.labelTuan,@"imgRule":self.imgRule, @"labelIntroduction":self.labelIntroduction, @"labelJoin":self.labelJoin,
                             @"labelMarktPrice":self.labelMarktPrice, @"btnTuanPrice":self.btnTuanPrice
                             };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
    [self refreshDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createTuanNotification:) name:NotificationFightGroupCreateTuanSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuanEndNotification:) name:NotificationFightGroupTuanEnd object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrderPayStatusNotification:) name:NotificationChangeOrderPayStatus object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"拼团详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.mainScroll.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchPintuangouVC:@{@"ince":@"get_pintuan_foodinfo",@"fid":self.rowID} complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MFightGroupInfo*)obj;
            
            html = self.entity.fightGroup.goodsContent;
            if(html){
                if(html.length==0){
                    html =  @"暂无描述";
                }
            }else{
                html =  @"暂无描述";
            }
            
                
           
            if(self.entity.arrayCustomer.count>0){
                if(self.customerConstraint){
                    [self.customerTableView removeConstraint:self.customerConstraint];
                }
                self.customerConstraint = [NSLayoutConstraint constraintWithItem:self.customerTableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40*self.entity.arrayCustomer.count];
                self.customerConstraint.priority = 999;
                [self.customerTableView addConstraint:self.customerConstraint];
            }
             
            if(self.entity.arrayTuan.count>0){
                if(self.tuanConstraint){
                    [self.tuanTabelView removeConstraint:self.tuanConstraint];
                }
                self.tuanConstraint = [NSLayoutConstraint constraintWithItem:self.tuanTabelView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50*self.entity.arrayTuan.count];
                self.tuanConstraint.priority = 999;
                [self.tuanTabelView addConstraint:self.tuanConstraint];
            }
            
            [self.imgThumbnail sd_setImageWithURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails] placeholderImage:[[UIImage alloc]init] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGFloat height = image.size.height/image.size.width*(SCREEN_WIDTH-20);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.thumnailConstraint){
                        [self.thumbnailView removeConstraint:self.thumnailConstraint];
                    }
                    self.thumnailConstraint = [NSLayoutConstraint  constraintWithItem:self.thumbnailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
                    self.thumnailConstraint.priority = 999;
                    [self.thumbnailView addConstraint:self.thumnailConstraint];
                });
            }];
            self.descriptionView.attributedString =[self _attributedStringForSnippetUsingiOS6Attributes:NO];
            self.labelSubject.text = self.entity.fightGroup.goodsName;
            
            NSString* strIcon = @"￥";
            NSString* marktPrice = [NSString stringWithFormat:@"￥%@",self.entity.fightGroup.marketPrice];
            NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,self.entity.fightGroup.tuanPrice,marktPrice];
            NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
            [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:self.entity.fightGroup.tuanPrice]];
            [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:marktPrice]];
            [self.labelPrice setAttributedText:attributeStr];
            self.labelSale.text = [NSString stringWithFormat:@"累计销量:%@件",self.entity.fightGroup.goodsSales];
            NSInteger num = [self.entity.fightGroup.pingNum integerValue];
            if(num>1){
                self.labelTuan.text = [NSString stringWithFormat:@"支付开团并邀请%ld人参团，人数不足自动退款",(num-1)];
            }else{
                self.labelTuan.text =@"支付开团并邀请0人参团，人数不足自动退款";
            }
            [self.imgRule sd_setImageWithURL:[NSURL URLWithString:self.entity.tuanInfoPhoto] placeholderImage:[[UIImage alloc]init] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGFloat height = image.size.height/image.size.width*(SCREEN_WIDTH-20);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.ruleConstraint){
                        [self.ruleView removeConstraint:self.ruleConstraint];
                    }
                    self.ruleConstraint = [NSLayoutConstraint  constraintWithItem:self.ruleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
                    self.ruleConstraint.priority = 999;
                    [self.ruleView addConstraint:self.ruleConstraint];
                });
            }];
            
            attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@\n单独购买",self.entity.fightGroup.marketPrice]];
            [self.labelMarktPrice setAttributedText:attributeStr];
            if([self.entity.fightGroup.goodsStock integerValue]>0){
                attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@\n%@人团,我也要开团",self.entity.fightGroup.tuanPrice,self.entity.fightGroup.pingNum]];
                [self.btnTuanPrice setAttributedTitle:attributeStr forState:UIControlStateNormal];
                self.btnTuanPrice.backgroundColor = [UIColor redColor];
                self.btnTuanPrice.userInteractionEnabled = YES;
            }else{
                attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@\n没货啦",self.entity.fightGroup.tuanPrice]];
                self.btnTuanPrice.backgroundColor = [UIColor grayColor];
                [self.btnTuanPrice setAttributedTitle:attributeStr forState:UIControlStateNormal];
                self.btnTuanPrice.userInteractionEnabled = NO;
            }
            [self.tuanTabelView reloadData];
            [self.customerTableView reloadData];
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.mainScroll.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.mainScroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    [self.mainScroll.mj_header beginRefreshing];
}



- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes
{
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
    
    if (useiOS6Attributes)
    {
        [options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
    }
    
    // [options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.customerTableView){
        return   self.entity.arrayCustomer.count;
    }else{
        return   self.entity.arrayTuan.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.customerTableView){
        CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:customerCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.entity = self.entity.arrayCustomer[indexPath.row];
        return cell;
    }else{
        TuanCell *cell = [tableView dequeueReusableCellWithIdentifier:tuanCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.entity = self.entity.arrayTuan[indexPath.row];
        return cell;
    }
}

#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.customerTableView){
        return 40.f;
    }else{
        return 50.f;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tuanTabelView){
        MTuan* item = self.entity.arrayTuan[indexPath.row];
        GroupBuy *controller = [[GroupBuy alloc]initWithRowID:item.rowID];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark =====================================================  <DTAttributedTextContentViewDelegate>

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];
    
    CGColorRef color = [textBlock.backgroundColor CGColor];
    if (color)
    {
        CGContextSetFillColorWithColor(context, color);
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextFillPath(context);
        
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokePath(context);
        return NO;
    }
    
    return YES; // draw standard background
}


- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTVideoTextAttachment class]])
    {
        
    }
    else if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        // if the attachment has a hyperlinkURL then this is currently ignored
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        
        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];
        
        // url for deferred loading
        imageView.url = attachment.contentURL;
        
        // if there is a hyperlink then add a link button on top of this image
        if (attachment.hyperLinkURL)
        {
            imageView.userInteractionEnabled = YES;
            
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
            button.GUID = attachment.hyperLinkGUID;
            
//            // use normal push action for opening URL
//            [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
//            
//            // demonstrate combination with long press
//            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
//            [button addGestureRecognizer:longPress];
//            
//            [imageView addSubview:button];
        }
        
        return imageView;
    }
    else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
    {
        
    }
    else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
    {
        // somecolorparameter has a HTML color
        NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
        UIColor *someColor = DTColorCreateWithHTMLName(colorName);
        
        UIView *someView = [[UIView alloc] initWithFrame:frame];
        someView.backgroundColor = someColor;
        someView.layer.borderWidth = 1;
        someView.layer.borderColor = [UIColor blackColor].CGColor;
        
        someView.accessibilityLabel = colorName;
        someView.isAccessibilityElement = YES;
        
        return someView;
    }
    
    return nil;
}


- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
    NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
    
    NSURL *URL = [attributes objectForKey:DTLinkAttribute];
    NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
    
    
    DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
    button.URL = URL;
    button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
    button.GUID = identifier;
    
    // get image with normal link text
    UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
    [button setImage:normalImage forState:UIControlStateNormal];
    
    // get image for highlighted link text
    UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    
    // use normal push action for opening URL
    //[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
    
    // demonstrate combination with long press
    //    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
    //    [button addGestureRecognizer:longPress];
    
    return button;
}

-(void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView didDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context{
    NSLog( @"==== %s",__FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.descriptionConstraint){
            [self.descriptionView removeConstraint:self.descriptionConstraint];
        }
        self.descriptionConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:layoutFrame.frame.size.height];
        self.descriptionConstraint.priority = 999;
        [self.descriptionView addConstraint:self.descriptionConstraint];
    });
}

#pragma mark - DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    
    BOOL didUpdate = NO;
    
    // update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [self.descriptionView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
    {
        // update attachments that have no original size, that also sets the display size
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
        {
            oneAttachment.originalSize = imageSize;
            
            didUpdate = YES;
        }
    }
    
    if (didUpdate)
    {
        // layout might have changed due to image sizes
        // do it on next run loop because a layout pass might be going on
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.descriptionView relayoutText];
        });
    }
}


#pragma mark =====================================================  <UMSocialUIDelegate>
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        // NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else{
        
    }
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/Mobile/Pintuan/foodinfo?id=%@",self.entity.fightGroup.rowID];
    if (platformName==UMShareToWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
        
    }
    else if (platformName==UMShareToWechatSession)
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
    }
    else if (platformName==UMShareToQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
    }
    else if (platformName==UMShareToQzone)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.fightGroup.thumbnails]]];
        
    }else if (platformName==UMShareToEmail){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }else if (platformName == UMShareToSms){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }
    
}
#pragma mark =====================================================  Notification
-(void)createTuanNotification:(NSNotification*)notification{
    NSString* tuanID = [notification object];
    GroupBuy *controller = [[GroupBuy alloc]initWithRowID:tuanID];
    controller.showShare = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)tuanEndNotification:(NSNotification*)notification{
    MTuan* tuan = (MTuan*)[notification object];
    if(tuan){
        [self.entity.arrayTuan removeObject:tuan];
        [self.tuanTabelView reloadData];
    }
}

-(void)changeOrderPayStatusNotification:(NSNotification*)notification{
    self.tabBarController.selectedIndex = 2;
}

#pragma mark =====================================================  SEL
-(IBAction)shareTouch:(id)sender{
    NSArray* arrayShare = nil;
    if(![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToEmail,UMShareToSms];
    }else  if (![WXApi isWXAppInstalled] && [QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms];
    }else if ([WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms];
    }else{
        arrayShare = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms];
    }
    [UMSocialData defaultData].extConfig.title = self.entity.fightGroup.goodsName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.fightGroup.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
    
}

-(IBAction)openTuanCheckTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
        [self showHUD];
        NSDictionary* arg = @{@"ince":@"pintuan_order_sure_ship_fee",@"fid":self.entity.fightGroup.rowID,@"uid":self.Identity.userInfo.userID,@"tuanid":@""};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories netConfirm:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                MCheckOrder* empty = [[MCheckOrder alloc]initWithFightGroup:obj];
                [self hidHUD:@"" complete:^{
                    OrderConfirm* controller = [[OrderConfirm alloc]initWithItem:empty];
                    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
                    [nav.navigationBar setBackgroundColor:theme_navigation_color];
                    [nav.navigationBar setBarTintColor:theme_navigation_color];
                    [nav.navigationBar setTintColor:theme_default_color];
                    [self presentViewController:nav animated:YES completion:nil];
                }];
            }else{
                [self hidHUD:message complete:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)tuanViewTouch:(UITapGestureRecognizer *)gestureRecognizer{
    NSURL *URL = [NSURL URLWithString:self.entity.tuanInfoUrl];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
}


#pragma mark =====================================================  property package
-(UIScrollView *)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainScroll;
}

-(UIView *)thumbnailView{
    if(!_thumbnailView){
        _thumbnailView = [[UIView alloc]init];
        _thumbnailView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _thumbnailView;
}

-(UIImageView *)imgThumbnail{
    if(!_imgThumbnail){
        _imgThumbnail = [[UIImageView alloc]init];
        _imgThumbnail.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgThumbnail;
}

-(UIView *)subjectView{
    if(!_subjectView){
        _subjectView = [[UIView alloc]init];
        _subjectView.backgroundColor = [UIColor colorWithRed:238/255.f green:239/255.f blue:240/255.f alpha:1.0];
        _subjectView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _subjectView;
}

-(UILabel *)labelSubject{
    if(!_labelSubject){
        _labelSubject = [[UILabel alloc]init];
        _labelSubject.font = [UIFont systemFontOfSize:14.f];
        _labelSubject.numberOfLines = 2;
        _labelSubject.lineBreakMode = NSLineBreakByClipping;
        _labelSubject.textColor = [UIColor colorWithRed:42/255.f green:42/255.f blue:42/255.f alpha:1.0];
        _labelSubject.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSubject;
}

-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
        _priceView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.textColor = [UIColor grayColor];
        _labelSale.font = [UIFont systemFontOfSize:12.f];
        _labelSale.textAlignment = NSTextAlignmentRight;
        _labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSale;
}

-(UIView *)tuanView{
    if(!_tuanView){
        _tuanView = [[UIView alloc]init];
        _tuanView.backgroundColor =[UIColor colorWithRed:238/255.f green:239/255.f blue:240/255.f alpha:1.0];
        _tuanView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tuanView;
}

-(UILabel *)labelTuan{
    if(!_labelTuan){
        _labelTuan = [[UILabel alloc]init];
        _labelTuan.font = [UIFont systemFontOfSize:14.f];
        _labelTuan.textColor = [UIColor grayColor];
        _labelTuan.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTuan;
}

-(UITableView *)tuanTabelView{
    if(!_tuanTabelView){
        _tuanTabelView = [[UITableView alloc]init];
        _tuanTabelView.dataSource = self;
        _tuanTabelView.delegate = self;
        [_tuanTabelView registerClass:[TuanCell class] forCellReuseIdentifier:tuanCellIdentifier];
        _tuanTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tuanTabelView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tuanTabelView;
}


-(UIView *)ruleView{
    if(!_ruleView){
        _ruleView = [[UIView alloc]init];
        _ruleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _ruleView;
}

-(UIImageView *)imgRule{
    if(!_imgRule){
        _imgRule = [[UIImageView alloc]init];
        _imgRule.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tuanViewTouch:)];
        [_imgRule addGestureRecognizer:tap];
        _imgRule.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgRule;
}

-(UIView *)introductionView{
    if(!_introductionView){
        _introductionView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.backgroundColor = theme_line_color.CGColor;
        border.frame = CGRectMake(0, introductionHeight-1, SCREEN_WIDTH, 1.0);
        [_introductionView.layer addSublayer:border];
        _introductionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _introductionView;
}

-(UILabel *)labelIntroduction{
    if(!_labelIntroduction){
        _labelIntroduction = [[UILabel alloc]init];
        _labelIntroduction.text =  @"图文详情";
        _labelIntroduction.textColor = [UIColor grayColor];
        _labelIntroduction.font = [UIFont systemFontOfSize:16.f];
        CALayer* border = [[CALayer alloc]init];
        border.backgroundColor = [UIColor redColor].CGColor;
        border.frame = CGRectMake(0, introductionHeight-3, 70, 3.0);
        [_labelIntroduction.layer addSublayer:border];
        _labelIntroduction.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelIntroduction;
}

-(DTAttributedTextView *)descriptionView{
    if(!_descriptionView){
        _descriptionView = [[DTAttributedTextView alloc]init];
        _descriptionView.textDelegate = self;
        _descriptionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _descriptionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _descriptionView;
}

-(UIView *)joinView{
    if(!_joinView){
        _joinView = [[UIView alloc]init];
        _joinView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _joinView;
}

-(UILabel *)labelJoin{
    if(!_labelJoin){
        _labelJoin = [[UILabel alloc]init];
        _labelJoin.text =  @"已有32人参团成功";
        _labelJoin.textColor = [UIColor grayColor];
        _labelJoin.font = [UIFont systemFontOfSize:14.f];
        _labelJoin.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelJoin;
}

-(UITableView *)customerTableView{
    if(!_customerTableView){
        _customerTableView = [[UITableView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1.0);
        border.backgroundColor = theme_line_color.CGColor;
        [_customerTableView.layer addSublayer:border];
        _customerTableView.dataSource = self;
        _customerTableView.delegate = self;
        [_customerTableView registerClass:[CustomerCell class] forCellReuseIdentifier:customerCellIdentifier];
        _customerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _customerTableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _customerTableView;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = theme_default_color;
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UILabel *)labelMarktPrice{
    if(!_labelMarktPrice){
        _labelMarktPrice = [[UILabel alloc]init];
        _labelMarktPrice.backgroundColor = [UIColor colorWithRed:63/255.f green:38/255.f blue:41/255.f alpha:1.0];
        _labelMarktPrice.textColor = [UIColor whiteColor];
        _labelMarktPrice.textAlignment = NSTextAlignmentCenter;
        _labelMarktPrice.numberOfLines = 0;
        _labelMarktPrice.font = [UIFont systemFontOfSize:14.f];
        _labelMarktPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMarktPrice;
}

-(UIButton *)btnTuanPrice{
    if(!_btnTuanPrice){
        _btnTuanPrice = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTuanPrice.backgroundColor = [UIColor redColor];
        [_btnTuanPrice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnTuanPrice.titleLabel.numberOfLines = 0;
        _btnTuanPrice.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnTuanPrice.titleLabel.textColor = [UIColor whiteColor];
        [_btnTuanPrice addTarget:self action:@selector(openTuanCheckTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnTuanPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnTuanPrice;
}
@end
