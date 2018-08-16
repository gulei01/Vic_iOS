//
//  PresaleInfoFooter.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/24.
//
//

#import "PresaleInfoFooter.h"
#import "CustomerCell.h"

typedef void(^contentViewComplete)(CGSize size);

@interface PresaleInfoFooter ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIView* resultView;
@property(nonatomic,strong) UILabel* labelResult;

@property(nonatomic,strong) UITableView* subTabelView;

@property(nonatomic,copy) NSString* cellIdentifier;

@property (nonatomic,copy) contentViewComplete  completBlock;

@property(nonatomic,strong) MBuyNow* entity;

@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,copy) NSString* htmlStr;

@end

@implementation PresaleInfoFooter


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellIdentifier = @"CustomerCell";
    
    [self layoutUI];
    [self layoutConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 32);
    [self.headerView addSubview:self.resultView];
    [self.resultView addSubview:self.labelResult];
    [self.headerView addSubview:self.contentView];
    
    self.subTabelView = [[UITableView alloc]init];
    self.subTabelView.delegate = self;
    self.subTabelView.dataSource = self;
    [self.subTabelView registerClass:[CustomerCell class] forCellReuseIdentifier:self.cellIdentifier];
    self.subTabelView.tableHeaderView = self.headerView;
    [self.view addSubview:self.subTabelView];
    self.subTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)layoutConstraints{
    self.resultView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelResult.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.subTabelView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.resultView addConstraint:[NSLayoutConstraint constraintWithItem:self.resultView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.resultView addConstraint:[NSLayoutConstraint constraintWithItem:self.resultView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.resultView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.resultView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelResult addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.resultView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.resultView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.resultView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.resultView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    [self.resultView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.resultView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.resultView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTabelView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTabelView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTabelView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subTabelView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
}


#pragma mark =====================================================  <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return   self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
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
    //NSLog(@"%lf   %lf   %lf  %lf",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30+rect.size.height);
        self.subTabelView.tableHeaderView = self.headerView;
        self.contentView.scrollEnabled = NO;
        self.contentView.showsVerticalScrollIndicator = NO;
    });
    
    if(self.completBlock){
        self.completBlock(rect.size);
    }
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

-(void)loadData:(MBuyNow *)entity array:(NSMutableArray*)arry complete:(void (^)(CGSize))complete{
    if(entity){
        _entity = entity;
        self.arrayData = arry;
        
        self.completBlock = complete;
        
        NSString* str =[NSString stringWithFormat:@"已有%@人预定成功",entity.goodsSales];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.goodsSales]];
        self.labelResult.attributedText = attributeStr;
        
        NSString* string = [entity.goodsContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        string = [WMHelper removeTag:@"p" html:string];
       // NSLog(@"%@",string);
        self.htmlStr = string;
        self.contentView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:NO];
        [self.subTabelView reloadData];
    }
}

#pragma mark =====================================================  property package

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]init];
    }
    return _headerView;
}


-(UIView *)resultView{
    if(!_resultView){
        _resultView = [[UIView alloc]init];
        _resultView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 29.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = [UIColor colorWithRed:227/255.f green:227/255.f blue:227/255.f alpha:1.0].CGColor;
        [_resultView.layer addSublayer:border];
    }
    return _resultView;
}

-(UILabel *)labelResult{
    if(!_labelResult){
        _labelResult = [[UILabel alloc]init];
        _labelResult.textColor = [UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0];
        _labelResult.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelResult;
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

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
