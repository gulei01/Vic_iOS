//
//  GoodsSpecController.m
//  RenRen
//
//  Created by Garfunkel on 2018/9/16.
//

#import "GoodsSpecController.h"

@interface GoodsSpecController ()

@property(nonatomic,strong)UIView* subView;
@property(nonatomic,strong)UIButton* btnClose;
@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)NSDictionary* list;
@property(nonatomic,strong)NSArray* properties;
@property(nonatomic,strong)NSArray* spec_list;
@property(nonatomic,strong)NSArray* cart_list;

@property(nonatomic,strong)NSString* spec_str;
@property(nonatomic,strong)NSString* proper_str;

@property(nonatomic,strong)UIScrollView* showView;

@property(nonatomic,strong) UIButton* btnAdd;
@property(nonatomic,strong) UILabel* addNumLabel;
@property(nonatomic,strong) UIButton* btnSub;

@property(nonatomic,strong)UILabel* priceLabel;
@property(nonatomic,strong)UIButton* btnAddCart;

@end

@implementation GoodsSpecController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [self.view addGestureRecognizer:tapGesture];
    [self.view addSubview:self.subView];
    
    [self layoutUI];
    [self loadData];
    
    self.spec_str = @"";
    self.proper_str = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:NotificationUpdateSpecList object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithItem:(MGoods *)entity{
    self = [super init];
    if(self){
        self.entity = entity;
    }
    return self;
}

-(UIButton *)mainBtn:(UIButton *)btn{
    if(!_mainBtn){
        _mainBtn = btn;
    }
    
    return _mainBtn;
}

-(void)layoutUI{
    [self.subView addSubview:self.btnClose];
    [self.subView addSubview:self.titleLabel];
    
    [self.subView addSubview:self.showView];
    
    [self.subView addSubview:self.priceLabel];
    [self.subView addSubview:self.btnAddCart];
    
    [self.subView addSubview:self.btnSub];
    [self.subView addSubview:self.addNumLabel];
    [self.subView addSubview:self.btnAdd];
    
    //self.btnAddCart.hidden = YES;
    self.btnSub.hidden = YES;
    self.btnAdd.hidden = YES;
    self.addNumLabel.hidden = YES;
    
    NSArray* formats = @[@"H:[btnClose(==20)]-10-|",@"V:|-10-[btnClose(==20)]",@"H:|-5-[titleLabel]-5-|",@"V:|-10-[titleLabel(==20)]"
                         ,@"H:|-10-[priceLabel(==200)]",@"V:[priceLabel(==40)]-10-|",@"H:[btnAddCart(==100)]-10-|",@"V:[btnAddCart(==40)]-10-|",
                         @"H:[btnSub(==iconSize)][addNumLabel(==50)][btnAdd(==iconSize)]-padding-|", @"V:[btnAdd(==iconSize)]-paddbot-|",
                         @"V:[btnSub(==iconSize)]-paddbot-|",@"V:[addNumLabel(==iconSize)]-paddbot-|",
                         ];
    
    NSDictionary* metrics = @{ @"defEdge":@(0),@"iconSize":@(25),@"padding":@(15),@"paddbot":@(18)};
    
    NSDictionary* views = @{@"btnClose":self.btnClose,@"titleLabel":self.titleLabel,@"priceLabel":self.priceLabel,@"btnAddCart":self.btnAddCart,@"btnSub":self.btnSub,@"addNumLabel":self.addNumLabel,@"btnAdd":self.btnAdd};
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.subView addConstraints:constraints];
    }];
}

-(void) loadData{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.minSize = CGSizeMake(135.f, 135.f);
    [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
    
    [self.HUD show:YES];
    
    [self.specBtn removeAllObjects];
    [self.proBtn removeAllObjects];
    
    NSDictionary* arg = @{@"a":@"getGoodsSpec",@"fid":_entity.rowID,@"uid":self.Identity.userInfo.userID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message){
        if(react == 1){
            [self hidHUD];
            [self showDataUi:response];
        }else if(react == 400){
            [self hidHUD:message];
        }else{
            [self hidHUD:message];
        }
    }];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view removeFromSuperview];
//}
-(void)setEntity:(MGoods *)entity{
    _entity = entity;
    //NSLog(@"garfunkel_log:id:%@",_entity.rowID);
}
-(void)closeView{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

-(IBAction)selectSpec:(UIButton *)button{
//    NSLog(@"garfunkel_log:tag - %d",button.tag);
    NSString* index = objc_getAssociatedObject(button, @"index");
    for(UIButton* btn in [self.specBtn objectForKey:index]){
        btn.selected = NO;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
    button.selected = YES;
    button.layer.borderColor = [UIColor redColor].CGColor;
    
    for(NSDictionary* dict in self.spec_list){
        if ([[dict objectForKey:@"id"] isEqualToString:index]) {
            NSString* name = [[[dict objectForKey:@"list"] objectForKey:[NSString stringWithFormat:@"%ld",(long)button.tag]] objectForKey:@"name"];
            NSLog(@"garfunkel_log:name - %@",name);
        }
    }
    
    [self changePric];
}

-(IBAction)proSelect:(UIButton *)button{
//    NSLog(@"garfunkel_log:ptag - %d",self.proBtn.count);
    NSString* index = objc_getAssociatedObject(button, @"index");
    for(UIButton* btn in [self.proBtn objectForKey:index]){
        btn.selected = NO;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
    button.selected = YES;
    button.layer.borderColor = [UIColor redColor].CGColor;
    
    for(NSDictionary* dict in self.properties){
        if ([[dict objectForKey:@"id"] isEqualToString:index]) {
            NSString* name = [dict objectForKey:@"val"][button.tag - 100];
            NSLog(@"garfunkel_log:pname - %@",name);
        }
    }
    
    [self changePric];
}

-(IBAction)addCart:(UIButton *)btn{
    //NSLog(@"garfunkel_log:addCart%@",self.mainBtn.titleLabel.text);
    [[NSNotificationCenter defaultCenter]postNotificationName:FXLShoppingSelectingBtn object:nil userInfo:@{@"fxlShoppingSelectingBtn":btn}];
    NSString *num = btn.tag == 2 ? @"-1" : @"1";
    if(self.delegate && [self.delegate respondsToSelector:@selector(addToCartOfSpec:num:spec:proper:)]){
        [self.delegate addToCartOfSpec:self.entity num:num spec:self.spec_str proper:self.proper_str];
    }
}

-(NSMutableDictionary *)proBtn{
    if(!_proBtn){
        _proBtn = [[NSMutableDictionary alloc]init];
    }
    return _proBtn;
}

-(NSMutableDictionary *)specBtn{
    if(!_specBtn){
        _specBtn = [[NSMutableDictionary alloc]init];
    }
    return _specBtn;
}

-(NSArray *)spec_list{
    if(!_spec_list){
        _spec_list = [[NSArray alloc]init];
    }
    return _spec_list;
}

-(NSArray *)properties{
    if(!_properties){
        _properties = [[NSArray alloc]init];
    }
    return _properties;
}

-(NSDictionary *)list{
    if(!_list){
        _list = [[NSDictionary alloc]init];
    }
    return _list;
}

-(NSArray *)cart_list{
    if(!_cart_list){
        _cart_list = [[NSArray alloc]init];
    }
    return _cart_list;
}

-(void)changePric{
    if(![WMHelper isNULLOrnil:self.list] && ![self.list isEqual:@""] && self.list.count > 0){
        NSString* spec_string = @"";
        for(NSString* spec_id in self.specBtn){
            NSArray* btnList = [self.specBtn objectForKey:spec_id];
            for(UIButton* btn in btnList){
                if(btn.selected){
                    if([spec_string isEqualToString:@""]){
                        spec_string = [NSString stringWithFormat:@"%ld",(long)btn.tag];
                    }else{
                        spec_string = [NSString stringWithFormat:@"%@_%ld",spec_string,(long)btn.tag];
                    }
                }
            }
        }
        
        self.spec_str = spec_string;
        NSLog(@"garfunkel_log:spec_str:%@",self.spec_str);
        NSString* price = [[self.list objectForKey:spec_string] objectForKey:@"price"];
        float priceNum = [price floatValue];
        self.priceLabel.text = [NSString stringWithFormat:@"$%0.2f",priceNum];
    }
    
    NSString* pro_string = @"";
    for(NSString* pro_id in self.proBtn){
        NSArray* btnList = [self.proBtn objectForKey:pro_id];
        for(UIButton* btn in btnList){
            if(btn.selected){
                if([pro_string isEqualToString:@""]){
                    pro_string = [NSString stringWithFormat:@"%@,%ld",pro_id,(long)btn.tag - 100];
                }else{
                    pro_string = [NSString stringWithFormat:@"%@_%@,%ld",pro_string,pro_id,(long)btn.tag - 100];
                }
            }
        }
    }
    self.proper_str = pro_string;
//    NSLog(@"garfunkel_log:proper:%@",self.proper_str);
    
    //更新显示的按钮样式
    BOOL isC = false;
    NSString* tNum = @"0";
    if(![WMHelper isNULLOrnil:self.cart_list]){
        for(NSDictionary* cart in self.cart_list){
            if([[cart objectForKey:@"proper"] isEqualToString:self.proper_str] && [[cart objectForKey:@"spec"] isEqualToString:self.spec_str])
            {
                isC = true;
                tNum = [cart objectForKey:@"num"];
            }
        }
    }
    
    if(isC){
        self.btnAddCart.hidden = YES;
        self.btnSub.hidden = NO;
        self.btnAdd.hidden = NO;
        self.addNumLabel.hidden = NO;
        
        self.addNumLabel.text = tNum;
    }else{
        self.btnAddCart.hidden = NO;
        self.btnSub.hidden = YES;
        self.btnAdd.hidden = YES;
        self.addNumLabel.hidden = YES;
    }
}

-(void)showDataUi:(NSDictionary *)resp{
    [self.showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.cart_list = [resp objectForKey:@"cart"];
    self.list = [resp objectForKey:@"list"];
    self.spec_list = [resp objectForKey:@"spec_list"];
    
    NSInteger i = 0;
    NSInteger j = 0;
    NSInteger btn_x = 10;
    NSInteger btn_y = 10;
    if(![WMHelper isNULLOrnil:self.spec_list] && ![self.spec_list isEqual:@""]){
        for(NSDictionary* dict in self.spec_list){
            btn_y += 40*i;
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, btn_y, SCREEN_WIDTH*0.8-20, 20)];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.text = [dict objectForKey:@"name"];
            label.textColor = [UIColor grayColor];
            label.adjustsFontSizeToFitWidth = YES;
            [self.showView addSubview:label];
            
            NSMutableArray* array = [[NSMutableArray alloc]init];
            [self.specBtn setObject:array forKey:[dict objectForKey:@"id"]];
            
            NSDictionary* list = [dict objectForKey:@"list"];
            j = 0;
            btn_x = 10;
            btn_y += 30;
            for (NSString* key in list) {
                NSDictionary* specVal = list[key];
                NSInteger sid = [key integerValue];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = sid;
                objc_setAssociatedObject(btn, @"index", [dict objectForKey:@"id"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                NSInteger name_len = [[specVal objectForKey:@"name"] lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
                NSInteger singe_width = 5;
                if([[specVal objectForKey:@"name"] length] == name_len){
                    singe_width = 8;
                }
                NSInteger btn_width = name_len * singe_width + 20;
                if(btn_x + btn_width > SCREEN_WIDTH*0.8 - 20){
                    btn_x = 10;
                    btn_y += 40;
                }
                btn.frame = CGRectMake(btn_x, btn_y, btn_width, 30);
                [btn setTitle:[specVal objectForKey:@"name"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//                [btn.titleLabel sizeToFit];
//                btn.titleLabel.adjustsFontSizeToFitWidth = YES;
                btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
                btn.layer.cornerRadius = 2.0f;
                btn.layer.borderWidth = 1.0;
                if (j == 0) {
                    btn.selected = YES;
                }
                if(btn.selected){
                    btn.layer.borderColor = [UIColor redColor].CGColor;
                }else{
                    btn.layer.borderColor = [UIColor grayColor].CGColor;
                }
                
                [btn addTarget:self action:@selector(selectSpec:) forControlEvents:UIControlEventTouchUpInside];
                [self.showView addSubview:btn];
                [[self.specBtn objectForKey:[dict objectForKey:@"id"]] addObject:btn];
                btn_x += btn_width + 10;
                j++;
            }
            i++;
        }
    }
    
    self.properties = [resp objectForKey:@"properties_list"];
    
    i = 0;
    btn_y = btn_y == 10 ? 10 : btn_y+40;
    if(![WMHelper isNULLOrnil:self.properties]){
        for(NSDictionary* dict in self.properties){
            btn_y += 40*i;
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, btn_y, SCREEN_WIDTH*0.8-20, 20)];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.text = [dict objectForKey:@"name"];
            label.textColor = [UIColor grayColor];
            label.adjustsFontSizeToFitWidth = YES;
            [self.showView addSubview:label];
            
            NSMutableArray* array = [[NSMutableArray alloc]init];
            [self.proBtn setObject:array forKey:[dict objectForKey:@"id"]];
            
            NSArray* val = [dict objectForKey:@"val"];
            j = 0;
            btn_x = 10;
            btn_y += 30;
            for(NSString* name in val){
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                objc_setAssociatedObject(btn, @"index", [dict objectForKey:@"id"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                NSInteger name_len = [name lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
                NSInteger singe_width = 5;
                if(name.length == name_len){
                    singe_width = 8;
                }
                NSInteger btn_width = name_len * singe_width + 20;
                if(btn_x + btn_width > SCREEN_WIDTH*0.8 - 20){
                    btn_x = 10;
                    btn_y += 40;
                }
                btn.frame = CGRectMake(btn_x, btn_y, btn_width, 30);
                btn.tag = 100 + j;
                [btn addTarget:self action:@selector(proSelect:) forControlEvents:UIControlEventTouchUpInside];
                NSLog(@"garfunkel_log:length %lu",(unsigned long)[name lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
                [btn setTitle:name forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//                [btn.titleLabel sizeToFit];
//                btn.titleLabel.adjustsFontSizeToFitWidth = YES;
                btn.layer.cornerRadius = 2.0f;
                btn.layer.borderWidth = 1.0;
                if (j == 0) {
                    btn.selected = YES;
                }
                if(btn.selected){
                    btn.layer.borderColor = [UIColor redColor].CGColor;
                }else{
                    btn.layer.borderColor = [UIColor grayColor].CGColor;
                }
                
                [self.showView addSubview:btn];
                [[self.proBtn objectForKey:[dict objectForKey:@"id"]] addObject:btn];
                //NSLog(@"garfunkel_log:count-%ld",[self.proBtn count]);
                
                btn_x += btn_width + 10;
                
                j++;
            }
            i++;
        }
    }
    
    [self arrage_cart];
    self.showView.contentSize = CGSizeMake(0, btn_y + 40);
}

-(void)arrage_cart{
    if(![WMHelper isNULLOrnil:self.cart_list]){
        //取购物车中的第一个显示
        NSDictionary* cart = [self.cart_list objectAtIndex:0];
        if(![[cart objectForKey:@"spec"] isEqualToString:@""]){
            for(NSString* zid in self.specBtn){
                NSArray* btnList = [self.specBtn objectForKey:zid];
                for(UIButton* btn in btnList){
                    btn.selected = NO;
                    btn.layer.borderColor = [UIColor grayColor].CGColor;
                    NSArray* spec_array = [[cart objectForKey:@"spec"] componentsSeparatedByString:@"_"];
                    for(NSString* spec_id in spec_array){
                        if(btn.tag == [spec_id integerValue]){
                            btn.selected = YES;
                            btn.layer.borderColor = [UIColor redColor].CGColor;
                        }
                    }
                }
            }
        }
        
        if(![[cart objectForKey:@"proper"] isEqualToString:@""]){
            for(NSString* pid in self.proBtn){
                NSArray* btnList = [self.proBtn objectForKey:pid];
                for(UIButton* btn in btnList){
                    btn.selected = NO;
                    btn.layer.borderColor = [UIColor grayColor].CGColor;
                    NSArray* pro_array = [[cart objectForKey:@"proper"] componentsSeparatedByString:@"_"];
                    for(NSString* pro_str in pro_array){
                        NSArray* pid_array = [pro_str componentsSeparatedByString:@","];
                        NSString* ptag = [pid_array objectAtIndex:1];
                        if(btn.tag - 100 == [ptag integerValue]){
                            btn.selected = YES;
                            btn.layer.borderColor = [UIColor redColor].CGColor;
                        }
                    }
                }
            }
        }
    }
    
    [self changePric];
}
-(UIView *)subView{
    if(!_subView){
        _subView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.15, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.7)];
        _subView.backgroundColor = [UIColor whiteColor];
        _subView.layer.cornerRadius = 10.0;
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_subView addGestureRecognizer:tapGesture];
    }
    
    return _subView;
}

-(UIButton *)btnClose{
    if(!_btnClose){
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setImage:[UIImage imageNamed:@"icon-close-gray"] forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
        _btnClose.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnClose;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = _entity.goodsName;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

-(UIScrollView *)showView{
    if(!_showView){
        _showView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.55)];
        //_showView.contentSize = CGSizeMake(0, SCREEN_HEIGHT*0.8);
        //_showView.backgroundColor = [UIColor grayColor];
    }
    return _showView;
}

-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = [NSString stringWithFormat: @"$%@",_entity.price];
        _priceLabel.font = [UIFont systemFontOfSize:24.0];
        _priceLabel.textColor = [UIColor redColor];
        
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceLabel;
}

-(UIButton *)btnAddCart{
    if(!_btnAddCart){
        _btnAddCart = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_btnAddCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnAddCart.layer.backgroundColor = [UIColor redColor].CGColor;
        _btnAddCart.layer.cornerRadius = 5.0f;
        _btnAddCart.tag = 3;
        
        [_btnAddCart addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnAddCart.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnAddCart;
}

-(UILabel *)addNumLabel{
    if(!_addNumLabel){
        _addNumLabel = [[UILabel alloc] init];
        _addNumLabel.text = @"20";
        _addNumLabel.textAlignment = NSTextAlignmentCenter;
        _addNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _addNumLabel;
}

-(UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAdd.tag = 1;
        [_btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
        [_btnAdd addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnAdd;
}

-(UIButton *)btnSub{
    if(!_btnSub){
        _btnSub  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSub.tag = 2;
        [_btnSub setImage:[UIImage imageNamed:@"icon-sub"] forState:UIControlStateNormal];
        [_btnSub addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
        _btnSub.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnSub;
}
@end
