
//
//  PointGoods.m
//  KYRR
//
//  Created by kyjun on 16/5/10.
//
//

#import "PointGoods.h"
#import "ExchangeRecord.h"


@interface PointGoods ()<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* points;
@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIView* titleView;
@property(nonatomic,strong) UILabel* labelTile;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIButton* btnExchange;
@property(nonatomic,strong) UIView* footerView;
@property(nonatomic,strong) DTAttributedTextView* contentView;

@property(nonatomic,strong) MPoint* entity;
@property(nonatomic,copy) NSString* htmlStr;
@end

@implementation PointGoods

-(instancetype)initWithRowID:(NSString *)rowID andPoints:(NSString *)points{
    self = [super init];
    if(self){
        _rowID = rowID;
        _points = points;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    self.tableView.tableFooterView = self.footerView;
    [self.headerView addSubview:self.photo];
    [self.photo addSubview:self.titleView];
    [self.titleView addSubview:self.labelTile];
    [self.headerView addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelPrice];
    [self.bottomView addSubview:self.icon];
    [self.bottomView addSubview:self.btnExchange];
    [self.footerView addSubview:self.contentView];
}

-(void)layoutConstraints{
    
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTile.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView .translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnExchange.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints =NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.icon addConstraint:[NSLayoutConstraint  constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:75.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnExchange addConstraint:[NSLayoutConstraint  constraintWithItem:self.btnExchange attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.btnExchange addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.titleView addConstraint:[NSLayoutConstraint  constraintWithItem:self.titleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelTile addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelTile attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300.f]];
    [self.labelTile addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTile attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTile attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTile attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint  constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.footerView addConstraint:[NSLayoutConstraint  constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_jifenfood_info",@"jid":self.rowID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories searchPoint:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MPoint*)obj;
            self.labelTile.text = self.entity.goodsName;
            self.labelPrice.text =self.entity.points;
            if([self.entity.stock integerValue]>0){
                self.btnExchange.backgroundColor = theme_navigation_color;
                self.btnExchange.userInteractionEnabled = YES;
                [self.btnExchange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.btnExchange setTitle: @"立即兑换" forState:UIControlStateNormal];
            }else{
                self.btnExchange.backgroundColor = [UIColor grayColor];
                self.btnExchange.userInteractionEnabled = NO;
                [self.btnExchange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.btnExchange setTitle: @"库存不足" forState:UIControlStateNormal];
            }
            if([self.points integerValue]< [self.entity.points integerValue]){
                self.btnExchange.backgroundColor = [UIColor grayColor];
                self.btnExchange.userInteractionEnabled = NO;
                [self.btnExchange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.btnExchange setTitle: @"积分不足" forState:UIControlStateNormal];
            }
            [self.photo sd_setImageWithURL:[NSURL URLWithString:self.entity.defaultImg] placeholderImage:[UIImage imageNamed: @"Icon-60"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGFloat width = SCREEN_WIDTH;
                CGFloat height = image.size.height*width/image.size.width;
                self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50+height);
                self.tableView.tableHeaderView = self.headerView;
            }];
            
            NSString* string =  @"";
            if([WMHelper isEmptyOrNULLOrnil:self.entity.content]){
                string =  @"暂无描述";
            }else{
                string = [self.entity.content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                string = [WMHelper removeTag:@"p" html:string];
                string = [WMHelper removeTag:@"div" html:string];
                NSLog(@"%@",string);
            }
            self.htmlStr = string;
            self.contentView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:NO];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    [self.tableView.mj_header beginRefreshing];
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
   // NSLog(@"%lf   %lf   %lf  %lf",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    rect =	attributedTextContentView.frame;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, rect.size.height);
        self.tableView.tableFooterView = self.footerView;
        self.contentView.scrollEnabled = NO;
        self.contentView.showsVerticalScrollIndicator = NO;
        
    });
    
    /*    self.contentView.scrollEnabled = NO;
     self.contentView.showsVerticalScrollIndicator = NO;
     [self.footerView setNeedsUpdateConstraints];*/
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
-(IBAction)exchangeTouch:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要兑换?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1){
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
        [self.view.window addSubview:self.HUD];
        self.HUD.delegate = self;
        self.HUD.minSize = CGSizeMake(135.f, 135.f);
        [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
        self.HUD.labelText = @"正在登录!";
        [self.HUD show:YES];

        NSDictionary* arg = @{ @"ince": @"duihuan", @"uid":self.Identity.userInfo.userID, @"jid":self.entity.rowID};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories exchangeGoods:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
            if(react == 1){
                [self hidHUD: @"兑换成功!" complete:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshPoints object:nil];
                    [self.navigationController pushViewController:[[ExchangeRecord alloc]init] animated:YES];
                }];
            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
            }
            
        }];
    }
}


#pragma mark =====================================================  property package


-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]init];
    }
    return _headerView;
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}

-(UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor = [UIColor blackColor];
        _titleView.alpha = 0.7f;
    }
    return _titleView;
}

-(UILabel *)labelTile{
    if(!_labelTile){
        _labelTile   = [[UILabel alloc]init];
        _labelTile.textColor = [UIColor whiteColor];
        _labelTile.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelTile;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 48.f, SCREEN_WIDTH, 2.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_bottomView.layer addSublayer:border];
    }
    return _bottomView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = theme_navigation_color;
        _labelPrice.font = [UIFont systemFontOfSize:24.f];
    }
    return _labelPrice;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed: @"icon-point-point"]];
    }
    return _icon;
}

-(UIButton *)btnExchange{
    if(!_btnExchange){
        _btnExchange = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnExchange.backgroundColor = theme_navigation_color;
        _btnExchange.layer.masksToBounds = YES;
        _btnExchange.layer.cornerRadius = 5.f;
        [_btnExchange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnExchange setTitle: @"立即兑换" forState:UIControlStateNormal];
        _btnExchange.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnExchange addTarget:self action:@selector(exchangeTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnExchange;
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
