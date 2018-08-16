//
//  StoreCommentV2Cell.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/21.
//
//

#import "StoreCommentV2Cell.h"
#import "StoreCommentReplyCell.h"

@interface StoreCommentV2Cell ()<UITableViewDataSource>
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* avatar;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) NSLayoutConstraint* commentConstraint;
@property(nonatomic,strong) UILabel* labelComment;
@property(nonatomic,strong) UIView* starView;
@property(nonatomic,strong) UILabel* labelFinishTime;
@property(nonatomic,strong) UITableView* subTabelView;
@property(nonatomic,strong) UIImageView* line;
@property(nonatomic,strong) UILabel* emptyRelyComment;
@property(nonatomic,strong) NSMutableArray* arrayStar;
@end

static NSString* const cellIdentifier =  @"cell";

@implementation StoreCommentV2Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self layoutUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark =====================================================  User interface layout
-(void)layoutUI{
    //height = 60+comentHeight+5+tableHeight+5+1
    [self addSubview:self.topView];
    [self.topView addSubview:self.avatar];
    [self.topView addSubview:self.rightView];
    [self.rightView addSubview:self.labelUserName];
    [self.rightView addSubview:self.labelCreateDate];
    [self.rightView addSubview:self.starView];
    [self.rightView addSubview:self.labelFinishTime];
    [self addSubview:self.labelComment];
    [self addSubview:self.subTabelView];
    [self addSubview:self.line];
    
    self.arrayStar =[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20*i, 0, 15, 15);
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-star-default"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-star-enter"] forState:UIControlStateSelected];
        [self.starView addSubview:btn];
        [self.arrayStar addObject:btn];
    }
    
    NSArray* formats = @[@"H:|-defEdge-[topView]-defEdge-|",@"H:|-leftEdge-[labelComment]-leftEdge-|",@"H:|-15-[tableView]-15-|",@"H:|-defEdge-[line]-defEdge-|",
                         @"V:|-defEdge-[topView(==topHeight)][labelComment][tableView]-9-[line(==1)]-defEdge-|",
                         @"H:|-leftEdge-[avatar(==avatarSize)]-leftEdge-[rightView]-leftEdge-|", @"V:|-topEdge-[avatar(==avatarSize)]", @"V:|-topEdge-[rightView]-defEdge-|",
                         @"H:|-defEdge-[labelUserName][labelCreateDate(labelUserName)]-defEdge-|",@"H:|-defEdge-[starView(==100)][labelFinishTime]-leftEdge-|",
                         @"V:|-defEdge-[labelUserName(==lineHeight)]-space-[starView(==lineHeight)]-space-|", @"V:|-defEdge-[labelCreateDate(==lineHeight)]", @"V:[labelFinishTime(==lineHeight)]-space-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"space":@(5), @"avatarSize":@(35), @"lineHeight":@(20),
                               @"topHeight":@(60),};
    NSDictionary* views = @{ @"topView":self.topView, @"labelComment":self.labelComment, @"tableView":self.subTabelView, @"line":self.line,
                             @"avatar":self.avatar, @"rightView":self.rightView,
                             @"labelUserName":self.labelUserName, @"labelCreateDate":self.labelCreateDate, @"starView":self.starView, @"labelFinishTime":self.labelFinishTime
                             };
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @" %@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    self.commentConstraint = [NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f];
    [self.labelComment addConstraint:self.commentConstraint];
}

#pragma mark =====================================================  property package

-(void)setEntity:(MComment *)entity{
    if(entity){
        _entity = entity;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:entity.avatar] placeholderImage:[UIImage imageNamed: @"Icon-60"]];
        self.labelUserName.text = entity.userName;
        self.labelFinishTime.text = entity.finishTime;
        self.labelCreateDate.text = entity.createDate;
        self.labelComment.text = entity.comment;
        if(self.commentConstraint){
            [self.labelComment removeConstraint:self.commentConstraint];
        }
        self.commentConstraint = [NSLayoutConstraint constraintWithItem:self.labelComment attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.entity.commentHeight];
        self.commentConstraint.priority = 999;
        [self.labelComment addConstraint:self.commentConstraint];
        
        NSInteger star = [entity.scoreToal integerValue];
        for (UIButton *btn in self.arrayStar) {
            if(btn.tag< star){
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
        }
        
        if(![WMHelper isEmptyOrNULLOrnil:self.entity.replyComment]){
            self.subTabelView.rowHeight = self.entity.replyCommentHeight;
        }
        
        [self.subTabelView reloadData];
    }
    
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.entity.replyComment){
        return 1;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreCommentReplyCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.replyComment = self.entity.replyComment;
    return cell;
}

#pragma mark =====================================================  property pacakge
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}



-(UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc]init];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 35/2.f;
        _avatar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _avatar;
}

-(UIView *)rightView{
    if(!_rightView){
        _rightView = [[UIView alloc]init];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}

-(UILabel *)labelUserName{
    if(!_labelUserName){
        _labelUserName =[[UILabel alloc]init];
        _labelUserName.textColor = [UIColor colorWithRed:142/255.f green:142/255.f blue:142/255.f alpha:1.0];
        _labelUserName.font = [UIFont systemFontOfSize:14.f];
        _labelUserName.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelUserName;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate =[[UILabel alloc]init];
        _labelCreateDate.textColor = [UIColor colorWithRed:142/255.f green:142/255.f blue:142/255.f alpha:1.0];
        _labelCreateDate.font = [UIFont systemFontOfSize:12.f];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
        _labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCreateDate;
}

-(UILabel *)labelComment{
    if(!_labelComment){
        _labelComment = [[UILabel alloc]init];
        _labelComment.numberOfLines = 0;
        _labelComment.font =[UIFont systemFontOfSize:14.f];
        _labelComment.preferredMaxLayoutWidth = self.frame.size.width - 20;
        _labelComment.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelComment;
}

-(UIView *)starView{
    if(!_starView){
        _starView = [[UIView alloc]init];
        _starView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _starView;
}

-(UILabel *)labelFinishTime{
    if(!_labelFinishTime){
        _labelFinishTime = [[UILabel alloc]init];
        _labelFinishTime.font =[UIFont systemFontOfSize:14.f];
        _labelFinishTime.textColor = [UIColor grayColor];
        _labelFinishTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelFinishTime;
}

-(UITableView *)subTabelView{
    if(!_subTabelView){
        _subTabelView = [[UITableView alloc]init];
        _subTabelView.dataSource = self;
        _subTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
         _subTabelView.scrollEnabled =NO;
        [_subTabelView registerClass:[StoreCommentReplyCell class] forCellReuseIdentifier:cellIdentifier];
        _subTabelView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _subTabelView;
}

-(UIImageView *)line{
    if(!_line){
        _line =[[UIImageView alloc]init];
        _line.backgroundColor =theme_line_color;
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
} @end
