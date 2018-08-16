//
//  FruitInfo.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/21.
//
//

#import "FruitInfo.h"
#import "FruitInfoHeader.h"
#import "Car.h"
#import "WXApi.h"
#import <DTCoreText/DTCoreText.h>
#import <DTCoreText/DTWebVideoView.h>

@interface FruitInfo ()<UMSocialUIDelegate,DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
@property(nonatomic,strong) MGoods* entity;

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) FruitInfoHeader* itemHeader;
@property(nonatomic,strong) UIView* footerView;
@property(nonatomic,strong) DTAttributedTextView* contentView;
@property(nonatomic,strong) UIView* carView;
@property(nonatomic,strong) NSString* htmlStr;
@end

@implementation FruitInfo

-(instancetype)initWithItem:(MGoods *)item{
    self = [super init];
    if(self){
        _entity = item;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSoruce];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.entity.goodsName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.itemHeader = [[FruitInfoHeader alloc]init];
    [self addChildViewController: self.itemHeader];
    self.itemHeader.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2+170.f);
    self.tableView.tableHeaderView = self.itemHeader.view;
    
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [self.footerView addSubview:self.contentView];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.tableView];
    Car* car = [[Car alloc]init];
    [self addChildViewController:car];
    self.carView = car.view;
    [self.view addSubview:self.carView];
}

-(void)layoutConstraints{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.carView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.carView addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.carView addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.carView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint  constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint  constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_food_info_ince",@"fid":self.entity.rowID};
    NetRepositories* response = [[NetRepositories alloc]init];
    [response searchGoods:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MGoods*)obj;
            [self.itemHeader loadData:self.entity complete:^(CGSize size) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.itemHeader.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, size.height+170.f);
                    self.tableView.tableHeaderView = self.itemHeader.view;
                });
            }];
            
            NSString* string =  @"";
            if([WMHelper isEmptyOrNULLOrnil:self.entity.content]){
                string =  @"暂无描述";
            }else{
                string = [self.entity.content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                //string = [WMHelper removeTag:@"p" html:string];
               // NSLog(@"%@",string);
               string= [NSString stringWithFormat: @"<div>%@</div>",string];
            }
            self.htmlStr = string;
            self.contentView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:NO];
            
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.tableView.mj_header endRefreshing];
    }];
    
}

-(void)refreshDataSoruce{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    [self.tableView.mj_header beginRefreshing];
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
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/Mobile/Food/index?id=%@",self.entity.rowID];
    if (platformName==UMShareToWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
        
    }
    else if (platformName==UMShareToWechatSession)
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
    }
    else if (platformName==UMShareToQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
    }
    else if (platformName==UMShareToQzone)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
    }else if (platformName==UMShareToEmail){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }else if (platformName == UMShareToSms){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }
    
}

#pragma mark =====================================================  private method

- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes
{
    // Load HTML data
    NSData *data = [self.htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
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
    
    //[options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}

#pragma mark =====================================================  DTAttributedTextContentViewDelegate

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
    [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
    
    // demonstrate combination with long press
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
    [button addGestureRecognizer:longPress];
    
    return button;
}

- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView didDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context{
    CGRect rect = layoutFrame.frame;
    //NSLog(@"%lf   %lf   %lf  %lf",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    rect =	attributedTextContentView.frame;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, rect.size.height);
        self.tableView.tableFooterView = self.footerView;
        self.contentView.scrollEnabled = NO;
        self.contentView.showsVerticalScrollIndicator = NO;
        
    });
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTVideoTextAttachment class]])
    {
        return nil;
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
            // NOTE: this is a hack, you probably want to use your own image view and touch handling
            // also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
            imageView.userInteractionEnabled = YES;
            
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
            button.GUID = attachment.hyperLinkGUID;
            
            // use normal push action for opening URL
            [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
            
            // demonstrate combination with long press
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
            [button addGestureRecognizer:longPress];
            
            [imageView addSubview:button];
        }
        
        return imageView;
    }
    else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
    {
        DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
        videoView.attachment = attachment;
        
        return videoView;
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


#pragma mark Actions

- (void)linkPushed:(DTLinkButton *)button
{
    NSURL *URL = button.URL;
    
    if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
    {
        [[UIApplication sharedApplication] openURL:[URL absoluteURL]];
    }
    else
    {
        if (![URL host] && ![URL path])
        {
            
            // possibly a local anchor link
            NSString *fragment = [URL fragment];
            
            if (fragment)
            {
                [self.contentView scrollToAnchorNamed:fragment animated:NO];
            }
        }
    }
}

- (void)linkLongPressed:(UILongPressGestureRecognizer *)gesture
{
    
}

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    
}

- (void)debugButton:(UIBarButtonItem *)sender
{
    [DTCoreTextLayoutFrame setShouldDrawDebugFrames:![DTCoreTextLayoutFrame shouldDrawDebugFrames]];
    [self.contentView.attributedTextContentView setNeedsDisplay];
}


#pragma mark =====================================================  DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    
    BOOL didUpdate = NO;
    
    // update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [self.contentView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
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
        [self.contentView relayoutText];
    }
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
    [UMSocialData defaultData].extConfig.title = self.entity.goodsName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
}


#pragma mark =====================================================  property package

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIView *)footerView{
    if(!_footerView){
        _footerView = [[UIView alloc]init];
    }
    return _footerView;
}
-(DTAttributedTextView *)contentView{
    if(!_contentView){
        _contentView = [[DTAttributedTextView alloc]init];
        _contentView.shouldDrawImages = NO;
        _contentView.shouldDrawLinks = NO;
        _contentView.textDelegate = self;
        [_contentView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _contentView.contentInset = UIEdgeInsetsMake(5, 10, 0, 10);
    }
    return _contentView;
}

@end
