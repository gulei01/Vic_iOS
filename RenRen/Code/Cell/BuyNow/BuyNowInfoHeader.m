//
//  BuyNowInfoHeader.m
//  DTCoreText
//
//  Created by kyjun on 16/6/14.
//  Copyright © 2016年 Drobnik.com. All rights reserved.
//

#import "BuyNowInfoHeader.h"
#import "ZQCountDownView.h"
#import "Store.h"

typedef void(^contentViewComplete)(CGSize size);

@interface BuyNowInfoHeader ()
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelTitle;

@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UITextField* txtTimer;
@property(nonatomic,strong) UIImageView* leftView;
@property(nonatomic,strong) ZQCountDownView* rightView;
@property(nonatomic,strong) UILabel* labelSale;
@property(nonatomic,strong) UIButton* btnBuy;

@property(nonatomic,strong) UIButton*  btnStore;
@property(nonatomic,strong) UIImageView* arrow;

@property(nonatomic,strong) UIView* descView;
@property(nonatomic,strong) UILabel* labelDesc;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelResult;

@property(nonatomic,copy) NSString* htmlStr;

@property (nonatomic,copy) contentViewComplete  completBlock;

@property(nonatomic,strong) MBuyNow* entity;

@end

@implementation BuyNowInfoHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self layoutUI];
    [self layoutConstraints];
    self.btnBuy.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.photo];
    [self.photo addSubview:self.icon];
    [self.topView addSubview:self.labelTitle];
    [self.topView addSubview:self.priceView];
    [self.priceView addSubview:self.labelPrice];
    [self.priceView addSubview:self.txtTimer];
    [self.priceView addSubview:self.labelSale];
    [self.priceView addSubview:self.btnBuy];
    [self.topView addSubview:self.btnStore];
    [self.btnStore addSubview:self.arrow];
    [self.topView addSubview:self.descView];
    [self.descView addSubview:self.labelDesc];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelResult];
}

-(void)layoutConstraints{
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceView.translatesAutoresizingMaskIntoConstraints =NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtTimer.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSale.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.btnStore.translatesAutoresizingMaskIntoConstraints = NO;
    self.arrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.descView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDesc.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelResult.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat width = SCREEN_WIDTH - 20;
    
    float height = width;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:350.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];
    height = height+40;
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    height = height+60;
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
    [self.txtTimer addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.txtTimer addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:130.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtTimer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.]];
    
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelSale addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSale attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:130.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.txtTimer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.]];
    height = height+30;
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnStore attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnStore attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    height = height+30;
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnStore attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.descView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    [self.descView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.descView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    height = height+30;
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelResult attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}

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

#pragma mark DTAttributedTextContentViewDelegate

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
    NSLog(@"%lf   %lf   %lf  %lf",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    rect =	attributedTextContentView.frame;
    NSLog(@"%lf   %lf   %lf  %lf",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
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


#pragma mark - DTLazyImageViewDelegate

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

-(void)loadData:(MBuyNow *)entity complete:(void (^)(CGSize))complete{
    if(entity){
        _entity = entity;
        NSString* string = [entity.content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        string = [WMHelper removeTag:@"p" html:string];
        NSLog(@"%@",string);
        self.htmlStr = string;
        self.completBlock = complete;
        self.contentView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:NO];
        
        self.labelTitle.text = entity.goodsName;
        NSString* strIcon = @"￥";
        NSString* strPrice = [NSString stringWithFormat:@"￥%@",entity.marketPrice];
        NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,entity.buyNowPrice,strPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.buyNowPrice]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:strPrice]];
        [self.labelPrice setAttributedText:attributeStr];
        
        NSDate* beginDate = [WMHelper convertToDateWithStr:entity.beginDate format:@"yyyy-MM-dd hh:mm:ss"];
        NSLog(@"%@",entity.beginDate);
        NSLog(@"%@",[WMHelper convertToStringWithDate:beginDate format:@"yyyy-MM-dd hh:mm:ss"]);
        NSDate* nowDate = [NSDate date];
        NSTimeInterval beginInterval= [nowDate timeIntervalSinceDate:beginDate];
        NSLog(@"%f",beginInterval);
        NSDate* endData = [WMHelper convertToDateWithStr:entity.endDate format:@"yyyy-MM-dd hh:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];
        NSLog(@"%f",endInterval);
        if(endInterval>=0){
            self.txtTimer.text = @"已结束";
            self.btnBuy.hidden = NO;
            self.btnBuy.userInteractionEnabled = NO;
            self.btnBuy.backgroundColor = [UIColor grayColor];
            [self.btnBuy setTitle:@"已结束" forState:UIControlStateNormal];
            self.rightView.countDownTimeInterval = 0;
        }else{
            if(beginInterval>0){
                self.txtTimer.text = @"距结束";
                self.btnBuy.hidden = NO;
                self.rightView.countDownTimeInterval = -endInterval;
                [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
            }else{
                self.txtTimer.text = @"距开始";
                self.btnBuy.hidden = YES;
                self.rightView.countDownTimeInterval = -beginInterval;
                [NSTimer scheduledTimerWithTimeInterval:-beginInterval target:self selector:@selector(beginBuy) userInfo:nil repeats:NO];
            }
        }
        self.labelSale.text = [NSString stringWithFormat:@"剩%@份",entity.stock];
        [self.btnStore setTitle:entity.storeName forState:UIControlStateNormal];
        str =[NSString stringWithFormat:@"已有%@人秒杀成功",entity.sales];
        attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.sales]];
        self.labelResult.attributedText = attributeStr;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
    }
}

#pragma mark =====================================================  SEL
-(void)beginBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDate* endData = [WMHelper convertToDateWithStr:self.entity.endDate format:@"yyyy-MM-dd hh:mm:ss"];
        NSDate* nowDate = [NSDate date];
        NSTimeInterval secondsInterval= [endData timeIntervalSinceDate:nowDate];
        self.txtTimer.text = @"距结束";
        self.btnBuy.hidden = NO;
        self.rightView.countDownTimeInterval = secondsInterval;
    });
}
-(void)endBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.txtTimer.text = @"已结束";
        self.btnBuy.hidden = NO;
        self.btnBuy.userInteractionEnabled = NO;
        self.btnBuy.backgroundColor = [UIColor grayColor];
        [self.btnBuy setTitle:@"已结束" forState:UIControlStateNormal];
        self.rightView.countDownTimeInterval = 0;
    });
}

-(IBAction)addCarTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
        [self showHUD];
        NSDictionary* arg = @{@"ince":@"addcart",@"fid":self.entity.rowID,@"uid":self.Identity.userInfo.userID,@"num":@"1"};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                [self hidHUD:@"添加成功!"];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshShopCar object:nil];
            }else{
                [self hidHUD:message];
            }
        }];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

-(IBAction)btnStoreTouch:(id)sender{
    Store* controller = [[Store alloc]init];
    MStore* item =[[MStore alloc]init];
    item.rowID =self.entity.storeID;
    controller.entity = item;//self.arrayData[((UIButton*)sender).tag];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

-(UIImageView *)photo{
    if(!_photo){
        _photo =[[UIImageView alloc]init];
        [_photo setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    return _photo;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed:@"icon-buy-icon"]];
    }
    return _icon;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1.0];
        _labelTitle.textColor = [UIColor colorWithRed:81/255.f green:81/255.f blue:81/255.f alpha:1.0];
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
        _labelTitle.numberOfLines = 2;
        _labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _labelTitle;
}

-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
        _priceView.backgroundColor = [UIColor whiteColor];
    }
    return _priceView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
    }
    return _labelPrice;
}

-(UITextField *)txtTimer{
    if(!_txtTimer){
        _txtTimer = [[UITextField alloc]init];
        [_txtTimer setBackgroundColor:[UIColor whiteColor]];
        _txtTimer.textColor = [UIColor redColor];
        _txtTimer.borderStyle=UITextBorderStyleNone;
        _txtTimer.layer.borderColor =[UIColor redColor].CGColor;
        _txtTimer.font = [UIFont systemFontOfSize:12.f];
        _txtTimer.layer.borderWidth = 1.0f;
        _txtTimer.layer.masksToBounds = YES;
        _txtTimer.layer.cornerRadius = 5.f;
        _txtTimer.leftView = self.leftView;
        _txtTimer.leftViewMode =UITextFieldViewModeAlways;
        _txtTimer.rightView = self.rightView;
        _txtTimer.rightViewMode = UITextFieldViewModeAlways;
        [_txtTimer setTextAlignment:NSTextAlignmentCenter];
        _txtTimer.userInteractionEnabled = NO;
    }
    return _txtTimer;
}

-(UIImageView *)leftView{
    if(!_leftView){
        _leftView = [[UIImageView alloc]init];
        _leftView.frame = CGRectMake(0, 0, 20.f, 20.f);
        [_leftView setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    return _leftView;
}

-(ZQCountDownView *)rightView{
    if(!_rightView){
        _rightView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(-10, 0, 66, 20.f)];
        _rightView.themeColor = [UIColor whiteColor];
        _rightView.textColor = [UIColor redColor];
        _rightView.colonColor = [UIColor redColor];
        _rightView.textFont = [UIFont systemFontOfSize:12.f];
    }
    return _rightView;
}

-(UILabel *)labelSale{
    if(!_labelSale){
        _labelSale = [[UILabel alloc]init];
        _labelSale.font = [UIFont systemFontOfSize:12.f];
        _labelSale.textColor = [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1.0];
    }
    return _labelSale;
}

-(UIButton *)btnBuy{
    if(!_btnBuy){
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBuy setBackgroundColor:[UIColor redColor]];
        [_btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBuy setTitle:@"立即抢购" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _btnBuy.layer.masksToBounds = YES;
        _btnBuy.layer.cornerRadius = 5.f;
        [_btnBuy addTarget:self action:@selector(addCarTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBuy;
}

-(UIButton *)btnStore{
    if(!_btnStore){
        _btnStore =[[UIButton alloc]init];
        _btnStore.backgroundColor = [UIColor yellowColor];
        _btnStore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnStore.imageEdgeInsets = UIEdgeInsetsMake(15/2, 10, 15/2, SCREEN_WIDTH-35);
        _btnStore.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btnStore setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        [_btnStore setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        _btnStore.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnStore.backgroundColor = [UIColor whiteColor];
        [_btnStore addTarget:self action:@selector(btnStoreTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnStore;
}

-(UIImageView *)arrow{
    if(!_arrow){
        _arrow = [[UIImageView alloc]init];
        [_arrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    }
    return _arrow;
}

-(UIView *)descView{
    if(!_descView){
        _descView = [[UIView alloc]init];
        _descView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 29.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = [UIColor colorWithRed:227/255.f green:227/255.f blue:227/255.f alpha:1.0].CGColor;
        [_descView.layer addSublayer:border];
    }
    return _descView;
}

-(UILabel *)labelDesc{
    if(!_labelDesc){
        _labelDesc = [[UILabel alloc]init];
        [_labelDesc setText:@"图文详情"];
        _labelDesc.textColor = [UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 28.f, 70.f, 2.f);
        border.backgroundColor = [UIColor redColor].CGColor;
        [_labelDesc.layer addSublayer:border];
        _labelDesc.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelDesc;
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

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)labelResult{
    if(!_labelResult){
        _labelResult = [[UILabel alloc]init];
        _labelResult.textColor = [UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0];         
        _labelResult.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelResult;
}
@end
